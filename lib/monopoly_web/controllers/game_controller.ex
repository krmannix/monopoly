defmodule MonopolyWeb.GameController do
  use MonopolyWeb, :controller
  alias Monopoly.Dice

  @default_player_name "Player 1"

  def create(conn, params) do
    body = case body_from_params(params) do
      {:ok, players} -> %{
        players: players
      }
      {:error, error_message} ->
        %{
          error: %{
            message: error_message,
          },
        }
    end

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

  def body_from_params(params) do
    name = extract_name(params["name"])
    human_player = build_player(name)
    players = [
      human_player,
    ]
    {:ok, players}
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
