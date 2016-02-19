defmodule DistanceMatrixApi do
  @moduledoc """
  Provides functions to interact with Google Distance Matrix API.
  """

  @base_url "https://maps.googleapis.com/maps/api/distancematrix/json?"
  @separator "|"


  @doc """
  Return a Map with basic Google distance api matrix format.
  Expected params: %{origins: ["address", "address"], destinations: ["address", "address"]}
  """
  def get_distances(params, options \\ %{}) do
    %{origins: addresses_to(params[:origins]),
      destinations: addresses_to(params[:destinations])} |> make_request(options)
  end

  @doc """
  Return a Map with basic Google distance api matrix format.
  Expected params: %{origins: [%{lat: -45.3344, long: 42.556}, %{lat: 22.3344, long: -66.556}],
                     destinations: [%{lat: 22.3344, long: -66.556}, %{lat: -45.3344, long: 42.556}]}
  """
  def get_distances_by_coords(params, options \\ %{}) do
    %{origins: coords_to(params[:origins]),
      destinations: coords_to(params[:destinations])} |> make_request(options)
  end

  defp make_request(params, options) do
    if key do
     params = Map.put(params, :key, key)
    end
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
    HTTPoison.start

    {:ok, %HTTPoison.Response{status_code: 200, body: body}} = HTTPoison.get(url, [], [])

    body |> Poison.decode!
  end
  
  defp key do
    Application.get_env(:distance_api_matrix, :api_key)
  end

end
