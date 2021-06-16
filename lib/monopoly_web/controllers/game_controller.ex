defmodule MonopolyWeb.GameController do
  use MonopolyWeb, :controller
  alias Monopoly.Dice

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
end
