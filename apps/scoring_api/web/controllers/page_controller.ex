defmodule ScoringApi.PageController do
  use ScoringApi.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
