defmodule Monopoly.GameTest do
  use Monopoly.DataCase
  alias Monopoly.Game

  describe "#find" do
    test "it finds an existing Game by id" do
      game = Monopoly.Factory.insert!(:game)
      result = Game.find(game.id) |> Monopoly.Repo.preload(:players)

      assert result == game
    end

    test "it does not find an existing Game and returns nil" do
      result = Game.find("1")

      assert is_nil(result)
    end
  end
end
