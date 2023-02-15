rangeNumbers = 1..9

Enum.take(rangeNumbers, 3)
# [1, 2, 3]

1..9 |> Enum.take(3)
# [1, 2, 3]

rangeNumbers = 1..5_000_000

Enum.take(Enum.map(rangeNumbers, & &1), 10)
# [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

Enum.map(rangeNumbers, & &1) |> Enum.take(10)
# [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

Stream.map(rangeNumbers, & &1) |> Enum.take(10)
# [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
