defmodule Release.Tasks do
  @moduledoc false
  
  def migrate do
    {:ok, _} = Application.ensure_all_started(:scoring_api)

    path = Application.app_dir(:scoring_api, "priv/repo/migrations")

    Ecto.Migrator.run(ScoringApi.Repo, path, :up, all: true)
  end

  def help(echo) do
    IO.puts("Hello from the ScoringApi Leaderboard Summary Controller: #{echo}")
    echo
  end
end