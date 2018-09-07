defmodule Blockchain do
  @doc "Create a new blockchain"
  def new do
    [ Crypto.put_hash(Block.zero) ]
  end

  def init do
    chain = Blockchain.new
    :ets.new(:chain, [:named_table, :set, :public])
    :ets.insert(:chain, {"chain", chain})

    chain
  end

  def get do
    [{"chain", chain}] = :ets.lookup(:chain, "chain")

    chain
  end

  @doc "Insert given data as a new block in the blockchain"
  def insert(blockchain, data) when is_list(blockchain) do
    %Block{hash: prev} = hd(blockchain)

    block =
      data
      |> Block.new(prev)
      |> Crypto.put_hash

    [ block | blockchain ]
  end

  @doc "Validate the complete blockchain"
  def valid?(blockchain) when is_list(blockchain) do
    zero = Enum.reduce_while(blockchain, nil, fn prev, current ->
      cond do
        current == nil ->
          {:cont, prev}

        Block.valid?(current, prev) ->
          {:cont, prev}

        true ->
          {:halt, false}
      end
    end)

    if zero, do: Block.valid?(zero), else: false
  end
end
