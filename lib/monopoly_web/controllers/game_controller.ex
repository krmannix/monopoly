defmodule MonopolyWeb.GameController do
  use MonopolyWeb, :controller

  def roll(conn, _params) do
    dicerolls = [diceroll(), diceroll()]
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

  defp diceroll() do
    :rand.uniform(6)
  end
end
