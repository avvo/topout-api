defmodule ScoreReport do
  @moduledoc false

  defmodule Commit do
    @type t :: %__MODULE__{
      commit_id: String.t, # required
      display_name: String.t,
      email: String.t,
      github_id: String.t, # required
      repo: String.t # required
    }

    defstruct [
      :commit_id,
      :display_name,
      :email,
      :github_id,
      :repo
    ]
  end

  def submit(commits) do
   commits |> inspect(pretty: true) |> IO.puts
    # TODO call scoring API
  end
end
