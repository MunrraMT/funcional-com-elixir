defmodule FriendsApp.Db.Csv do
  alias Mix.Shell.IO, as: Shell
  alias FriendsApp.Cli.Menu
  alias FriendsApp.Cli.Friends
  alias FriendsApp.Cli.Menu.Choice
  alias NimbleCSV.RFC4180, as: NimbleCSV

  def perform(chosen_menu_item) do
    case chosen_menu_item do
      %Menu{label: _, id: :create} -> create()
      %Menu{label: _, id: :read} -> read()
      %Menu{label: _, id: :update} -> Shell.info(">>> update")
      %Menu{label: _, id: :delete} -> Shell.info(">>> delete")
    end

    Choice.start()
  end

  defp create do
    collect_data()
    |> Map.from_struct()
    |> Map.values()
    |> wrap_in_list()
    |> NimbleCSV.dump_to_iodata()
    |> save_csv_file
  end

  defp read do
    File.read!("#{File.cwd!()}/friends.csv")
    |> NimbleCSV.parse_string(skip_headers: false)
    |> Enum.map(fn [email, name, phone] ->
      %Friends{name: name, email: email, phone: phone}
    end)
    |> Scribe.console(
      data: [
        {"Nome", :name},
        {"Email", :email},
        {"Telefone", :phone}
      ]
    )
  end

  defp collect_data do
    Shell.cmd("clear")

    %Friends{
      name: prompt_message("Digite o nome:"),
      email: prompt_message("Digite o email:"),
      phone: prompt_message("Digite o phone:")
    }
    |> Map.from_struct()
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
