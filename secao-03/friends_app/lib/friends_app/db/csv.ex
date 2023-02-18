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
    |> transform_struct_to_list()
    |> wrap_in_list()
    |> prepare_list_to_save_csv
    |> save_csv_file([:append])
  end

  defp read do
    read_csv_file()
    |> parse_csv_parse_to_list()
    |> csv_list_to_friends_struct_list()
    |> show_friends()
  end

  defp collect_data do
    Shell.cmd("clear")

    %Friends{
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

  defp transform_struct_to_list(struct) do
    struct
    |> Map.from_struct()
    |> Map.values()
  end

  defp wrap_in_list(list) do
    [list]
  end

  defp prepare_list_to_save_csv(list) do
    list
    |> NimbleCSV.dump_to_iodata()
  end

  defp save_csv_file(data, mode \\ []) do
    Application.fetch_env!(:friends_app, :csv_file_path)
    |> File.write!(data, mode)
  end

  defp csv_list_to_friends_struct_list(list) do
    list
    |> Enum.map(fn [email, name, phone] -> %Friends{name: name, email: email, phone: phone} end)
  end

  defp read_csv_file do
    Application.fetch_env!(:friends_app, :csv_file_path)
    |> File.read!()
  end

  defp parse_csv_parse_to_list(csv) do
    csv
    |> NimbleCSV.parse_string(skip_headers: false)
  end

  defp show_friends(list) do
    list
    |> Scribe.console(
      data: [
        {"Nome", :name},
        {"Email", :email},
        {"Telefone", :phone}
      ]
    )
  end
end
