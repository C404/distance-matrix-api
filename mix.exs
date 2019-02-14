defmodule DistanceMatrixApi.Mixfile do
  use Mix.Project

  def project do
    [
      app: :distance_api_matrix,
      version: "2.0.1",
      elixir: "~> 1.0",
      name: "DistanceMatrixApi",
      description: description(),
      package: package(),
      deps: deps(),
      source_url: "https://github.com/C404/distance-api-matrix"
    ]
  end

  def application do
    [applications: [:logger, :httpoison]]
  end

  defp description do
    """
    Google Distance Matrix API Library for Elixir
    """
  end

  defp deps do
    [{:httpoison, "~> 0.13"}, {:jason, "~> 1.0"}, {:exvcr, "~> 0.6"}]
  end

  defp package do
    [
      files: ~w(lib mix.exs README.md LICENSE VERSION),
      maintainers: ["C404"],
      licenses: ["MIT"],
      links: %{"Github" => "https://github.com/C404/distance-api-matrix"}
    ]
  end
end
