defmodule ScoringApi.UserScoresControllerTest do
  use ScoringApi.ConnCase

  alias ScoringApi.UserScores
  @valid_attrs %{github_id: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, user_scores_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    user_scores = Repo.insert! %UserScores{}
    conn = get conn, user_scores_path(conn, :show, user_scores)
    assert json_response(conn, 200)["data"] == %{"id" => user_scores.id,
      "github_id" => user_scores.github_id}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, user_scores_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, user_scores_path(conn, :create), user_scores: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(UserScores, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, user_scores_path(conn, :create), user_scores: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    user_scores = Repo.insert! %UserScores{}
    conn = put conn, user_scores_path(conn, :update, user_scores), user_scores: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(UserScores, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    user_scores = Repo.insert! %UserScores{}
    conn = put conn, user_scores_path(conn, :update, user_scores), user_scores: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    user_scores = Repo.insert! %UserScores{}
    conn = delete conn, user_scores_path(conn, :delete, user_scores)
    assert response(conn, 204)
    refute Repo.get(UserScores, user_scores.id)
  end
end
