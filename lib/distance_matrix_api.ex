defmodule DistanceMatrixApi do
  @base_url "https://maps.googleapis.com/maps/api/distancematrix/json?"
  @separator "|"

  def get_distances(params, options \\ %{}) do
    %{origins: addresses_to(params[:origins]),
      destinations: addresses_to(params[:destinations])} |> make_request(options)
  end

  def get_distances_by_coords(params, options \\ %{}) do
    %{origins: coords_to(params[:origins]),
      destinations: coords_to(params[:destinations])} |> make_request(options)
  end

  defp make_request(params, options) do
    params
    |> Map.merge(options)
    |> URI.encode_query
    |> build_url
    |> get!
  end

  defp coords_to(params) do
    params
    |> Enum.reduce("", fn(x, acc) -> "#{acc}#{@separator}#{x.lat},#{x.long}" end)
    |> String.slice(1..-1)
  end

  defp addresses_to(params) when is_list(params), do: Enum.join(params, @separator)

  defp build_url(params), do: @base_url <> params

  defp get!(url) do
    {:ok, %HTTPoison.Response{status_code: 200, body: body}} = HTTPoison.get(url, [], [])

    body |> Poison.decode!
  end
end
