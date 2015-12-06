defmodule DistanceApiMatrix do
  @base_url "https://maps.googleapis.com/maps/api/distancematrix/json?"

  def get_distances(params, options \\ %{}) do
    %{origins: list_to(params.origins), destinations: list_to(params.destinations)}
    |> Map.merge(options)
    |> URI.encode_query
    |> build_url
    |> get
  end

  defp list_to(params) when is_list(params), do: Enum.join(params, "|")

  defp build_url(params), do: @base_url <> params

  defp get(url) do
    {:ok, %HTTPoison.Response{status_code: 200, body: body}} = HTTPoison.get(url, [], [])

    body |> Poison.decode!
  end
end
