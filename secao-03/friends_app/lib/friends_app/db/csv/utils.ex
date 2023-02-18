defmodule FriendsApp.Db.Csv.Utils do
  alias Mix.Shell.IO, as: Shell
  alias FriendsApp.Cli.Friends
  alias FriendsApp.Cli.Menu.Choice
  alias NimbleCSV.RFC4180, as: NimbleCSV

  def collect_data do
    clear_terminal()

    %Friends{
      name: prompt_message("Digite o nome:"),
      email: prompt_message("Digite o email:"),
      phone: prompt_message("Digite o phone:")
    }
  end

  def clear_terminal do
    Shell.cmd("clear")
  end

  def prompt_message(message) do
    message
    |> Shell.prompt()
    |> String.trim()
  end

  def transform_struct_to_list(struct) do
    struct
    |> Map.from_struct()
    |> Map.values()
  end

  def wrap_in_list(list) do
    [list]
  end

  def prepare_list_to_save_csv(list) do
    list
    |> NimbleCSV.dump_to_iodata()
  end

  def save_csv_file(data, mode \\ []) do
    Application.fetch_env!(:friends_app, :csv_file_path)
    |> File.write!(data, mode)
  end

  def csv_list_to_friends_struct_list(list) do
    list
    |> Enum.map(fn [email, name, phone] -> %Friends{name: name, email: email, phone: phone} end)
  end

  def read_csv_file do
    Application.fetch_env!(:friends_app, :csv_file_path)
    |> File.read!()
  end

  def parse_csv_parse_to_list(csv) do
    csv
    |> NimbleCSV.parse_string(skip_headers: false)
  end

  def show_friends_list(list) do
    list
    |> Scribe.console(
      data: [
        {"Nome", :name},
        {"Email", :email},
        {"Telefone", :phone}
      ]
    )
  end

  def search_friend_by_email(email) do
    read_csv_file()
    |> parse_csv_parse_to_list()
    |> csv_list_to_friends_struct_list()
    |> Enum.find(:not_found, fn list -> list.email == email end)
  end

  def check_friend_found(friend) do
    case friend do
      :not_found ->
        clear_terminal()
        Shell.error("Amigo não encontrado")
        return_message()
        Choice.start()

      _ ->
        friend
    end
  end

  def return_message do
    prompt_message("Pressione ENTER para continuar")
  end

  def confirm_message(friend, message) do
    clear_terminal()
    Shell.info("Encontramos...")

    friend
    |> show_friend()

    case Shell.yes?(message) do
      true -> friend
      false -> :error
    end
  end

  def show_friend(friend) do
    friend
    |> Scribe.print(
      data: [
        {"Nome", :name},
        {"Email", :email},
        {"Telefone", :phone}
      ]
    )
  end

  def delete_friend(friend) do
    read_csv_file()
    |> parse_csv_parse_to_list()
    |> csv_list_to_friends_struct_list()
    |> delete_friend_from_struct_list(friend)
    |> friend_list_to_csv()
    |> prepare_list_to_save_csv()
    |> save_csv_file()
  end

  def delete_and_save(friend) do
    case friend do
      :error ->
        Shell.info("Ok, o amigo NÃO será excluído...")
        return_message()

      _ ->
        friend
        |> delete_friend()

        Shell.info("Amigo excluído com sucesso!")
        return_message()
    end
  end

  def delete_friend_from_struct_list(friends_list, friend) do
    friends_list
    |> Enum.reject(fn elem -> elem.email == friend.email end)
  end

  def friend_list_to_csv(friends_list) do
    friends_list
    |> Enum.map(fn item -> [item.email, item.name, item.phone] end)
  end

  def do_update(friend) do
    case friend do
      :error ->
        Shell.info("Ok, o amigo NÃO será atualizado...")
        return_message()

      _ ->
        clear_terminal()
        Shell.info("Agora você irá digitar os novos dados do seu amigo...")

        update_friends = collect_data()

        friend
        |> delete_friend()

        update_friends
        |> transform_struct_to_list()
        |> wrap_in_list()
        |> prepare_list_to_save_csv()
        |> save_csv_file([:append])

        Shell.info("Amigo atualizado com sucesso!")
        return_message()
    end
  end
end
