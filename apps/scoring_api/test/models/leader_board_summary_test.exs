defmodule ScoringApi.LeaderBoardSummaryTest do
  use ScoringApi.ModelCase

  alias ScoringApi.LeaderBoardSummary

  @valid_attrs %{score: 42, display_name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = LeaderBoardSummary.changeset(%LeaderBoardSummary{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = LeaderBoardSummary.changeset(%LeaderBoardSummary{}, @invalid_attrs)
    refute changeset.valid?
  end
end
