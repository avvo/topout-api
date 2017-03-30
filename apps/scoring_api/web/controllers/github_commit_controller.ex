defmodule ScoringApi.GithubCommitController do
  use ScoringApi.Web, :controller

  alias ScoringApi.GithubCommit

  def index(conn, _params) do
    github_commits = Repo.all(GithubCommit)
    render(conn, "index.json", github_commits: github_commits)
  end

  def create(conn, %{"github_commits" => []}) do
    render(conn, "index.json", github_commits: [])
  end

  def create(conn, %{"github_commits" => [_|_] = github_commit_params}) do
    insert_commit = fn(github_commit) ->
      changeset = GithubCommit.changeset(%GithubCommit{}, github_commit)
      case Repo.insert(changeset) do
        {:ok, github_commit} -> github_commit
        {:error, _} -> nil
      end
    end

    result = (github_commit_params
    |> Enum.map(insert_commit)
    |> IO.inspect()
    |> Enum.reject(fn(insert_results) -> is_nil(insert_results) end))

    render(conn, "index.json", github_commits: result)
  end

  def create(conn, %{"github_commit" => github_commit_params}) do
    changeset = GithubCommit.changeset(%GithubCommit{}, github_commit_params)

    case Repo.insert(changeset) do
      {:ok, github_commit} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", github_commit_path(conn, :show, github_commit))
        |> render("show.json", github_commit: github_commit)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(ScoringApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    github_commit = Repo.get!(GithubCommit, id)
    render(conn, "show.json", github_commit: github_commit)
  end

  def update(conn, %{"id" => id, "github_commit" => github_commit_params}) do
    github_commit = Repo.get!(GithubCommit, id)
    changeset = GithubCommit.changeset(github_commit, github_commit_params)

    case Repo.update(changeset) do
      {:ok, github_commit} ->
        render(conn, "show.json", github_commit: github_commit)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(ScoringApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    github_commit = Repo.get!(GithubCommit, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(github_commit)

    send_resp(conn, :no_content, "")
  end
end
