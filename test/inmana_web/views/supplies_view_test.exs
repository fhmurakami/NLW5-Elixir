defmodule InmanaWeb.SuppliesViewTest do
  use InmanaWeb.ConnCase

  import Phoenix.View

  alias Inmana.Supply
  alias InmanaWeb.SuppliesView

  describe "render/2" do
    test "renders create.json" do
      restaurant_params = %{name: "Siri Cascudo", email: "siri@cascudo.com"}
      {:ok, restaurant} = Inmana.create_restaurant(restaurant_params)
      restaurant_id = restaurant.id

      {:ok, expiration_date} = Date.new(2021, 04, 26)

      supply_params = %{
        description: "Ingredient name",
        expiration_date: "2021-04-26",
        responsible: "Responsible Name",
        restaurant_id: restaurant_id
      }

      {:ok, supply} = Inmana.create_supply(supply_params)

      response = render(SuppliesView, "create.json", supply: supply)

      assert %{
               message: "Supply created!",
               supply: %Supply{
                 description: "Ingredient name",
                 expiration_date: ^expiration_date,
                 responsible: "Responsible Name",
                 restaurant_id: ^restaurant_id
               }
             } = response
    end

    test "renders show.json" do
      restaurant_params = %{name: "Siri Cascudo", email: "siri@cascudo.com"}
      {:ok, restaurant} = Inmana.create_restaurant(restaurant_params)
      restaurant_id = restaurant.id

      {:ok, expiration_date} = Date.new(2021, 04, 26)

      supply_params = %{
        description: "Ingredient name",
        expiration_date: "2021-04-26",
        responsible: "Responsible Name",
        restaurant_id: restaurant_id
      }

      {:ok, supply} = Inmana.create_supply(supply_params)
      supply_id = supply.id

      response = render(SuppliesView, "show.json", supply: supply)

      assert %{
               supply: %Supply{
                 id: ^supply_id,
                 description: "Ingredient name",
                 expiration_date: ^expiration_date,
                 responsible: "Responsible Name",
                 restaurant_id: ^restaurant_id
               }
             } = response
    end
  end
end
