x = 10

cond do
  x + 1 == 10 -> "é igual a 10"
  x + 1 == 11 -> "é igual a 11"
  x + 2 == 12 -> "é igual a 12"
end

# "é igual a 11"

x = 20

cond do
  x + 1 == 10 -> "é igual a 10"
  x + 1 == 11 -> "é igual a 11"
  x + 2 == 12 -> "é igual a 12"
end

# ** (CondClauseError) no cond clause evaluated to a truthy value
#     iex:16: (file)
