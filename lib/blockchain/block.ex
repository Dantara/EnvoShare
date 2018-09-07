defmodule Block do
  defstruct [:name, :run, :description, :commands, :timestamp, :prev_hash, :hash]

  def new(data, prev_hash) do
    %Block{
      name: data.name,
      description: data.description,
      commands: data.commands,
      run: data.run,
      prev_hash: prev_hash,
      timestamp: NaiveDateTime.utc_now,
    }
  end

  def zero do
    %Block{
      name: "GENESIS",
      description: "GENESIS BLOCK",
      commands: [],
      run: "echo 'genesis'",
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
