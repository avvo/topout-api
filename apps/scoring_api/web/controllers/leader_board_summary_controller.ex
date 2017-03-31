defmodule ScoringApi.LeaderBoardSummaryController do
  use ScoringApi.Web, :controller

  alias ScoringApi.LeaderBoardSummary

  def index(conn, _params) do
    # TODO: Make this perform a query against the github_commits table to calculate the real leaderboard
    # leader_board_summary = Repo.all(LeaderBoardSummary)

    leader_board_summary = ScoringApi.Repo.all(
      from c in ScoringApi.GithubCommit, 
        group_by: [:github_id, :display_name], 
        select: {c.display_name, c.github_id, count(c.id)},
        order_by: [desc: :count]
        )
      |> Enum.map(fn({display_name, id, score}) -> %{id: id, display_name: display_name, score: score} end)

    render(conn, "index.json", leader_board_summary: leader_board_summary)
  end

  def help do
    IO.puts("Hello from the ScoringApi Leaderboard Summary Controller")
    "The Result"
  end

end
