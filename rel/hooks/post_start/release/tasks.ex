defmodule Release.Tasks do
  def migrate do
    {:ok, _} = Application.ensure_all_started(:scoring_api)

    path = Application.app_dir(:scoring_api, "priv/repo/migrations")

    Ecto.Migrator.run(ScoringApi.Repo, path, :up, all: true)
  end
end