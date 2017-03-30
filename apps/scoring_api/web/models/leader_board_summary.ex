defmodule ScoringApi.LeaderBoardSummary do
  use ScoringApi.Web, :model

  schema "leader_board_summary" do
    field :display_name, :string
    field :score, :integer

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:display_name, :score])
    |> validate_required([:display_name, :score])
  end
end
