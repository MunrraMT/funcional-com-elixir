rangeNumber = 1..5

Enum.map(rangeNumber, fn n -> n * 2 end)
# [2, 4, 6, 8, 10]

Enum.map(rangeNumber, &(&1 * 10))
# [10, 20, 30, 40, 50]

Enum.map(rangeNumber, & &1)
# [1, 2, 3, 4, 5]
