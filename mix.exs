defmodule DistanceApiMatrix.Mixfile do
  use Mix.Project

  @description """
    Google Distance Matrix API Library for Elixir
  """

  def project do
    [app: :distance_api_matrix,
     version: "0.0.1",
     elixir: "~> 1.0",
     name: "DistanceApiMatrix",
     description: @description,
     package: package,
     deps: deps,
     source_url: "https://github.com/C404/distance-api-matrix"]
  end

  def application do
    [applications: [:logger, :httpoison]]
  end

  defp deps do
    [{:httpoison, "~> 0.8.0"}, {:poison, "~> 1.5"}]
  end

  defp package do
    [ maintainers: ["Thibault Hagler"],
      licenses: ["MIT"],
      links: %{"Github" => "https://github.com/C404/distance-api-matrix"} ]
  end
end
