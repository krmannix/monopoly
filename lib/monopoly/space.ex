defmodule Space do
  @moduledoc "Models each tile on the gameboard that a user can land on"

  @space_json Util.load_json_from_file!("priv/data/spaces.json")
  @go_type "go"

  @derive Jason.Encoder
  defstruct [:id, :name, :type]

  def space_at(start_index, number_of_steps) do
    Enum.at(spaces(), rem(start_index + number_of_steps, Enum.count(spaces())))
  end
  def space_ids, do: Enum.map(spaces(), fn (space) -> space.id end)

  def starting_space, do: Enum.find(spaces(), fn (space) -> space.type == @go_type end)

  defp spaces do
    Enum.map(@space_json["spaces"], fn(space) ->
      space_with_atom_keys = Enum.map(space, fn ({key, value}) -> {String.to_atom(key), value} end)

      struct(Space, space_with_atom_keys)
    end)
  end
end
