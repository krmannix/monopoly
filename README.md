# :tophat: :game_die: Monopoly

Monopoly via an API.

Features included in upcoming v0.2.0:
* Creating a game with 2-4 players (but only 1 human player, you!)
* Re-rolling on doubles
* Purchasing property

Upcoming Features:
* Paying rent
* Community Chest & Chance cards
* Going to Jail on three double rolls in a row
* Jail (Get Out of Jail Free card, paying one's way out of Jail, getting into Jail)
* Mortgaging a property
* Purchasing houses / hotels
* Selling houses / hotels
* And so much more!

## Local Development

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
