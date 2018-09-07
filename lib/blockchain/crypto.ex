defmodule Crypto do
  @hash_fields [:name, :description, :commands, :timestamp, :prev_hash]

  @doc "Calculate hash of block"
  def hash(%{} = block) do
    block
    |> Map.take(@hash_fields)
    |> Poison.encode!
    |> sha256
  end

  @doc "Calculate and put hash in the block"
  def put_hash(%{} = block) do
    %{ block | hash: hash(block) }
  end

  defp sha256(binary) do
    :crypto.hash(:sha256, binary) |> Base.encode16
  end

end
