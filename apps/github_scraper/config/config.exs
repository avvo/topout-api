use Mix.Config

import_config "#{Mix.env}.exs"

config :quantum, :github_scraper,
  cron: [
    "* * * * *":      &GithubScraper.scrape/0
  ]