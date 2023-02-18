defmodule FriendsApp.Db.Csv do
  alias FriendsApp.Cli.Menu
  alias FriendsApp.Cli.Menu.Choice
  alias FriendsApp.Db.Csv.Utils

  def perform(chosen_menu_item) do
    case chosen_menu_item do
      %Menu{label: _, id: :create} -> create()
      %Menu{label: _, id: :read} -> read()
      %Menu{label: _, id: :update} -> update()
      %Menu{label: _, id: :delete} -> delete()
    end

    Choice.start()
  end

  defp create do
    Utils.collect_data()
    |> Utils.transform_struct_to_list()
    |> Utils.wrap_in_list()
    |> Utils.prepare_list_to_save_csv()
    |> Utils.save_csv_file([:append])
  end

  defp read do
    Utils.read_csv_file()
    |> Utils.parse_csv_parse_to_list()
    |> Utils.csv_list_to_friends_struct_list()
    |> Utils.show_friends_list()
  end

  defp delete do
    Utils.clear_terminal()

    Utils.prompt_message("Digite o email do amigo a ser excluido: ")
    |> Utils.search_friend_by_email()
    |> Utils.check_friend_found()
    |> Utils.confirm_message("Deseja realmente apagar esse amigo da sua lista?")
    |> Utils.delete_and_save()
  end

  defp update do
    Utils.clear_terminal()

    Utils.prompt_message("Digite o email do amigo que deseja atualizar:")
    |> Utils.search_friend_by_email()
    |> Utils.check_friend_found()
    |> Utils.confirm_message("Deseja realmente atualizar o email do seu amigo?")
    |> Utils.do_update()
  end
end
