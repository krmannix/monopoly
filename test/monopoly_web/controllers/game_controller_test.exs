defmodule MonopolyWeb.GameControllerTest do
  use MonopolyWeb.ConnCase

  describe "#roll" do
    test "includes each dice roll individually in the response" do
      conn = post(build_conn(), "/api/roll")

      assert conn.status == 200

      %{
          "roll" => %{
            "dicerolls" => dicerolls,
            "total" => _total,
          },
        } = Poison.decode!(conn.resp_body)

      assert Enum.count(dicerolls) == 2
      assert Enum.all?(dicerolls, fn (x) -> 1 <= x && x <= 6 end)
    end

    test "includes the sum of the dice rolls in the response" do
      conn = post(build_conn(), "/api/roll")

      assert conn.status == 200

      %{
          "roll" => %{
            "dicerolls" => [x, y],
            "total" => total,
          },
        } = Poison.decode!(conn.resp_body)

      assert x + y == total
    end
  end
end
