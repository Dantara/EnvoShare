defmodule ProjectWrapper do
  def get_projects do
    Blockchain.get
    |> Enum.map(fn block ->
      block_to_project(block)
    end)
    |> Enum.uniq_by(fn project ->
      project.name
    end)
    |> Enum.reject(fn p ->
      p.name == "GENESIS"
    end)
    # add deleting
  end

  def block_to_project(block) do
    %{
      name: block.name,
      description: block.description,
      hash: block.hash,
    }
  end

  def find_by_name(name) do
    Blockchain.get
    |> Enum.find(fn b ->
      b.name == name
    end)
    |> block_to_project
  end

  def find_by_hash(hash) do
    Blockchain.get
    |> Enum.find(fn b ->
      b.hash == hash
    end)
    |> block_to_project
  end
end
