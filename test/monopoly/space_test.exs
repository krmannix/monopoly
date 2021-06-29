defmodule Monopoly.SpaceTest do
  use Monopoly.DataCase

  @first_index 0
  @last_index 39

  describe "#space_at" do
    test "it handles starting at 0 and rolling less than the number of spaces" do
      result = Space.space_at(@first_index, 4)
      expected = %{
        "id" => "8afe3723-4439-4a75-b99e-3e4f0f5646aa",
        "name" => "Income Tax",
        "type" => "property",
      }
      assert result == expected
    end

    test "it handles starting at 0 and rolling more than the number of spaces" do
      result = Space.space_at(@first_index, 42)
      expected = %{
        "id" => "6cba37bd-a6ac-499e-b701-58333790e996",
        "name" => "Community Chest",
        "type" => "community_chest",
      }
      assert result == expected
    end

    test "it handles starting at 0 and rolling the number of spaces" do
      result = Space.space_at(@first_index, 40)
      expected = %{
        "id" => "8c826137-989e-4b3c-bbeb-ae2aa83930b7",
        "name" => "Go",
        "type" => "go",
      }
      assert result == expected
    end

    test "it handles starting at the last index and rolling less than the number of spaces" do
      result = Space.space_at(@last_index, 4)
      expected = %{
        "id" => "6d48a337-3ad0-4283-a9a1-42f161300460",
        "name" => "Baltic Avenue",
        "type" => "property",
      }
      assert result == expected
    end

    test "it handles starting at the last index and rolling more than the number of spaces" do
      result = Space.space_at(@last_index, 42)
      expected = %{
        "id" => "ae5ce454-9aeb-4660-a318-cc635def636d",
        "name" => "Mediterranean Avenue",
        "type" => "property",
      }
      assert result == expected
    end

    test "it handles starting at the last index and rolling the number of spaces" do
      result = Space.space_at(@last_index, 40)
      expected = %{
        "id" => "256b3b66-60d1-4796-817e-84a3f7b36b23",
        "name" => "Boardwalk",
        "type" => "property",
      }
      assert result == expected
    end
  end
end
