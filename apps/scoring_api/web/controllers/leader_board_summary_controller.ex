defmodule ScoringApi.LeaderBoardSummaryController do
  use ScoringApi.Web, :controller

  alias ScoringApi.LeaderBoardSummary

  def index(conn, _params) do
    # TODO: Make this perform a query against the github_commits table to calculate the real leaderboard
    # leader_board_summary = Repo.all(LeaderBoardSummary)

    leader_board_summary = [
      %{:id => 1, :display_name => "Adams", :count => 120},
      %{:id => 1, :display_name => "Baker", :count => 97},
      %{:id => 1, :display_name => "Glacier Peak", :count => 80},
      %{:id => 1, :display_name => "Hood", :count => 127},
      %{:id => 1, :display_name => "Shasta", :count => 7}
    ]

    render(conn, "index.json", leader_board_summary: leader_board_summary)
  end

end
