defmodule ScoreReport do
  @moduledoc false
  alias ScoringApi.GithubCommit

  def submit(commits) do
   commits |> inspect(pretty: true) |> IO.puts
    Enum.each(commits, fn(commit) ->
        try do
           ScoringApi.Repo.insert(commit)
        rescue
           e in Ecto.ConstraintError -> e
        end
    end)
  end
end
