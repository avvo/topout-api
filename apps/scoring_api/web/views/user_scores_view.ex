defmodule ScoringApi.UserScoresView do
  use ScoringApi.Web, :view

  def render("index.json", %{user_scores: user_scores}) do
    %{data: render_many(user_scores, ScoringApi.UserScoresView, "user_scores.json")}
  end

  def render("show.json", %{user_scores: user_scores}) do
    %{data: render_one(user_scores, ScoringApi.UserScoresView, "user_scores.json")}
  end

  def render("user_scores.json", %{user_scores: user_scores}) do
    %{id: user_scores.id,
      github_id: user_scores.github_id}
  end
end
