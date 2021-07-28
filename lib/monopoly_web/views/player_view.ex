defmodule MonopolyWeb.PlayerView do
  use MonopolyWeb, :view

  def render("player.json", %{player: player}) do
    %{
      get_out_of_jail_free_card_count: player.get_out_of_jail_free_card_count,
      is_bankrupt: player.is_bankrupt,
      is_human_player: player.is_human_player,
      money: player.money,
      name: player.name,
      current_space_id: player.current_space_id,
    }
  end
end
