defmodule MyModule.RecursaoFatorial do
  def of(0), do: 1

  def of(n) when n > 0 and is_integer(n) do
    n * of(n - 1)
  end
end

# 5 * of(4)
#       4 * of(3)
#            3 * 0f(2)
#                 2 * of(1)
#                      1
#                       === 120
