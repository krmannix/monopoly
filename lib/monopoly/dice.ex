defmodule Monopoly.Dice do
  def roll_times(count) when is_integer(count) and count >= 1 do Enum.map(1..count, fn (_) -> single_roll() end) end
  def roll_times(_count) do raise "count must be an integer greater than or equal to 1" end

  defp single_roll do :rand.uniform(6) end
end
