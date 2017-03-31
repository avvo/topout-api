defmodule ScoringApi.Router do
  use ScoringApi.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug Corsica, origins: "*"
    plug :accepts, ["json"]
  end

  scope "/", ScoringApi do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", ScoringApi do
    pipe_through :api
    resources "/commits", GithubCommitController
    get "/leaderboard_summary", LeaderBoardSummaryController, :index
    options "/leaderboard_summary", LeaderBoardSummaryController, :options
  end
end
