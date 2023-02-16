defmodule Mix.Tasks.Start do
  use Mix.Task

  @shortdoc "Start [Friends App]"
  def run(_) do
    FriendsApp.Cli.Main.start_app()
  end
end
