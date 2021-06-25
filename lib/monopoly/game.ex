defmodule Game do
  @derive Jason.Encoder
  defstruct id: nil,
            players: []
end
