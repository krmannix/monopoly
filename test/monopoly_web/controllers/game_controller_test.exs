defmodule MonopolyWeb.GameControllerTest do
  use MonopolyWeb.ConnCase

  describe "#create" do
    test "sets a players name from user input" do
      params = %{
        "name" => "Kevin",
      }

      conn = post(build_conn(), "/api/v1/games", params)

      assert conn.status == 200

      %{
        "players" => [
          %{
            "name" => name,
          } | _
        ],
      } = Poison.decode!(conn.resp_body)

      assert name == "Kevin"
    end

    test "sets a default players name without user input" do
      params = %{}

      conn = post(build_conn(), "/api/v1/games", params)

      assert conn.status == 200

      %{
        "players" => [
          %{
            "name" => name,
          } | _
        ],
      } = Poison.decode!(conn.resp_body)

      assert name == "Player 1"
    end
  end

  describe "#roll" do
    test "includes each dice roll individually in the response" do
      conn = post(build_conn(), "/api/v1/roll")

      assert conn.status == 200

      %{
          "roll" => %{
            "dicerolls" => dicerolls,
            "total" => _total,
          },
        } = Poison.decode!(conn.resp_body)

      assert Enum.count(dicerolls) == 2
      assert Enum.all?(dicerolls, fn (x) -> 1 <= x && x <= 6 end)
    end

    test "includes the sum of the dice rolls in the response" do
      conn = post(build_conn(), "/api/v1/roll")

      assert conn.status == 200

      %{
          "roll" => %{
            "dicerolls" => [x, y],
            "total" => total,
          },
        } = Poison.decode!(conn.resp_body)

      assert x + y == total
    end
  end
end
