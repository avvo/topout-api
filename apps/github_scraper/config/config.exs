use Mix.Config

config :quantum, :github_scraper,
  cron: [
    "* * * * *": &GithubScraper.scrape/0
  ]

config :ex_github, access_token: "THIS_IS_MY_TOKEN" ## System.get_env("GITHUB_ACCESS_TOKEN")

import_config "#{Mix.env}.exs"
