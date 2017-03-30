defmodule GithubScraper do

  alias HTTPoison, as: Http
  alias Poison, as: Json

  use Http.Base

  @endpoint "https://api.github.com/graphql"
  @max_edges 100

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

  defp commits_query(org_name \\ "avvo", max_branches \\ @max_edges) do
    """
      {
        organization(login: "#{org_name}") {
          repositories(first: #{edges_cnt(3)}) {
            edges {
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
                                      id
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


  # WARNING: you must have an environment variable named GITHUB_ACCESS_TOKEN
  # defined which contains a valid github access token or this will fail
  def scrape() do
    query = commits_query()
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
      token <- Application.get_env(:ex_github, :access_token),
      {:ok, body} <- %{query: query} |> Json.encode \
    do
      IO.puts("QUERY: #{ip query}")
      post(@endpoint, body, headers(token))
    end
  end

  defp report_result(map) do
    IO.puts("RESULT: #{ip map}")
    # TODO: call scoring api
    :ok
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
