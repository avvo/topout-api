defmodule ScoringApi.GithubCommitTest do
  use ScoringApi.ModelCase

  alias ScoringApi.GithubCommit

  @valid_attrs %{commit_id: "abcdefgh", display_name: "some content", email: "some content", github_id: "some content", repo: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = GithubCommit.changeset(%GithubCommit{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = GithubCommit.changeset(%GithubCommit{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "unique commit_id is enforced" do
    %GithubCommit{}
    |> GithubCommit.changeset(@valid_attrs)
    |> Repo.insert!

    badCommit = %GithubCommit{}
    |> GithubCommit.changeset(@valid_attrs)

    assert {:error, changeset} = Repo.insert(badCommit)
    assert changeset.errors[:commit_id] == {"has already been taken", []}
  end
end
