[![Build Status](https://travis-ci.org/C404/distance-matrix-api.svg?branch=master)](https://travis-ci.org/C404/distance-matrix-api)
[![Hex.pm](https://img.shields.io/hexpm/v/distance_api_matrix.svg)](https://hex.pm/packages/distance_api_matrix)
[![License](http://img.shields.io/badge/license-MIT-brightgreen.svg)](http://opensource.org/licenses/MIT)
# Google Distance Matrix API Library for Elixir
This library allows you to obtain the distance and travel times between multiple origins and destinations via various travel methods.

## Installation

First, add distance_api_matrix to your `mix.exs` dependencies:

```elixir
def deps do
  [{:distance_api_matrix, "~> 2.0"}]
end
```
and run `$ mix deps.get`.

## Usage

```iex
# Create a travel_list with coords and/or addresses
iex> travels = DistanceMatrixApi.TravelList.new |>
  DistanceMatrixApi.TravelList.add_entry(%{origin: "Caen", destination: "Paris"}) |>
  DistanceMatrixApi.TravelList.add_entry(%{origin: "21 Rue de la République, 69002 Lyon, France", destination: "60 Rue de Rivoli, 75004 Paris, France"}) |>
  DistanceMatrixApi.TravelList.add_entry(%{origin: %{lat: 45.764043, long: 4.835658999999964}, destination: %{lat: 48.856614, long: 2.3522219000000177}})

# Basic call
iex> travels |> DistanceMatrixApi.distances

#with custom options
iex> options = %{mode: "bicycling", units: "imperial", language: "en-US"}
iex> travels |> DistanceMatrixApi.distances(options)

# return a map of each result the result is successul
iex> result = travels |> DistanceMatrixApi.distances
iex> result |> DistanceMatrixApi.each

# return a map of the google computed distance (googles best guess) etc the result is successul
iex> result = travels |> DistanceMatrixApi.distances
iex> result |> DistanceMatrixApi.computed
```

Check an example of the output format [here](https://maps.googleapis.com/maps/api/distancematrix/json?origins=Rue%20de%20Lappe,%20Paris%7CPlace%20de%20l%27Opera,%20Paris&destinations=Place%20de%20l%27Opera,%20Paris%7CPlace%20Gambetta,%20Paris&mode=bicycling&language=fr-FR)

## Options

All options defined in the [Google distance matrix documentation](https://developers.google.com/maps/documentation/distance-matrix/intro) are available, such as: `mode` `key` `language` `units` etc.

**Key :**

Set by default if `Application.get_env(:distance_api_matrix, :api_key)` is present.

## Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D

## Testing

Various tests included, just run;

    mix deps.get
    mix test

## License

Copyright (c) 2015 Thibault Hagler. See the LICENSE file for license rights and limitations (MIT).
