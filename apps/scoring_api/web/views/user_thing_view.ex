defmodule ScoringApi.UserThingView do
  use ScoringApi.Web, :view

  def render("index.json", %{user_things: user_things}) do
    %{data: render_many(user_things, ScoringApi.UserThingView, "user_thing.json")}
  end

  def render("show.json", %{user_thing: user_thing}) do
    %{data: render_one(user_thing, ScoringApi.UserThingView, "user_thing.json")}
  end

  def render("user_thing.json", %{user_thing: user_thing}) do
    %{id: user_thing.id,
      name: user_thing.name}
  end
end
