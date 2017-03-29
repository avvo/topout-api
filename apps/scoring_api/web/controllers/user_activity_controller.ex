defmodule ScoringApi.UserActivityController do
  use ScoringApi.Web, :controller

  def post(conn, _params) do
    render conn, "index.html"
  end
end
