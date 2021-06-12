# :tophat: :game_die: Monopoly

### Local Development

To start the server:
  * Install [Elixir](https://elixir-lang.org/install.html)
  * Install [Phoenix](https://hexdocs.pm/phoenix/installation.html#phoenix)
  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server`

The server should now be running at `localhost:4000`.

### Quickstart

To play a game, start the server and run the following command:

```sh
curl -X POST localhost:4000/api/game
```
