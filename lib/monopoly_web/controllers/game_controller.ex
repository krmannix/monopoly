defmodule MonopolyWeb.GameController do
  use MonopolyWeb, :controller
  alias Monopoly.Dice

  def roll(conn, _params) do
    dicerolls = Dice.roll_times(2)
    total = Enum.sum(dicerolls)
    body = %{
      roll: %{
        dicerolls: dicerolls,
        total: total,
      },
    }
    json(
      conn,
      body
    )
  end
end
