defmodule MonopolyWeb.GameView do
  use MonopolyWeb, :view

  def render("show.json", %{game: game}) do
    render_one(game, MonopolyWeb.GameView, "game.json")
  end

  def render("game.json", %{game: game}) do
    %{
      id: game.id,
      players: render_many(game.players, MonopolyWeb.PlayerView, "player.json")
    }
  end
end
