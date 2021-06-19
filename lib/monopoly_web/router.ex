defmodule MonopolyWeb.Router do
  use MonopolyWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api/v1", MonopolyWeb do
    pipe_through :api

    post "/roll", GameController, :roll
  end
end
