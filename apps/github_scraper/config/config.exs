# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

import_config "#{Mix.env}.exs"

config :quantum, :github_scraper,
  cron: [
    "* * * * *":      &GithubScraper.scrape/0
  ]