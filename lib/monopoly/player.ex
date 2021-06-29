defmodule Player do
  @derive Jason.Encoder
  defstruct id: nil,
            name: "Default Player",
            money: 1500,
            isBankrupt: false,
            isHumanPlayer: false,
            currentSpace: nil,
            properties: [],
            getOutOfJailFreeCardCount: 0
end
