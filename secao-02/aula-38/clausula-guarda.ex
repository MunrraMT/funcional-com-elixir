defmodule MyModule.Sum do
  def to(1), do: 1
  def to(n) when n > 0 and is_integer(n), do: n + to(n - 1)
end

# Função recursiva que chama uma das funções com mesmo nome,
# diminuindo em 1, para cada execução da 2º função "to",
# até o parâmetro n, conter apenas o valor 1,
# onde será chamado a 1º função "to".

# Cláusula de guarda:
# serve como condicional para execução do corpo da função.
# Essas cláusulas tem funcionamento semelhante a um middleware em NodeJS.

# a função do kernel is_integer (is_integer(n)) Verifica se n é um número.
# operador AND, concatena cláusulas de guarda.
# o keyword WHEN (when n > 0) Verifica se n é maior que zero.

# Ao não respeitar a cláusula de guarda, ele retorna um erro e mostra qual cláusula não foi atendida.
