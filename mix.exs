defmodule DistanceMatrixApi.Mixfile do
  use Mix.Project

  @project_url "https://github.com/C404/distance-matrix-api"

  def project do
    [
      app: :distance_matrix_api,
      version: "2.0.2",
      elixir: "~> 1.0",
      name: "DistanceMatrixApi",
      description: description(),
      package: package(),
      deps: deps(),
      source_url: project_url
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
    [{:httpoison, "~> 0.13"}, {:jason, "~> 1.0"}, {:exvcr, "~> 0.6", only: [:dev, :test]}]
  end

  defp package do
    [
      files: ~w(lib mix.exs README.md LICENSE VERSION),
      maintainers: ["C404", "mithereal"],
      licenses: ["MIT"],
      links: %{"Github" => project_url}
    ]
  end
end
