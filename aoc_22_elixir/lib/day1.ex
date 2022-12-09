defmodule DayOne do
  def solve_pt1 do
    # Read the input data
    calories_by_elf =
      File.read!("input/day1.txt")
      # Split the input data by newline characters
      |> String.split("\n")
      # Se valor for != "" transforma pra int
      |> Enum.map(fn line ->
        if line != "" do
          String.to_integer(line)
        end
      end)
      # Chunk by nil
      |> Enum.chunk_by(&(&1 != nil))
      # Filter out [nil]
      |> Enum.filter(fn x -> x != [nil] end)
      # For each chunk, summ it all into a value
      |> Enum.map(fn x -> Enum.reduce(x, 0, fn x, acc -> acc + x end) end)

    # Get highest value
    highest_value = Enum.max(calories_by_elf)

    IO.puts("Highest value: #{highest_value}")
  end

  def solve_pt2 do
    # Read the input data
    calories_by_elf =
      File.read!("input/day1.txt")
      # Split the input data by newline characters
      |> String.split("\n")
      # Se valor for != "" transforma pra int
      |> Enum.map(fn line ->
        if line != "" do
          String.to_integer(line)
        end
      end)
      # Chunk by nil
      |> Enum.chunk_by(&(&1 != nil))
      # Filter out [nil]
      |> Enum.filter(fn x -> x != [nil] end)
      # For each chunk, summ it all into a value
      |> Enum.map(fn x -> Enum.reduce(x, 0, fn x, acc -> acc + x end) end)
      # Getting the sum of top3
      |> Enum.sort()
      |> Enum.reverse()
      |> Enum.take(3)
      |> Enum.reduce(0, fn x, acc -> acc + x end)

    IO.puts("Top 3 elves: #{calories_by_elf}")
  end
end

# DayOne.solve_pt1()
# DayOne.solve_pt2()
