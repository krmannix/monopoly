defmodule MonopolyWeb.GameController do
  use MonopolyWeb, :controller
  alias Monopoly.Dice

  @default_player_count 4
  @default_player_name "Player 1"

  def create(conn, params) do
    case create_from_params(params) do
      {:ok, body} -> json(conn, body)
      {:error, error_message} ->
        body = %{
          error: %{
            message: error_message,
          },
        }
        conn
        |> put_status(400)
        |> json(body)
    end
  end

  def roll(conn, _params) do
    dicerolls = Dice.roll_times(2)
    total = Enum.sum(dicerolls)
    starting_index = 0
    space = Space.space_at(starting_index, total)
    body = %{
      roll: %{
        dicerolls: dicerolls,
        total: total,
      },
      space: space,
    }
    json(
      conn,
      body
    )
  end

  def create_from_params(params) do
    with {:ok, name} <- extract_name(params["name"]),
         {:ok, player_count} <- extract_player_count(params["playerCount"])
    do
      human_player = build_player(name)
      computer_players = build_computer_players(player_count - 1)
      players = [human_player | computer_players]
      game = build_game(players)
      {:ok, game}
    else
      {:error, message} -> {:error, message}
    end
  end

  defp extract_name(name) when is_binary(name) do
    if String.match?(name, ~r/^[[:space:]]*$/), do: {:ok, @default_player_name}, else: {:ok, String.trim(name)}
  end
  defp extract_name(_), do: {:ok, @default_player_name}

  defp extract_player_count(count) when is_integer(count) do
    if 1 < count and count <= 4 do
      {:ok, count}
    else
      {:error, "playerCount must be set between 2 and 4, inclusive"}
    end
  end

  defp extract_player_count(count) when is_nil(count), do: {:ok, @default_player_count}
  defp extract_player_count(_), do: {:error, "must be an integer between 2 and 4, inclusive"}

  defp build_computer_players(count) do
    Enum.map(1..count, fn (i) -> build_player("Conputer Player #{i}") end)
  end

  defp build_game(players) do
    %SimpleGame{
      id: Ecto.UUID.generate,
      players: players,
    }
  end

  defp build_player(name) do
    %Player{
      id: Ecto.UUID.generate,
      name: name,
      money: 1500,
      isBankrupt: false,
      isHumanPlayer: false,
      currentSpace: Space.starting_space(),
      properties: [],
      getOutOfJailFreeCardCount: 0,
    }
  end
end
