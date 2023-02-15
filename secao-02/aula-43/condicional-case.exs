case :tobias do
  :manoel -> "Não é Tobias"
  10 -> "Não é número"
  :tobias -> "É o tobias!"
  _ -> "Valor default!"
end

# "É o tobias!"

case {1, 2, 3} do
  {1, x, 3} when x > 0 -> "Deu certo!"
  _ -> "Valor de saída padrão"
end

# "Deu certo!"
