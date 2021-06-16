defmodule Monopoly.SpaceTest do
  use Monopoly.DataCase

  @first_index 0
  @last_index 39

  describe "#space_at" do
    test "it handles starting at 0 and rolling less than the number of spaces" do
      result = Space.space_at(@first_index, 4)
      expected = %{
        "name" => "Income Tax",
      }
      assert result == expected
    end

    test "it handles starting at 0 and rolling more than the number of spaces" do
      result = Space.space_at(@first_index, 42)
      expected = %{
        "name" => "Community Chest",
      }
      assert result == expected
    end

    test "it handles starting at 0 and rolling the number of spaces" do
      result = Space.space_at(@first_index, 40)
      expected = %{
        "name" => "Go",
      }
      assert result == expected
    end

    test "it handles starting at the last index and rolling less than the number of spaces" do
      result = Space.space_at(@last_index, 4)
      expected = %{
        "name" => "Baltic Avenue",
      }
      assert result == expected
    end

    test "it handles starting at the last index and rolling more than the number of spaces" do
      result = Space.space_at(@last_index, 42)
      expected = %{
        "name" => "Mediterranean Avenue",
      }
      assert result == expected
    end

    test "it handles starting at the last index and rolling the number of spaces" do
      result = Space.space_at(@last_index, 40)
      expected = %{
        "name" => "Boardwalk",
      }
      assert result == expected
    end
  end
end
