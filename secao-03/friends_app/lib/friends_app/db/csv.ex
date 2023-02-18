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
      %Menu{label: _, id: :update} -> update()
      %Menu{label: _, id: :delete} -> delete()
    end

    Choice.start()
  end

  defp create do
    collect_data()
    |> transform_struct_to_list()
    |> wrap_in_list()
    |> prepare_list_to_save_csv()
    |> save_csv_file([:append])
  end

  defp read do
    read_csv_file()
    |> parse_csv_parse_to_list()
    |> csv_list_to_friends_struct_list()
    |> show_friends_list()
  end

  defp delete do
    clear_terminal()

    prompt_message("Digite o email do amigo a ser excluido: ")
    |> search_friend_by_email()
    |> check_friend_found()
    |> confirm_delete()
    |> delete_and_save()
  end

  defp update do
    clear_terminal()

    prompt_message("Digite o email do amigo que deseja atualizar:")
    |> search_friend_by_email()
    |> check_friend_found()
    |> confirm_update()
    |> do_update()
  end

  defp collect_data do
    clear_terminal()

    %Friends{
      name: prompt_message("Digite o nome:"),
      email: prompt_message("Digite o email:"),
      phone: prompt_message("Digite o phone:")
    }
  end

  defp clear_terminal do
    Shell.cmd("clear")
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

  defp show_friends_list(list) do
    list
    |> Scribe.console(
      data: [
        {"Nome", :name},
        {"Email", :email},
        {"Telefone", :phone}
      ]
    )
  end

  defp search_friend_by_email(email) do
    read_csv_file()
    |> parse_csv_parse_to_list()
    |> csv_list_to_friends_struct_list()
    |> Enum.find(:not_found, fn list -> list.email == email end)
  end

  defp check_friend_found(friend) do
    case friend do
      :not_found ->
        clear_terminal()
        Shell.error("Amigo não encontrado")
        prompt_message("Pressione ENTER para continuar")
        Choice.start()

      _ ->
        friend
    end
  end

  defp confirm_delete(friend) do
    clear_terminal()
    Shell.info("Encontramos...")

    friend
    |> show_friend()

    case Shell.yes?("Deseja realmente apagar esse amigo da sua lista?") do
      true -> friend
      false -> :error
    end
  end

  defp show_friend(friend) do
    friend
    |> Scribe.print(
      data: [
        {"Nome", :name},
        {"Email", :email},
        {"Telefone", :phone}
      ]
    )
  end

  defp delete_and_save(friend) do
    case friend do
      :error ->
        Shell.info("Ok, o amigo NÃO será excluído...")
        prompt_message("Pressione ENTER para continuar")

      _ ->
        read_csv_file()
        |> parse_csv_parse_to_list()
        |> csv_list_to_friends_struct_list()
        |> delete_friend_from_struct_list(friend)
        |> friend_list_to_csv()
        |> prepare_list_to_save_csv()
        |> save_csv_file()

        Shell.info("Amigo excluído com sucesso!")
        prompt_message("Pressione ENTER para continuar")
    end
  end

  defp delete_friend_from_struct_list(friends_list, friend) do
    friends_list
    |> Enum.reject(fn elem -> elem.email == friend.email end)
  end

  defp friend_list_to_csv(friends_list) do
    friends_list
    |> Enum.map(fn item -> [item.email, item.name, item.phone] end)
  end

  defp confirm_update(friend) do
    clear_terminal()
    Shell.info("Encontramos...")

    friend
    |> show_friend()

    case Shell.yes?("Deseja realmente atualizar o email do seu amigo?") do
      true -> friend
      false -> :error
    end
  end

  defp do_update(friend) do
    case friend do
      :error ->
        Shell.info("Ok, o amigo NÃO será atualizado...")
        prompt_message("Pressione ENTER para continuar")

      _ ->
        clear_terminal()
        Shell.info("Agora você irá digitar os novos dados do seu amigo...")

        update_friends = collect_data()

        read_csv_file()
        |> parse_csv_parse_to_list()
        |> csv_list_to_friends_struct_list()
        |> delete_friend_from_struct_list(friend)
        |> friend_list_to_csv()
        |> prepare_list_to_save_csv()
        |> save_csv_file()

        update_friends
        |> transform_struct_to_list()
        |> wrap_in_list()
        |> prepare_list_to_save_csv()
        |> save_csv_file([:append])

        Shell.info("Amigo atualizado com sucesso!")
        prompt_message("Pressione ENTER para continuar")
    end
  end
end
