defmodule MyModule.RecursionFatorialTcOptimization do
  def of(n) when n >= 0 and is_integer(n) do
    factorial_of(n, 1)
  end

  defp factorial_of(0, acc) do
    acc
  end

  defp factorial_of(n, acc) when n > 0 and is_integer(n) do
    factorial_of(n - 1, n * acc)
  end
end

# A função of é chamada com valor maior ou igual à 0, durante sua execução ele chama a função privada factorial_of passando como argumento o valor de n e o valor 1 para o acumulador.
# Quando o valor de n é 0, ele faz um pattern matching com o factorial_of com primeiro parâmetro igual à 0, retornando o segundo parâmetro;
# Quando o valor de n é maior que 0, ele faz um pattern matching com o 2º factorial_of, que recebe n(com o valor do argumento de of) e um acc(acumulador, com valor 1), quando executado ele chama a si mesmo (recursão), passando como primeiro parâmetro o resultado de n(argumento passado em of) - 1, e como segundo parâmetro, o resultado de n * acc (acumulador).
# Como estão sendo utilizados como argumento o resultado das operações e não funções, é reduzido drasticamente o tempo de execução e o uso da memória.
