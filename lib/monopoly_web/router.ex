defmodule MonopolyWeb.Router do
  use MonopolyWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", MonopolyWeb do
    pipe_through :api
  end
end
