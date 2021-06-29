defmodule SimpleGame do
  @derive Jason.Encoder
  defstruct id: nil,
            players: []
end
