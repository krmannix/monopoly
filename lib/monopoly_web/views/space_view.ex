defmodule MonopolyWeb.SpaceView do
  use MonopolyWeb, :view

  def render("space.json", %{space: space}) do
    %{
      id: space.id,
      name: space.name,
      type: space.type,
    }
  end
end
