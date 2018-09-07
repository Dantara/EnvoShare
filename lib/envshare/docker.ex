defmodule Docker do
  def make_dockerfile(commands) do
    content = Enum.join(commands, "\n")
    Path.expand('./docker/Makefile') |> Path.absname |> File.write(content, [:write])

    :ok
  end

  def run(command) do
    head =
      command
      |> String.split(" ")
      |> hd

      tail =
        command
        |> String.split(" ")
        |> tl

    System.cmd(head, tail)
  end
end
