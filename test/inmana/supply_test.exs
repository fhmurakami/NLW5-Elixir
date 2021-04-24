defmodule Inmana.SupplyTest do
  use Inmana.DataCase

  alias Ecto.Changeset
  alias Inmana.Supply

  describe "changeset/1" do
    test "when all params are valid, returns a valid changeset" do
      {:ok, expiration_date} = Date.new(2021, 04, 26)

      params = %{
        description: "Ingredient name",
        expiration_date: "2021-04-26",
        responsible: "Responsible Name",
        restaurant_id: "1"
      }

      response = Supply.changeset(params)

      assert %Changeset{
               changes: %{
                 description: "Ingredient name",
                 expiration_date: ^expiration_date,
                 responsible: "Responsible Name",
                 restaurant_id: "1"
               },
               valid?: true
             } = response
    end

    test "when the description is empty, returns an error" do
      params = %{
        expiration_date: "2021-04-26",
        responsible: "Responsible Name",
        restaurant_id: "1"
      }

      expected_response = %{description: ["can't be blank"]}

      response = Supply.changeset(params)

      assert %Changeset{valid?: false} = response
      assert errors_on(response) == expected_response
    end

    test "when the description has less than 3 characters, returns an error" do
      params = %{
        description: "A",
        expiration_date: "2021-04-26",
        responsible: "Responsible Name",
        restaurant_id: "1"
      }

      expected_response = %{description: ["should be at least 3 character(s)"]}

      response = Supply.changeset(params)

      assert %Changeset{valid?: false} = response
      assert errors_on(response) == expected_response
    end

    test "when the responsible is empty, returns an error" do
      params = %{
        description: "Ingredient description",
        expiration_date: "2021-04-26",
        restaurant_id: "1"
      }

      expected_response = %{responsible: ["can't be blank"]}

      response = Supply.changeset(params)

      assert %Changeset{valid?: false} = response
      assert errors_on(response) == expected_response
    end

    test "when the responsible has less than 3 characters, returns an error" do
      params = %{
        description: "Ingredient description",
        expiration_date: "2021-04-26",
        responsible: "R",
        restaurant_id: "1"
      }

      expected_response = %{responsible: ["should be at least 3 character(s)"]}

      response = Supply.changeset(params)

      assert %Changeset{valid?: false} = response
      assert errors_on(response) == expected_response
    end

    test "when the expiration date is empty, returns an error" do
      params = %{
        description: "Ingredient description",
        responsible: "Responsible Name",
        restaurant_id: "1"
      }

      expected_response = %{expiration_date: ["can't be blank"]}

      response = Supply.changeset(params)

      assert %Changeset{valid?: false} = response
      assert errors_on(response) == expected_response
    end

    test "when the restaurant id is empty, returns an error" do
      params = %{
        description: "Ingredient description",
        expiration_date: "2021-04-26",
        responsible: "Responsible Name"
      }

      expected_response = %{restaurant_id: ["can't be blank"]}

      response = Supply.changeset(params)

      assert %Changeset{valid?: false} = response
      assert errors_on(response) == expected_response
    end

    test "when the restaurant id is an integer, returns an error" do
      params = %{
        description: "Ingredient description",
        expiration_date: "2021-04-26",
        responsible: "Responsible Name",
        restaurant_id: 1
      }

      expected_response = %{restaurant_id: ["is invalid"]}

      response = Supply.changeset(params)

      assert %Changeset{valid?: false} = response
      assert errors_on(response) == expected_response
    end
  end
end
