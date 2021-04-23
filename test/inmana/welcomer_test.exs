defmodule Inmana.WelcomerTest do
  use ExUnit.Case

  alias Inmana.Welcomer

  describe "welcome/1" do
    test "when the user is special, returns a special message" do
      params = %{"name" => "banana", "age" => "42"}
      expected_result = {:ok, "You are very special banana"}

      result = Welcomer.welcome(params)

      assert result == expected_result
    end

    test "when the user is not special, returns a normal message" do
      params = %{"name" => "Fulano", "age" => "27"}
      expected_result = {:ok, "Welcome #{String.downcase(params["name"])}"}

      result = Welcomer.welcome(params)

      assert result == expected_result
    end

    test "when the user is underage, returns an error" do
      params = %{"name" => "Fulano", "age" => "17"}
      expected_result = {:error, "You shall not pass #{String.downcase(params["name"])}"}

      result = Welcomer.welcome(params)

      assert result == expected_result
    end
  end
end
