[![Build Status](https://travis-ci.org/C404/distance-matrix-api.svg?branch=master)](https://travis-ci.org/C404/distance-matrix-api)
[![Hex.pm](https://img.shields.io/hexpm/v/distance_api_matrix.svg)](https://hex.pm/packages/distance_api_matrix)
[![License](http://img.shields.io/badge/license-MIT-brightgreen.svg)](http://opensource.org/licenses/MIT)
# Google Distance Matrix API Library for Elixir
This library allows you to obtain the distance and travel times between multiple origins and destinations via various travel methods.

It is for now an early version of the library and many features are to come :)

## Installation

First, add distance_api_matrix to your `mix.exs` dependencies:

```elixir
def deps do
  [{:distance_api_matrix, "~> 1.0"}]
end
```
and run `$ mix deps.get`.

## Usage

```iex
# Basic call
iex> addresses_params = %{origins: ["842-844 Rossville Ave, Staten Island, NY, State of New York 10309, United states", "Paris"],
                     destinations: ["847-899 Coolidge Ave, Woodbridge, NJ 07095, United states", "Lyon"]}

iex> DistanceMatrixApi.get_distances(addresses_params)

# Call with coordinates
iex> coords_params = %{destinations: [%{lat: 45.764043, long: 4.835658999999964}, %{lat: 48.856614, long: 2.3522219000000177}],
                  origins: [%{lat: 48.856614, long: 2.3522219000000177}, %{lat: 45.764043, long: 4.835658999999964}]}

iex>  DistanceMatrixApi.get_distances_by_coords(coords_params)

# With custom options
iex> options_params = %{mode: "bicycling", units: "imperial", language: "en-US"}

iex>  DistanceMatrixApi.get_distances(addresses_params, options_params)
```

Check an example of the output format [here](https://maps.googleapis.com/maps/api/distancematrix/json?origins=Rue%20de%20Lappe,%20Paris%7CPlace%20de%20l%27Opera,%20Paris&destinations=Place%20de%20l%27Opera,%20Paris%7CPlace%20Gambetta,%20Paris&mode=bicycling&language=fr-FR)

## Options

All options defined in the [Google distance matrix documentation](https://developers.google.com/maps/documentation/distance-matrix/intro) are available, such as: `mode` `key` `language` `units` etc.

**Key :**

Set by default if `Application.get_env(:distance_api_matrix, :api_key)` is present.

## Todo

- Set default options
- Handle rate limiting
- Handle max encoded url length
- Add some more guards on options
- Add custom functions to fetch results and map them

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
