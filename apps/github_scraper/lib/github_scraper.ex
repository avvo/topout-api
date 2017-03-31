defmodule GithubScraper do

  alias HTTPoison, as: Http
  alias Poison, as: Json
  alias ScoreReport.Commit

  use Http.Base

  @endpoint "https://api.github.com/graphql"
  @max_edges 100
  @org_name "avvo"
  @default_repositories_arguments "first: 3"

  defp headers(token), do: ["Authorization": "Bearer #{token}"]

  defp edges_cnt(cnt \\ @max_edges), do: max(1, min(cnt, @max_edges))

  defp viewer_query, do: "{viewer{login}}"

  defp repos_query(org_name \\ "avvo", repos_cnt \\ 15) do
    """
      {
        organization(login: "#{org_name}") {
          repositories(first: #{repos_cnt}) {
            edges {
              node {
                name
              }
            }
          }
        }
      }
    """
  end

#repositories(last: #{edges_cnt(10)}, orderBy: {field:UPDATED_AT, direction:DESC}) {
  defp commits_query(org_name \\ @org_name, max_branches \\ @max_edges, repositories_arguments \\ @default_repositories_arguments) do
    """
      {
        organization(login: "#{org_name}") {
          repositories(#{repositories_arguments}) {
            totalCount
            edges {
              cursor
              node {
                name
                ... on Repository {
                  refs(refPrefix: "refs/heads/", first: #{edges_cnt(max_branches)}) {
                    edges {
                      node {
                        target {
                          ... on Commit {
                            history(first: #{edges_cnt(5)}) {
                              edges {
                                node {
                                  author {
                                    user {
                                      databaseId
                                      name
                                      email
                                    }
                                  }
                                  id
                                }
                              }
                            }
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    """
  end

#    todo GithubScraper.iterative_scrape(0,100)
  def iterative_scrape(repositories_queried, total_repositories) when (total_repositories - repositories_queried) > 0 do
    IO.puts("\n\n\nrecursive version of iterative scrape. (total_repositories - repositories_queried) = #{total_repositories - repositories_queried}")
    repositories_arguments = "last: 1"
    scrape(@org_name, 2, repositories_arguments)
    iterative_scrape(repositories_queried + 50, total_repositories) # TODO: make repositories_queried right!
  end

  def iterative_scrape(repositories_queried, total_repositories) do
    IO.puts("\n\n\nfinal version of iterative scrape. (total_repositories - repositories_queried) = #{total_repositories - repositories_queried}")
#    repositories_arguments = "last: 1"
#    scrape(@org_name, 2, repositories_arguments)
  end









  # WARNING: you must have an environment variable named GITHUB_ACCESS_TOKEN
  # defined which contains a valid github access token or this will fail
  def scrape(org_name \\ @org_name, max_branches \\ @max_edges, repositories_arguments \\ @default_repositories_arguments) do
    query = commits_query(org_name, max_branches, repositories_arguments)
    case post_query(query) do
      {:ok, %Http.Response{status_code: 200, body: body}} ->
        body
        |> Json.decode!
        |> report_result
      {:ok, response} ->
        report_unexpected(query, response)
      failure ->
        report_failure(query, failure)
    end
  end

  defp post_query(query) do
    with \
      token <- System.get_env("GITHUB_ACCESS_TOKEN"),
      {:ok, body} <- %{query: query} |> Json.encode \
    do
      IO.puts("QUERY: #{ip query}")
      post(@endpoint, body, headers(token))
    end
  end

  defp report_result(result_map) do
    # TODO: convert result JSON to ScoreReport struct
    IO.puts("RESULT: #{ip result_map}")
    result_map
    |> create_commits
    |> ScoreReport.submit
    :ok
  end

  defp create_commits(
    %{"data" => %{"organization" => %{"repositories" => %{"edges" => repo_edges}}}}
  ) do
    repo_edges
    |> Enum.reduce([], &do_repo_edge(&1, &2))
  end

  defp do_repo_edge(
    %{"node" => %{"name" => repo_name, "refs" => %{"edges" => branch_edges}}},
    acc
  ) do
    branch_edges
    |> Enum.reduce(acc, &do_branch_edge(&1, &2, repo_name))
  end

  defp do_branch_edge(
    %{"node" => %{"target" => %{"history" => %{"edges" => commit_edges}}}},
    acc,
    repo_name
  ) do
    commit_edges
    |> Enum.reduce(acc, fn(commit_edge, acc) ->
      accumulate_commit(create_commit(commit_edge, repo_name), acc)
    end)
  end

  defp accumulate_commit(nil, acc), do: acc
  defp accumulate_commit(commit, acc), do: [commit | acc]

  defp create_commit(
    %{"node" => %{"id" => commit_id, "author" => %{"user" => commit_user}}},
    repo_name
  ) do
    case commit_user do
      %{"databaseId" => databaseId} ->
        %ScoringApi.GithubCommit{
          commit_id: commit_id,
          display_name: commit_user["name"],
          email: commit_user["email"],
          github_id: Integer.to_string(databaseId),
          repo: repo_name
        }
      _ ->
        nil
    end
  end

  defp report_unexpected(query, response) do
    IO.puts("QUERY: #{ip query} GOT UNEXPECTED RESPONSE: #{ip response}")
    :error
  end

  defp report_failure(query, failure) do
    IO.puts("QUERY: #{ip query} FAILED: #{ip failure}")
    :error
  end

  defp ip(v), do: inspect(v, pretty: true)
end
