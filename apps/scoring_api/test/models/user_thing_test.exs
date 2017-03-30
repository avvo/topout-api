defmodule ScoringApi.UserThingTest do
  use ScoringApi.ModelCase

  alias ScoringApi.UserThing

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = UserThing.changeset(%UserThing{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = UserThing.changeset(%UserThing{}, @invalid_attrs)
    refute changeset.valid?
  end
end
