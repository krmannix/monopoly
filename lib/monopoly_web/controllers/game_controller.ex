defmodule MonopolyWeb.GameController do
  use MonopolyWeb, :controller
  alias Monopoly.Dice

  def roll(conn, _params) do
    dicerolls = Dice.roll_times(2)
    body = %{
      roll: %{
        dicerolls: dicerolls,
        total: Enum.sum(dicerolls),
      },
    }
    json(
      conn,
      body
    )
  end
end
