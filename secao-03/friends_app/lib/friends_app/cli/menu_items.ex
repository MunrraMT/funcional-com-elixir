defmodule FriendsApp.Cli.MenuItems do
  alias FriendsApp.Cli.Menu

  def all,
    do: [
      %Menu{label: "Cadastrar um amigo", id: :create},
      %Menu{label: "Lista um amigo", id: :read},
      %Menu{label: "Atualiza um amigo", id: :update},
      %Menu{label: "Exclui um amigo", id: :delete}
    ]
end
