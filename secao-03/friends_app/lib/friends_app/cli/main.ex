defmodule FriendsApp.Cli.Main do
  alias Mix.Shell.IO, as: Shell

  def start_app do
    Shell.cmd("clear")
    welcome_message()
    Shell.prompt("Pressione Enter para continuar...")

    FriendsApp.Cli.Menu.Choice.start()
    |> FriendsApp.Db.Csv.perform()
  end

  defp welcome_message do
    Shell.info("============ Friends App ============")
    Shell.info("Seja bem-vindo a sua agenda pessoal!!")
    Shell.info("=====================================")
  end
end
