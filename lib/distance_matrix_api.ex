defmodule DistanceMatrixApi do
  @moduledoc """
  Provides functions to interact with Google Distance Matrix API.
  """

  @base_url "https://maps.googleapis.com/maps/api/distancematrix/json?"
  @separator "|"

  @doc """
  Expected usage :
    travels = DistanceMatrixApi.TravelList.new |>
      DistanceMatrixApi.TravelList.add_entry(%{origin: "Caen", destination: "Paris"}) |>
      DistanceMatrixApi.TravelList.add_entry(%{origin: "Lyon", destination: "Nice"}) |>
      DistanceMatrixApi.TravelList.add_entry(%{origin: %{lat: 45.764043, long: 4.835658999999964}, destination: %{lat: 48.856614, long: 2.3522219000000177}})

    travels |> DistanceMatrixApi.distances
  """
  def distances(travel_list, options \\ %{}) do
    %{origins: convert(:origin, travel_list), destinations: convert(:destination, travel_list)}
    |> make_request(options)
  end

  defp convert(key, travels) do
    travels
    |> Enum.reduce("", fn(x, acc) -> "#{acc}#{@separator}#{to_param(x[key])}" end)
    |> String.slice(1..-1)
  end

  defp to_param(travel) when is_binary(travel), do: travel
  defp to_param(travel) when is_map(travel), do: "#{travel.lat},#{travel.long}"

  defp make_request(params, options) do
    if key, do: params = Map.put(params, :key, key)

    params
    |> Map.merge(options)
    |> URI.encode_query
    |> build_url
    |> get!
  end

  defp build_url(params), do: @base_url <> params

  defp get!(url) do
    HTTPoison.start

    {:ok, %HTTPoison.Response{status_code: 200, body: body}} = HTTPoison.get(url, [], [])

    body |> Jason.decode!
  end

  defp key do
    Application.get_env(:distance_api_matrix, :api_key)
  end

  def to_map(x)do
origin_addresses = x["origin_addresses"]
destination_addresses = x["destination_addresses"]
rows = x["rows"]

    case  x["status"] do
    "OK" -> origin_addresses
    |> Enum.with_index
    |> Enum.map(fn({x, i}) ->
    %{origin: x, destination: Enum.at(destination_addresses, i) , rows: Enum.at(rows, i)}
    end)
    _-> x
    end

end
end
