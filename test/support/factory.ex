defmodule Monopoly.Factory do
  alias Monopoly.{
    Game,
    Player,
    Repo,
  }

  def build(:game) do
    %Game{
      players: Enum.map(0..3, fn (_) -> build(:player) end),
    }
  end

  def build(:player) do
    %Player{
      current_space_id: Space.space_at(Enum.random(0..20), Enum.random(0..20)).id,
      get_out_of_jail_free_card_count: 0,
      is_bankrupt: false,
      is_human_player: false,
      money: 1500,
      name: "name##{System.unique_integer()}"
    }
  end

  def build(factory_name, attributes) do
    factory_name |> build() |> struct!(attributes)
  end

  def insert!(factory_name, attributes \\ []) do
    factory_name |> build(attributes) |> Repo.insert!()
  end
end
