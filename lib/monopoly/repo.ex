defmodule Monopoly.Repo do
  use Ecto.Repo,
    otp_app: :monopoly,
    adapter: Ecto.Adapters.Postgres,
    migration_primary_key: [name: :id, type: :binary_id]
end
