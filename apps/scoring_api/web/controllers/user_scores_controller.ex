defmodule ScoringApi.UserScoresController do
  use ScoringApi.Web, :controller

  alias ScoringApi.UserScores

  def index(conn, _params) do
    user_scores = Repo.all(UserScores)
    render(conn, "index.json", user_scores: user_scores)
  end

  def create(conn, %{"user_scores" => user_scores_params}) do
    changeset = UserScores.changeset(%UserScores{}, user_scores_params)

    case Repo.insert(changeset) do
      {:ok, user_scores} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", user_scores_path(conn, :show, user_scores))
        |> render("show.json", user_scores: user_scores)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(ScoringApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user_scores = Repo.get!(UserScores, id)
    render(conn, "show.json", user_scores: user_scores)
  end

  def update(conn, %{"id" => id, "user_scores" => user_scores_params}) do
    user_scores = Repo.get!(UserScores, id)
    changeset = UserScores.changeset(user_scores, user_scores_params)

    case Repo.update(changeset) do
      {:ok, user_scores} ->
        render(conn, "show.json", user_scores: user_scores)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(ScoringApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user_scores = Repo.get!(UserScores, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(user_scores)

    send_resp(conn, :no_content, "")
  end
end
