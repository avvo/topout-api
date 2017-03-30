defmodule ScoringApi.LeaderBoardSummary do
  use ScoringApi.Web, :model

  schema "leader_board_summary" do
    field :display_name, :string
    field :count, :integer

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:display_name, :count])
    |> validate_required([:display_name, :count])
  end
end
