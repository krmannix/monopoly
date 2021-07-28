defmodule Monopoly.Player do
  use Monopoly.Schema
  import Ecto.Changeset

  @space_ids Space.space_ids

  schema "players" do
    field :current_space_id, :string
    field :get_out_of_jail_free_card_count, :integer
    field :is_bankrupt, :boolean, default: false
    field :is_human_player, :boolean, default: false
    field :money, :integer
    field :name, :string
    belongs_to :game, Monopoly.Game

    timestamps()
  end

  def current_space(player) do
    Space.find_space(player.current_space_id)
  end

  @doc false
  def changeset(player, attrs) do
    player
    |> cast(attrs, [:name, :money, :is_bankrupt, :is_human_player, :current_space_id, :get_out_of_jail_free_card_count])
    |> update_change(:name, &String.trim/1)
    |> validate_required([:name, :money, :is_bankrupt, :is_human_player, :current_space_id, :get_out_of_jail_free_card_count])
    |> validate_inclusion(:current_space_id, @space_ids)
    |> validate_number(:get_out_of_jail_free_card_count, greater_than_or_equal_to: 0)
    |> validate_number(:money, greater_than_or_equal_to: 0)
  end
end
