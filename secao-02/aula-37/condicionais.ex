defmodule MyModule.ComparaNumero do
  def maior(n1, n2) do
    check(n1 >= n2, n1, n2)
  end

  defp check(true, n1, _), do: n1
  defp check(false, _, n2), do: n2
end

# O pattern matching do elixir verifica a igualdade do primeiro parâmetro
# para selecionar qual a função privada deve ser executada, pois ambos
# tem o mesmo nome. Após o matching, a função é executada.

# Não utilizando condicionais como if em Javascript
