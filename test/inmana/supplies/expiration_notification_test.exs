defmodule Inmana.Supplies.ExpirationNotificationTest do
  use ExUnit.Case
  use Bamboo.Test
  use InmanaWeb.ConnCase

  alias Inmana.Mailer
  alias Inmana.Supplies.{ExpirationEmail, GetByExpiration}

  test "sends email with supplies about to expire" do
    restaurant_params = %{name: "Siri Cascudo", email: "siri@cascudo.com"}
    {:ok, restaurant} = Inmana.create_restaurant(restaurant_params)
    restaurant_id = restaurant.id

    supply_params = %{
      description: "Ingredient name",
      expiration_date: Date.utc_today(),
      responsible: "Responsible Name",
      restaurant_id: restaurant_id
    }

    Inmana.create_supply(supply_params)
    Inmana.create_supply(supply_params)

    data = GetByExpiration.call()

    email =
      data
      |> Enum.map(fn {to_email, supplies} -> ExpirationEmail.create(to_email, supplies) end)
      |> List.first()

    email |> Mailer.deliver_now!()

    assert_delivered_email(email)
  end
end
