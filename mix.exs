defmodule TopoutApi.Mixfile do
  use Mix.Project

  def project do
    [
     app: :topout_api,
     version: "0.1.0",
     apps_path: "apps",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  defp deps do
    [
      { :mix_docker, "~> 0.3.0" },
      {:phoenix_ecto, "~> 3.0"}
    ]
  end
end
