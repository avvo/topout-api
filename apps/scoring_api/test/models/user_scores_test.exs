defmodule ScoringApi.UserScoresTest do
  use ScoringApi.ModelCase

  alias ScoringApi.UserScores

  @valid_attrs %{github_id: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = UserScores.changeset(%UserScores{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = UserScores.changeset(%UserScores{}, @invalid_attrs)
    refute changeset.valid?
  end
end
