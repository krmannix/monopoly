defmodule Util do
  @moduledoc "Junk drawer module of helpful, generic utilities"

  def load_json_from_file!(filename) do
    with body <- File.read!(filename),
         json <- Poison.decode!(body), do: json
  end
end
