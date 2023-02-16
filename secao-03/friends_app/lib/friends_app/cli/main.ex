defmodule FriendsApp.Cli.Main do
  alias Mix.Shell.IO, as: Shell

  def start_app do
    Shell.cmd("clear")
    welcome_message()
    Shell.prompt("Pressione Enter para continuar...")
    starts_menu_choice()
  end

  defp welcome_message do
    Shell.info("============ Friends App ============")
    Shell.info("Seja bem-vindo a sua agenda pessoal!!")
    Shell.info("=====================================")
  end

  defp starts_menu_choice do
    FriendsApp.Cli.Menu.Choice.start()
  end
end
