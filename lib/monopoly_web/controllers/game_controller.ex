defmodule MonopolyWeb.GameController do
  use MonopolyWeb, :controller
  alias Monopoly.Dice

  @default_player_name "Player 1"

  def create(conn, params) do
    name = extract_name(params["name"])
    human_player = build_player(name)

    body = %{
      players: [
        human_player,
      ],
    }

    json(conn, body)
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

  defp extract_name(name) when is_binary(name) do
    if String.match?(name, ~r/^[[:space:]]*$/), do: @default_player_name, else: String.trim(name)
  end
  defp extract_name(_), do: @default_player_name

  defp build_player(name) do
    %{
      name: name,
    }
  end
end
