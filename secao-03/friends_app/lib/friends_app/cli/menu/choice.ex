defmodule FriendsApp.Cli.Menu.Choice do
  alias Mix.Shell.IO, as: Shell
  alias FriendsApp.Cli.Menu.Items
  alias FriendsApp.Db.Csv

  def start do
    Shell.cmd("clear")
    Shell.info("Escolha uma opção:\n")

    menu_itens = Items.all()

    menu_itens
    |> Enum.map(& &1.label)
    |> display_options()
    |> generate_question()
    |> Shell.prompt()
    |> parse_answer()
    |> find_menu_item_by_index(menu_itens)
    |> confirm_menu_item()
    |> confirm_message()
    |> Csv.perform()
  end

  defp display_options(options) do
    options
    |> Enum.with_index(1)
    |> Enum.each(fn {option, index} -> Shell.info("#{index} - #{option}") end)

    options
  end

  defp generate_question(options) do
    options = Enum.join(1..Enum.count(options), ",")
    "\nQual das opções acima vc escolhe? [#{options}]\n"
  end

  defp error_message do
    Shell.cmd("clear")
    Shell.info("Valor não válido")
    Shell.prompt("Aperte enter para escolher novamente\n")
    start()
  end

  defp parse_answer(answer) do
    case Integer.parse(answer) do
      :error -> error_message()
      {option, _} -> option - 1
    end
  end

  defp find_menu_item_by_index(chosen_menu_item, options) do
    case chosen_menu_item do
      -1 -> error_message()
      _ -> Enum.at(options, chosen_menu_item, :error)
    end
  end

  defp confirm_menu_item(chosen_menu_item) do
    case chosen_menu_item do
      :error -> error_message()
      _ -> chosen_menu_item
    end
  end

  defp confirm_message(chosen_menu_item) do
    Shell.cmd("clear")
    Shell.info("Você escolheu... [#{chosen_menu_item.label}]")

    case(Shell.yes?("Confirma?")) do
      true -> chosen_menu_item
      false -> start()
    end
  end
end
