defmodule FriendsApp.Db.Csv do
  alias Mix.Shell.IO, as: Shell
  alias FriendsApp.Cli.Menu

  def perform(chosen_menu_item) do
    case chosen_menu_item do
      %Menu{label: _, id: :create} -> Shell.info(">>> create")
      %Menu{label: _, id: :read} -> Shell.info(">>> read")
      %Menu{label: _, id: :update} -> Shell.info(">>> update")
      %Menu{label: _, id: :delete} -> Shell.info(">>> delete")
    end
  end
end
