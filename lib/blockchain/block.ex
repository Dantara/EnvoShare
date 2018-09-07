defmodule Block do
  defstruct [:name, :description, :commands, :timestamp, :prev_hash, :hash]

  def new(data, prev_hash) do
    %Block{
      data: data,
      prev_hash: prev_hash,
      timestamp: NaiveDateTime.utc_now,
    }
  end

  def zero do
    %Block{
      name: "GENESIS",
      description: "GENESIS BLOCK"
      commands: [],
      prev_hash: "GENESIS",
      timestamp: NaiveDateTime.utc_now,
    }
  end

  @doc "Check if a block is valid"
  def valid?(%Block{} = block) do
    Crypto.hash(block) == block.hash
  end

  def valid?(%Block{} = block, %Block{} = prev_block) do
    (block.prev_hash == prev_block.hash) && valid?(block)
  end

end
