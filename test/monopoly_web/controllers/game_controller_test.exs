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
            "is_bankrupt" => is_bankrupt,
            "is_human_player" => is_human_player,
            "current_space" => current_space,
            "get_out_of_jail_free_card_count" => get_out_of_jail_free_card_count,
          } | _
        ],
      } = Poison.decode!(conn.resp_body)

      assert name == "Kevin"
      assert money == 1500
      assert is_bankrupt == false
      assert is_human_player == false
      assert current_space == %{
        "id" => "8c826137-989e-4b3c-bbeb-ae2aa83930b7",
        "name" => "Go",
        "type" => "go",
      }
      assert get_out_of_jail_free_card_count == 0
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
      assert Enum.all?(players, fn (player) -> player["current_space"] == expected_space end)
    end

    test "returns an error if the number of players requested is out of bounds" do
      params = %{
        "playerCount" => 1,
      }

      conn = post(build_conn(), "/api/v1/games", params)

      assert conn.status == 400

      %{
        "error_message" => message,
      } = Poison.decode!(conn.resp_body)

      assert message == "Something went wrong"
    end

    test "does not accept any player params passed in by the user" do
      params = %{
        "players" => %{
          "space" => Space.starting_space.id,
          "name" => "Sent by user",
          "money" => 1500,
          "is_bankrupt" => false,
          "is_human_player" => false,
          "get_out_of_jail_free_card_count" => 0,
        },
      }

      conn = post(build_conn(), "/api/v1/games", params)

      assert conn.status == 200

      %{
        "players" => [
          %{
            "name" => name,
            "money" => money,
            "is_bankrupt" => is_bankrupt,
            "is_human_player" => is_human_player,
            "current_space" => current_space,
            "get_out_of_jail_free_card_count" => get_out_of_jail_free_card_count,
          } | _
        ],
      } = Poison.decode!(conn.resp_body)

      assert name == "Player 1"
      assert money == 1500
      assert is_bankrupt == false
      assert is_human_player == false
      assert current_space == %{
        "id" => "8c826137-989e-4b3c-bbeb-ae2aa83930b7",
        "name" => "Go",
        "type" => "go",
      }
      assert get_out_of_jail_free_card_count == 0
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

  describe "#show" do
    test "returns a 404 for an unknown id" do
      conn = get(build_conn(), "/api/v1/games/ebb32e28-2850-4f3d-a3aa-bc4eae5df039")

      assert conn.status == 404
    end

    test "returns a 404 for an unknown integer id" do
      conn = get(build_conn(), "/api/v1/games/1")

      assert conn.status == 404
    end

    test "returns a 200 for an existing id" do
      game = Monopoly.Factory.insert!(:game)

      conn = get(build_conn(), "/api/v1/games/#{game.id}")

      assert conn.status == 200
      %{
        "players" => result_players,
      } = Poison.decode!(conn.resp_body)

      Enum.each(game.players, fn (player) ->
        player_match = Enum.find(result_players, fn (result_player) -> result_player["id"] == player.id end)
        current_space = Space.find_space(player.current_space_id)
        expected = %{
          "id" => player.id,
          "current_space" => %{
            "id" => current_space.id,
            "name" => current_space.name,
            "type" => current_space.type,
          },
          "name" => player.name,
          "money" => player.money,
          "is_bankrupt" => player.is_bankrupt,
          "is_human_player" => player.is_human_player,
          "get_out_of_jail_free_card_count" => player.get_out_of_jail_free_card_count,
        }
        assert expected == player_match
      end)
    end
  end
end
