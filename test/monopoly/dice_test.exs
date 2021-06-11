defmodule Monopoly.DieTest do
  use Monopoly.DataCase
  alias Monopoly.Dice

  describe "#roll_times" do
    test "it returns numbers between 1 and 6, inclusive" do
      results = Dice.roll_times(10)

      assert Enum.all?(results, fn (x) -> 1 <= x && x <= 6 end)
    end

    test "it raises an exception if a non-integer is passed" do
      error_msg = ~r/^count must be an integer greater than or equal to 1/

      assert_raise RuntimeError, error_msg, fn -> Dice.roll_times(1.1) end
      assert_raise RuntimeError, error_msg, fn -> Dice.roll_times("a") end
    end

    test "it rasies an exception if an integer less than 1 is passed" do
      error_msg = ~r/^count must be an integer greater than or equal to 1/

      assert_raise RuntimeError, error_msg, fn -> Dice.roll_times(0) end
      assert_raise RuntimeError, error_msg, fn -> Dice.roll_times(-1) end
    end
  end
end
