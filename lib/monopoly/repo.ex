defmodule Monopoly.Repo do
  use Ecto.Repo,
    otp_app: :monopoly,
    adapter: Ecto.Adapters.Postgres
end
