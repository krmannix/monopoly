defmodule Monopoly.Game do
  use Monopoly.Schema
  import Ecto.Changeset
  alias Monopoly.Repo

  schema "games" do
    has_many :players, Monopoly.Player

    timestamps()
  end

  def find(id, options \\ []) do
    preload = Keyword.get(options, :preload, [])
    Repo.get(Monopoly.Game, id)
    |> Repo.preload(preload)
  rescue
    Ecto.Query.CastError -> nil
  end

  @doc false
  def changeset(game, attrs) do
    game
    |> cast(attrs, [])
    |> cast_assoc(:players, required: true)
    |> validate_required([:players])
    |> validate_length(:players, min: 2, max: 4)
  end
end
