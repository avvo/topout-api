defmodule GithubScraperTest do
  use ExUnit.Case
  doctest GithubScraper

  @tag :external
  describe "scrape" do
    test "returns results successfully" do
      assert :ok == GithubScraper.scrape
    end
  end
end
