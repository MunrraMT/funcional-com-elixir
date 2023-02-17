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
    [
      Faker.Person.PtBr.name(),
      Faker.Internet.PtBr.free_email_service(),
      Faker.Phone.PtBr.number_with_region("(xx) 9 1542-6461")
    ]
  end

  defp save_csv_file(data) do
    File.write!("#{File.cwd!()}/friends.csv", data, [:append])
  end
end
