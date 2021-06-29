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
            "money" => money,
            "isBankrupt" => isBankrupt,
            "isHumanPlayer" => isHumanPlayer,
            "currentSpace" => currentSpace,
            "properties" => properties,
            "getOutOfJailFreeCardCount" => getOutOfJailFreeCardCount,
          } | _
        ],
      } = Poison.decode!(conn.resp_body)

      expected_space = %{
        "id" => "8c826137-989e-4b3c-bbeb-ae2aa83930b7",
        "name" => "Go",
        "type" => "go",
      }

      assert name == "Kevin"
      assert money == 1500
      assert isBankrupt == false
      assert isHumanPlayer == false
      assert currentSpace == expected_space
      assert properties == []
      assert getOutOfJailFreeCardCount == 0
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

      expected_space = %{
        "id" => "8c826137-989e-4b3c-bbeb-ae2aa83930b7",
        "name" => "Go",
        "type" => "go",
      }

      assert Enum.count(players) == 2
      assert Enum.all?(players, fn (player) -> player["currentSpace"] == expected_space end)
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
