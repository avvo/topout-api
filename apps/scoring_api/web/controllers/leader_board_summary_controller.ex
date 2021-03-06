defmodule ScoringApi.LeaderBoardSummaryController do
  use ScoringApi.Web, :controller

  alias ScoringApi.LeaderBoardSummary

  def index(conn, _params) do
    limit = if Map.has_key?(_params, "limit") do
      _params["limit"]
    else
      20
    end

    leader_board_summary = ScoringApi.Repo.all(
      from c in ScoringApi.GithubCommit,
        limit: ^limit,
        group_by: [:github_id, :display_name], 
        select: {c.display_name, c.github_id, count(c.id)},
        order_by: [desc: :count]
        )
      |> Enum.map(fn({display_name, id, score}) -> %{id: id, display_name: display_name, score: score} end)

    render(conn, "index.json", leader_board_summary: leader_board_summary)
  end

end
