defmodule Monopoly.Repo.Migrations.CreatePlayers do
  use Ecto.Migration

  def change do
    create table(:players, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string, null: false
      add :money, :integer, null: false
      add :is_bankrupt, :boolean, default: false, null: false
      add :is_human_player, :boolean, default: false, null: false
      add :current_space_id, :string, null: false
      add :get_out_of_jail_free_card_count, :integer, default: 0, null: false

      add :game_id, references(:games, type: :uuid), null: false

      timestamps()
    end

  end
end
