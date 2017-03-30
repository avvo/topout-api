defmodule ScoringApi.LeaderBoardSummaryView do
  use ScoringApi.Web, :view

  def render("index.json", %{leader_board_summary: leader_board_summary}) do
    %{data: render_many(leader_board_summary, ScoringApi.LeaderBoardSummaryView, "leader_board_summary.json")}
  end

  def render("show.json", %{leader_board_summary: leader_board_summary}) do
    %{data: render_one(leader_board_summary, ScoringApi.LeaderBoardSummaryView, "leader_board_summary.json")}
  end

  def render("leader_board_summary.json", %{leader_board_summary: leader_board_summary}) do
    %{id: leader_board_summary.id,
      display_name: leader_board_summary.display_name,
      score: leader_board_summary.score}
  end
end
