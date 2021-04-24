defmodule Inmana.Supplies.ExpirationEmailTest do
  use ExUnit.Case
  use InmanaWeb.ConnCase

  alias Inmana.Supplies.ExpirationEmail

  test "sends email with the supplies about to expire" do
    restaurant_params = %{name: "Siri Cascudo", email: "siri@cascudo.com"}
    {:ok, restaurant} = Inmana.create_restaurant(restaurant_params)
    restaurant_id = restaurant.id

    supply_params = %{
      description: "Ingredient name",
      expiration_date: "2021-04-26",
      responsible: "Responsible Name",
      restaurant_id: restaurant_id
    }

    {:ok, supply1} = Inmana.create_supply(supply_params)
    {:ok, supply2} = Inmana.create_supply(supply_params)

    supplies = [supply1, supply2]

    email = ExpirationEmail.create(restaurant.email, supplies)

    assert email.to == restaurant.email
    assert email.from == "app@inmana.com.br"
    assert email.subject == "Supplies that are about to expire"

    assert email.text_body ==
             "----- Supplies that are about to expire: -----\n" <>
               "Description: #{supply1.description}, " <>
               "Expiration Date: #{supply1.expiration_date}, " <>
               "Responsible: #{supply1.responsible}\n" <>
               "Description: #{supply2.description}, " <>
               "Expiration Date: #{supply2.expiration_date}, " <>
               "Responsible: #{supply2.responsible}\n"
  end
end
