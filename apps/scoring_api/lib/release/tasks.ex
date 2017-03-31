defmodule Release.Tasks do
  @moduledoc false
  
  def migrate do
    {:ok, _} = Application.ensure_all_started(:scoring_api)

    path = Application.app_dir(:scoring_api, "priv/repo/migrations")

    Ecto.Migrator.run(ScoringApi.Repo, path, :up, all: true)
  end

  def help do
    IO.puts("This is a task to aid in running Ecto migrations.")
  end
end