defmodule ScoringApi.LeaderBoardSummaryControllerTest do
  use ScoringApi.ConnCase

  alias ScoringApi.LeaderBoardSummary
  @valid_attrs %{count: 42, display_name: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, leader_board_summary_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

end
