defmodule DistanceMatrixApi.Mixfile do
  use Mix.Project

  @description """
    Google Distance Matrix API Library for Elixir
  """

  def project do
    [app: :distance_api_matrix,
     version: "0.0.1",
     elixir: "~> 1.0",
     name: "DistanceMatrixApi",
     description: @description,
     package: package,
     deps: deps,
     source_url: "https://github.com/C404/distance-api-matrix"]
  end

  def application do
    [applications: [:logger, :httpoison]]
  end

  defp deps do
    [{:httpoison, "~> 0.8.0"},
    {:poison, "~> 1.5"},
    {:exvcr, "~> 0.6", only: :test}]
  end

  defp package do
    [ maintainers: ["C404"],
      licenses: ["MIT"],
      links: %{"Github" => "https://github.com/C404/distance-api-matrix"} ]
  end
end
