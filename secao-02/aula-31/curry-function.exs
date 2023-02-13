curry_function = fn a -> fn b -> a + b end end

# 3
curry_function.(1).(2) |> IO.puts()

# 5
teste_a = curry_function.(2)
teste_b = teste_a.(3)
teste_b |> IO.puts()
