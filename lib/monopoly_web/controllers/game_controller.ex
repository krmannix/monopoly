defmodule MonopolyWeb.GameController do
  use MonopolyWeb, :controller
  alias Monopoly.{Dice, Game, Repo}

  @default_player_count 4
  @default_player_name "Player 1"

  def create(conn, params) do
    result = game_changeset(params) |> Repo.insert

    case result do
      {:ok, game} ->

        render(conn, "show.json", game: game, players: game.players)
      {:error, _changeset} ->
        conn
        |> put_status(400)
        |> json(%{error_message: "Something went wrong"})
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

  defp game_changeset(params) do
    game = %{
      players: build_player_maps(params),
    }
    Game.changeset(%Game{}, game)
  end

  defp extract_player_count(count) when is_integer(count), do: count
  defp extract_player_count(count) when is_nil(count), do: @default_player_count
  defp extract_player_count(_), do: 0

  defp extract_name(name) when is_binary(name), do: name
  defp extract_name(_), do: @default_player_name

  defp build_computer_players(count) when count <= 0, do: []
  defp build_computer_players(count), do: Enum.map(1..count, fn (i) -> build_player_map("Computer Player #{i}") end)

  defp build_player_maps(params) do
    player_count = extract_player_count(params["playerCount"])
    human_player = extract_name(params["name"]) |> build_player_map()
    computer_players = build_computer_players(player_count - 1)
    [human_player | computer_players]
  end

  defp build_player_map(name) do
    %{
      current_space_id: Space.starting_space.id,
      name: name,
      money: 1500,
      is_bankrupt: false,
      is_human_player: false,
      get_out_of_jail_free_card_count: 0,
    }
  end
end
