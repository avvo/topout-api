defmodule ScoringApi.UserThingControllerTest do
  use ScoringApi.ConnCase

  alias ScoringApi.UserThing
  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, user_thing_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    user_thing = Repo.insert! %UserThing{}
    conn = get conn, user_thing_path(conn, :show, user_thing)
    assert json_response(conn, 200)["data"] == %{"id" => user_thing.id,
      "name" => user_thing.name}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, user_thing_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, user_thing_path(conn, :create), user_thing: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(UserThing, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, user_thing_path(conn, :create), user_thing: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    user_thing = Repo.insert! %UserThing{}
    conn = put conn, user_thing_path(conn, :update, user_thing), user_thing: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(UserThing, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    user_thing = Repo.insert! %UserThing{}
    conn = put conn, user_thing_path(conn, :update, user_thing), user_thing: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    user_thing = Repo.insert! %UserThing{}
    conn = delete conn, user_thing_path(conn, :delete, user_thing)
    assert response(conn, 204)
    refute Repo.get(UserThing, user_thing.id)
  end
end
