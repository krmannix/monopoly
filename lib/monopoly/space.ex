defmodule Space do
  @moduledoc "Models each tile on the gameboard that a user can land on"

  @space_json Util.load_json_from_file!("priv/data/spaces.json")

  defstruct [:id, :name, :type]

  def space_at(start_index, number_of_steps) do
    Enum.at(spaces(), rem(start_index + number_of_steps, Enum.count(spaces())))
  end

  defp spaces, do: @space_json["spaces"]
end
