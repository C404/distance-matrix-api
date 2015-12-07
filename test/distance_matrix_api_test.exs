defmodule DistanceMatrixApiTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  test ".get_distances response for success" do
    use_cassette "success" do
      valid_params = %{origins: ["Paris", "Lyon"],
          destinations: ["Lyon", "Paris"]
        }

      response = DistanceMatrixApi.get_distances(valid_params)

      assert response != %{}
      assert response["origin_addresses"] == ["Paris, France", "Lyon, France"]
      assert response["destination_addresses"] == ["Lyon, France", "Paris, France"]

      assert "465 km" == response["rows"]
                         |> List.first
                         |> Map.get("elements")
                         |> List.first
                         |> Map.get("distance")
                         |> Map.get("text")
    end
  end

  test ".get_distances response for success with options" do
    use_cassette "success_with_options" do
      valid_params = %{origins: ["Paris", "Lyon"],
          destinations: ["Lyon", "Paris"]
        }

      valid_options = %{mode: "bicycling", units: "imperial", language: "en-US"}

      response = DistanceMatrixApi.get_distances(valid_params, valid_options)

      assert "296 mi" == response["rows"]
                         |> List.first
                         |> Map.get("elements")
                         |> List.first
                         |> Map.get("distance")
                         |> Map.get("text")
    end
  end

  test ".get_distances empty response" do
    use_cassette "success_empty" do
      valid_params = %{origins: ["Baylabamba"],
          destinations: []
        }

      response = DistanceMatrixApi.get_distances(valid_params)

      assert response != %{}
      assert response["origin_addresses"] == []
      assert response["destination_addresses"] == []
    end
  end


  test ".get_distances_by_coords response for success" do
    use_cassette "success_by_coords" do
      valid_params = %{destinations: [%{lat: 45.764043, long: 4.835658999999964}],
                       origins: [%{lat: 48.856614, long: 2.3522219000000177}]}

      response = DistanceMatrixApi.get_distances_by_coords(valid_params)

      assert response != %{}
      assert response["origin_addresses"] == ["66 Rue de Rivoli, 75004 Paris, France"]
      assert response["destination_addresses"] == ["21 Rue de la République, 69002 Lyon, France"]

      assert "465 km" == response["rows"]
                         |> List.first
                         |> Map.get("elements")
                         |> List.first
                         |> Map.get("distance")
                         |> Map.get("text")
    end
  end
end
