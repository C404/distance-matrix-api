defmodule DistanceMatrixApi.TravelListTest do
  use ExUnit.Case, async: false

  test ".new" do
    assert DistanceMatrixApi.TravelList.new == []
  end

  test ".add_entry" do
    travels = DistanceMatrixApi.TravelList.new |>
      DistanceMatrixApi.TravelList.add_entry(%{origin: "Caen", destination: "Paris"}) |>
      DistanceMatrixApi.TravelList.add_entry(%{origin: "Lyon", destination: "Nice"}) |>
      DistanceMatrixApi.TravelList.add_entry(%{origin: %{lat: 45.764043, long: 4.835658999999964}, destination: %{lat: 48.856614, long: 2.3522219000000177}})

    expected_list = [%{destination: "Paris", origin: "Caen"},
      %{destination: "Nice", origin: "Lyon"},
      %{destination: %{lat: 48.856614, long: 2.3522219000000177},
      origin: %{lat: 45.764043, long: 4.835658999999964}}]

      assert travels == expected_list
  end
end
