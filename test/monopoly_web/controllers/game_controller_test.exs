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
          } | rest
        ],
      } = Poison.decode!(conn.resp_body)

      assert name == "Player 1"
      assert Enum.count(rest) == 3
    end

    test "sets the number of players based on user input" do
      params = %{
        "playerCount" => 2,
      }

      conn = post(build_conn(), "/api/v1/games", params)

      assert conn.status == 200

      %{
        "players" => players,
      } = Poison.decode!(conn.resp_body)

      assert Enum.count(players) == 2
    end

    test "returns an error if the number of players requested is out of bounds" do
      params = %{
        "playerCount" => 1,
      }

      conn = post(build_conn(), "/api/v1/games", params)

      assert conn.status == 400

      %{
        "error" => %{
          "message" => message,
        },
      } = Poison.decode!(conn.resp_body)

      assert message == "playerCount must be set between 2 and 4, inclusive"
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
