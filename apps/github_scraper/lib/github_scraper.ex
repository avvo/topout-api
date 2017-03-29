defmodule GithubScraper do

  alias HTTPoison, as: Http
  alias Poison, as: Json

  use Http.Base

  @endpoint "https://api.github.com/graphql"
  @testquery '{"query": "{ viewer { login name } }"}'

  @body @testquery
  @headers [
    "Authorization": "Bearer #{Application.get_env(:ex_github, :access_token)}"
  ]

  # WARNING: you must have an environment variable named GITHUB_ACCESS_TOKEN defined which contains
  #          a valid github access token or this will fail
  def scrape do
    {:ok, response} = post(@endpoint, @body, @headers)
  end
end
