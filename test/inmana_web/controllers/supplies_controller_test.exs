defmodule InmanaWeb.SuppliesControllerTest do
  use InmanaWeb.ConnCase

  describe "create/2" do
    test "when all params are valid, creates the supply", %{conn: conn} do
      restaurant_params = %{name: "Siri Cascudo", email: "siri@cascudo.com"}
      {:ok, restaurant} = Inmana.create_restaurant(restaurant_params)
      restaurant_id = restaurant.id

      params = %{
        description: "Ingredient name",
        expiration_date: "2021-04-26",
        responsible: "Responsible Name",
        restaurant_id: restaurant_id
      }

      response =
        conn
        |> post(Routes.supplies_path(conn, :create, params))
        |> json_response(:created)

      assert %{
               "message" => "Supply created!",
               "supply" => %{
                 "description" => "Ingredient name",
                 "expiration_date" => "2021-04-26",
                 "id" => _id,
                 "responsible" => "Responsible Name",
                 "restaurant_id" => ^restaurant_id
               }
             } = response
    end

    test "when params are empty, returns can't be blank error", %{conn: conn} do
      params = %{}

      expected_response = %{
        "message" => %{
          "description" => ["can't be blank"],
          "expiration_date" => ["can't be blank"],
          "responsible" => ["can't be blank"],
          "restaurant_id" => ["can't be blank"]
        }
      }

      response =
        conn
        |> post(Routes.supplies_path(conn, :create, params))
        |> json_response(:bad_request)

      assert response == expected_response
    end

    test "when there are invalid params, returns the respective validation error", %{conn: conn} do
      params = %{
        description: "I",
        expiration_date: "2021/04/26",
        responsible: "R",
        restaurant_id: [1]
      }

      expected_response = %{
        "message" => %{
          "description" => ["should be at least 3 character(s)"],
          "expiration_date" => ["is invalid"],
          "responsible" => ["should be at least 3 character(s)"],
          "restaurant_id" => ["is invalid"]
        }
      }

      response =
        conn
        |> post(Routes.supplies_path(conn, :create, params))
        |> json_response(:bad_request)

      assert response == expected_response
    end
  end

  describe "show/2" do
    test "when the param is valid, show the supply", %{conn: conn} do
      restaurant_params = %{name: "Siri Cascudo", email: "siri@cascudo.com"}
      {:ok, restaurant} = Inmana.create_restaurant(restaurant_params)
      restaurant_id = restaurant.id

      supply_params = %{
        description: "Ingredient name",
        expiration_date: "2021-04-26",
        responsible: "Responsible Name",
        restaurant_id: restaurant_id
      }

      {:ok, supply} = Inmana.create_supply(supply_params)

      response =
        conn
        |> get(Routes.supplies_path(conn, :show, supply.id))
        |> json_response(:ok)

      assert %{
               "supply" => %{
                 "description" => "Ingredient name",
                 "expiration_date" => "2021-04-26",
                 "id" => _id,
                 "responsible" => "Responsible Name",
                 "restaurant_id" => ^restaurant_id
               }
             } = response
    end

    test "when the param is invalid, show an error", %{conn: conn} do
      supply_id = "b174bd53-7c25-4688-b1fc-8e82d8687474"

      expected_response = %{
        "message" => "Supply not found"
      }

      response =
        conn
        |> get(Routes.supplies_path(conn, :show, supply_id))
        |> json_response(:not_found)

      assert response == expected_response
    end
  end
end
