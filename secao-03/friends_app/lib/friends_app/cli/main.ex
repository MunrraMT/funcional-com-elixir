defmodule FriendsApp.Cli.Main do
  alias Mix.Shell.IO, as: Shell
  alias FriendsApp.Cli.Menu.Choice
  alias FriendsApp.Db.Csv

  def start_app do
    Shell.cmd("clear")
    welcome_message()
    Shell.prompt("Pressione Enter para continuar...")

    Choice.start()
    |> Csv.perform()

    Choice.start()
  end

  defp welcome_message do
    Shell.info("============ Friends App ============")
    Shell.info("Seja bem-vindo a sua agenda pessoal!!")
    Shell.info("=====================================")
  end
end
