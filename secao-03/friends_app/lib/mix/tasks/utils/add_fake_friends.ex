defmodule Mix.Tasks.Utils.AddFakeFriends do
  use Mix.Task
  alias NimbleCSV.RFC4180, as: NimbleCSV

  @shortdoc "Add Fake Friend"
  def run(_) do
    Faker.start()

    create_friends([], 50)
    |> NimbleCSV.dump_to_iodata()
    |> save_csv_file()

    IO.puts("Amigos cadastrados com sucesso!")
  end

  defp create_friends(list, count) when count <= 1 do
    list ++ [random_list_friend()]
  end

  defp create_friends(list, count) do
    list ++ [random_list_friend()] ++ create_friends(list, count - 1)
  end

  defp random_list_friend do
    firstName = Faker.Person.PtBr.first_name()
    lastName = Faker.Person.PtBr.last_name()
    emailDomain = Faker.Internet.PtBr.free_email_service()

    nameComplete = "#{firstName} #{lastName}"
    emailComplete = "#{firstName}.#{lastName}@#{emailDomain}" |> String.downcase()

    %{
      name: nameComplete,
      email: emailComplete,
      phone: Faker.Phone.PtBr.number_with_region("(xx) 9 1542-6461")
    }
    |> Map.values()
  end

  defp save_csv_file(data) do
    Application.fetch_env!(:friends_app, :csv_file_path)
    |> File.write!(data, [:append])
  end
end
