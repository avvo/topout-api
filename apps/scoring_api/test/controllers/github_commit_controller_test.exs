defmodule ScoringApi.GithubCommitControllerTest do
  use ScoringApi.ConnCase

  alias ScoringApi.GithubCommit
  @valid_attrs %{commit_id: "some content", display_name: "some content", email: "some content", github_id: "some content", repo: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, github_commit_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    github_commit = Repo.insert! %GithubCommit{ commit_id: "abcdefg" }
    conn = get conn, github_commit_path(conn, :show, github_commit)
    assert json_response(conn, 200)["data"] == %{"id" => github_commit.id,
      "github_id" => github_commit.github_id,
      "email" => github_commit.email,
      "display_name" => github_commit.display_name,
      "commit_id" => github_commit.commit_id,
      "repo" => github_commit.repo}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, github_commit_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, github_commit_path(conn, :create), github_commit: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(GithubCommit, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, github_commit_path(conn, :create), github_commit: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    github_commit = Repo.insert! %GithubCommit{commit_id: "abcdefg"}
    conn = put conn, github_commit_path(conn, :update, github_commit), github_commit: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(GithubCommit, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    github_commit = Repo.insert! %GithubCommit{commit_id: "abcdefg"}
    conn = put conn, github_commit_path(conn, :update, github_commit), github_commit: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    github_commit = Repo.insert! %GithubCommit{commit_id: "abcdefg"}
    conn = delete conn, github_commit_path(conn, :delete, github_commit)
    assert response(conn, 204)
    refute Repo.get(GithubCommit, github_commit.id)
  end

#  test "unique commit_ids are required" do
#    commit_id = "abcdefghijklmnopqrstuvwxyz"
#    attrs = %{commit_id: commit_id, display_name: "some content", email: "some content", github_id: "some content", repo: "some content"}
##    github_commit = Repo.insert! %GithubCommit{ commit_id: commit_id, display_name: "some content", email: "some content", github_id: "some content", repo: "some content" }
#    github_commit = Repo.insert! struct(GithubCommit, attrs)
#
#    conn = post conn, github_commit_path(conn, :create), github_commit: attrs
#    assert response(conn, 201)
#
#    conn = post conn, github_commit_path(conn, :create), github_commit: attrs
#    assert response(conn, 418)
#  end
end
