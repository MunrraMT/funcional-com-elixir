# Retorna um erro!

# factorial = fn
#   0 -> 1
#   x when x > 0 -> x * factorial.(x - 1)
# end

# Forma do curso

factor_gen = fn me ->
  fn
    0 -> 1
    x when x > 0 -> x * me.(me).(x - 1)
  end
end

# factorial = factor_gen.(factor_gen)

# Forma artigo

factor_gen2 = fn
  0, _ -> 1
  n, recur -> n * recur.(n - 1, recur)
end
