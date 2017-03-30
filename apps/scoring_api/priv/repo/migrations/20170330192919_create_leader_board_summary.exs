defmodule ScoringApi.Repo.Migrations.CreateLeaderBoardSummary do
  use Ecto.Migration

  def change do
    create table(:leader_board_summary) do
      add :display_name, :string
      add :count, :integer

      timestamps()
    end

  end
end
