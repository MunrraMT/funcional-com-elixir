defmodule FriendsApp.Db.Csv do
  alias Mix.Shell.IO, as: Shell
  alias FriendsApp.Cli.Menu
  alias FriendsApp.Cli.Friends
  alias FriendsApp.Cli.Menu.Choice
  alias NimbleCSV.RFC4180, as: NimbleCSV

  def perform(chosen_menu_item) do
    case chosen_menu_item do
      %Menu{label: _, id: :create} -> create()
      %Menu{label: _, id: :read} -> Shell.info(">>> read")
      %Menu{label: _, id: :update} -> Shell.info(">>> update")
      %Menu{label: _, id: :delete} -> Shell.info(">>> delete")
    end
  end

  defp create do
    collect_data
    |> Map.values()
    |> wrap_in_list()
    |> NimbleCSV.dump_to_iodata()
    |> save_csv_file
  end

  defp collect_data do
    Shell.cmd("clear")

    %{
      name: prompt_message("Digite o nome:"),
      email: prompt_message("Digite o email:"),
      phone: prompt_message("Digite o phone:")
    }
  end

  defp prompt_message(message) do
    message
    |> Shell.prompt()
    |> String.trim()
  end

  defp wrap_in_list(list) do
    [list]
  end

  defp save_csv_file(data) do
    File.write!("#{File.cwd!()}/friends.csv", data, [:append])
  end
end
