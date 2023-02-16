defmodule FriendsApp.Cli.MenuChoice do
  alias Mix.Shell.IO, as: Shell
  alias FriendsApp.Cli.MenuItems

  def start do
    Shell.cmd("clear")
    Shell.info("Escolha uma opção:")

    MenuItems.all()
    |> Enum.map(& &1.label)
    |> display_options
  end

  defp display_options(options) do
    options
    |> Enum.with_index(1)
    |> Enum.each(fn {option, index} -> Shell.info("#{index} - #{option}") end)
  end
end
