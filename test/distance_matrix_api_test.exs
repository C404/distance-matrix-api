defmodule DistanceMatrixApiTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  setup_all do
    ExVCR.Config.cassette_library_dir("test/cassettes")
    :ok
  end

  test ".distances response for success" do
    use_cassette "success" do
      travels =
        DistanceMatrixApi.TravelList.new()
        |> DistanceMatrixApi.TravelList.add_entry(%{origin: "Caen", destination: "Paris"})
        |> DistanceMatrixApi.TravelList.add_entry(%{origin: "Lyon", destination: "Nice"})
        |> DistanceMatrixApi.TravelList.add_entry(%{
          origin: %{lat: 45.764043, long: 4.835658999999964},
          destination: %{lat: 48.856614, long: 2.3522219000000177}
        })

      response = travels |> DistanceMatrixApi.distances()

      assert response != %{}

      assert response["origin_addresses"] == [
               "Caen, France",
               "Lyon, France",
               "21 Rue de la République, 69002 Lyon, France"
             ]

      assert response["destination_addresses"] == [
               "Paris, France",
               "Nice, France",
               "60 Rue de Rivoli, 75004 Paris, France"
             ]

      assert "234 km" ==
               response["rows"]
               |> List.first()
               |> Map.get("elements")
               |> List.first()
               |> Map.get("distance")
               |> Map.get("text")
    end
  end

  test ".distances response for success with options" do
    use_cassette "success_with_options" do
      travels =
        DistanceMatrixApi.TravelList.new()
        |> DistanceMatrixApi.TravelList.add_entry(%{origin: "Caen", destination: "Paris"})
        |> DistanceMatrixApi.TravelList.add_entry(%{origin: "Lyon", destination: "Nice"})
        |> DistanceMatrixApi.TravelList.add_entry(%{
          origin: %{lat: 45.764043, long: 4.835658999999964},
          destination: %{lat: 48.856614, long: 2.3522219000000177}
        })

      valid_options = %{mode: "bicycling", units: "imperial", language: "en-US"}

      response = travels |> DistanceMatrixApi.distances(valid_options)

      assert response != %{}

      assert response["origin_addresses"] == [
               "Caen, France",
               "Lyon, France",
               "15 Rue de la Poulaillerie, 69002 Lyon, France"
             ]

      assert response["destination_addresses"] == [
               "Paris, France",
               "Nice, France",
               "94 Quai de l'Hôtel de ville, 75004 Paris, France"
             ]

      assert "153 mi" ==
               response["rows"]
               |> List.first()
               |> Map.get("elements")
               |> List.first()
               |> Map.get("distance")
               |> Map.get("text")
    end
  end

  test ".distances empty response" do
    use_cassette "success_empty" do
      travels =
        DistanceMatrixApi.TravelList.new()
        |> DistanceMatrixApi.TravelList.add_entry(%{origin: "Baylabamba", destination: ""})

      response = travels |> DistanceMatrixApi.distances()

      assert response != %{}
      assert response["origin_addresses"] == []
      assert response["destination_addresses"] == []
    end
  end
end
