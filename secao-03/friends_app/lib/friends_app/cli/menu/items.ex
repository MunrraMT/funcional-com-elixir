defmodule FriendsApp.Cli.Menu.Items do
  alias FriendsApp.Cli.Menu

  def all,
    do: [
      %Menu{label: "Cadastrar um amigo", id: :create},
      %Menu{label: "Listar um amigo", id: :read},
      %Menu{label: "Atualizar um amigo", id: :update},
      %Menu{label: "Excluir um amigo", id: :delete}
    ]
end
