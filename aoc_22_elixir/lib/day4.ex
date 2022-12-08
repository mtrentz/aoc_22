defmodule DayFour do
  @doc """
  Quebra a string "n1-n2,n3-n4"
  em [n1, n2, n3, n4], ja convertendo
  para inteiros
  """
  def split_string(string) do
    string
    # This one transform to ["n1-n2", "n3-n4"]
    |> String.split(",")
    # The rest transform to [n1, n2, n3, n4]
    |> Enum.map(fn group -> String.split(group, "-") end)
    |> Enum.map(fn group -> Enum.map(group, &String.to_integer/1) end)
    |> List.flatten()
  end

  @doc """
  Confere se a range entre n3-n4 está dentro da range n1-n2
  """
  def contains(n1, n2, n3, n4) do
    # Pra isso acontecer: n3 >= n1, n3 <= n2, n4 >= n1, n4 <= n2
    n3 >= n1 and n3 <= n2 and n4 >= n1 and n4 <= n2
  end

  @doc """
  Confere se tanto a range n1-n2 quanto a range n3-n4 se sobrepõem
  """
  def overlaps(n1, n2, n3, n4) do
    # Pra isso acontecer: n1 >= n3, n1 <= n4, n2 >= n3, n2 <= n4
    contains(n1, n2, n3, n4) or contains(n3, n4, n1, n2)
  end

  def solve_pt1 do
    resultado =
      File.read!("input/day4.txt")
      |> String.split("\n")
      |> Enum.map(fn string -> split_string(string) end)
      |> Enum.map(fn [n1, n2, n3, n4] -> overlaps(n1, n2, n3, n4) end)
      # Soma true as 1 e false as 0
      |> Enum.reduce(0, fn x, acc -> if x, do: acc + 1, else: acc end)

    IO.inspect(resultado)
  end

  @doc """
  Aqui preciso só ver se tem ALGUM overlap,
  ou seja, se tem algum n1-n2 que se sobrepõe
  com algum n3-n4.
  """
  def overlaps_pt2(n1, n2, n3, n4) do
    r1 = Enum.to_list(n1..n2)
    r2 = Enum.to_list(n3..n4)

    # Ve se a range do MapSet.intersection entre r1 e r2
    # é maior que zero
    MapSet.intersection(MapSet.new(r1), MapSet.new(r2))
    |> Enum.count() > 0
  end

  def solve_pt2 do
    resultado =
      File.read!("input/day4.txt")
      |> String.split("\n")
      |> Enum.map(fn string -> split_string(string) end)
      |> Enum.map(fn [n1, n2, n3, n4] -> overlaps_pt2(n1, n2, n3, n4) end)
      # Soma true as 1 e false as 0
      |> Enum.reduce(0, fn x, acc -> if x, do: acc + 1, else: acc end)

    IO.inspect(resultado)
  end
end

DayFour.solve_pt1()
DayFour.solve_pt2()
