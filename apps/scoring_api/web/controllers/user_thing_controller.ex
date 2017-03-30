defmodule ScoringApi.UserThingController do
  use ScoringApi.Web, :controller

  alias ScoringApi.UserThing

  def index(conn, _params) do
    user_things = Repo.all(UserThing)
    render(conn, "index.json", user_things: user_things)
  end

  def create(conn, %{"user_thing" => user_thing_params}) do
    changeset = UserThing.changeset(%UserThing{}, user_thing_params)

    case Repo.insert(changeset) do
      {:ok, user_thing} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", user_thing_path(conn, :show, user_thing))
        |> render("show.json", user_thing: user_thing)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(ScoringApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user_thing = Repo.get!(UserThing, id)
    render(conn, "show.json", user_thing: user_thing)
  end

  def update(conn, %{"id" => id, "user_thing" => user_thing_params}) do
    user_thing = Repo.get!(UserThing, id)
    changeset = UserThing.changeset(user_thing, user_thing_params)

    case Repo.update(changeset) do
      {:ok, user_thing} ->
        render(conn, "show.json", user_thing: user_thing)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(ScoringApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user_thing = Repo.get!(UserThing, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(user_thing)

    send_resp(conn, :no_content, "")
  end
end
