defmodule DayThree do
  @doc """
  Gera um mapa que mapeia a-z e A-Z para 1-52
  """
  def get_value_map do
    lower_letters =
      ?a..?z
      |> Enum.to_list()
      |> List.to_string()
      |> String.codepoints()

    # Range 1 from 26
    lower_values = Enum.to_list(1..26)

    # Zipa os lower
    lower = Enum.zip(lower_letters, lower_values)

    upper_letters =
      ?A..?Z
      |> Enum.to_list()
      |> List.to_string()
      |> String.codepoints()

    upper_values =
      27..52
      |> Enum.to_list()

    # Zipa os upper
    upper = Enum.zip(upper_letters, upper_values)

    # Cria mapa com letra pra valor
    value_map = Enum.into(lower ++ upper, %{})

    value_map
  end

  #   Separate string in half
  def split_string(string) do
    res =
      string
      |> String.codepoints()
      |> Enum.chunk_every(round(String.length(string) / 2))

    res
  end

  def find_intersection(list1, list2) do
    MapSet.intersection(MapSet.new(list1), MapSet.new(list2))
    |> MapSet.to_list()
    |> List.first()
  end

  def solve_pt1 do
    value_map = get_value_map()

    # Read the input data
    resultado =
      File.read!("input/day3.txt")
      |> String.split("\n")
      #   Split string in half
      |> Enum.map(&split_string/1)
      #  Find intersection
      |> Enum.map(&find_intersection(List.first(&1), List.last(&1)))
      # Get the value
      |> Enum.map(&value_map[&1])
      # Sum all values
      |> Enum.reduce(0, fn x, acc -> acc + x end)

    IO.inspect(resultado)
  end

  @doc """
  Finds the intersection between 3 strings
  """
  def find_intersection_pt2(str1, str2, str3) do
    # Transforma cada string em uma lista de letras
    list1 = str1 |> String.codepoints()
    list2 = str2 |> String.codepoints()
    list3 = str3 |> String.codepoints()
    # Primeiro pega a interseção entre 1 e 2
    # Depois pega a interseção entre o resultado e 3
    MapSet.intersection(MapSet.new(list1), MapSet.new(list2))
    |> MapSet.intersection(MapSet.new(list3))
    |> MapSet.to_list()
    |> List.first()
  end

  def solve_pt2 do
    value_map = get_value_map()

    # Read the input data
    resultado =
      File.read!("input/day3.txt")
      |> String.split("\n")
      # Chunk every 3 items
      |> Enum.chunk_every(3)
      |> Enum.map(&find_intersection_pt2(Enum.at(&1, 0), Enum.at(&1, 1), Enum.at(&1, 2)))
      # Get the value
      |> Enum.map(&value_map[&1])
      # Sum all values
      |> Enum.reduce(0, fn x, acc -> acc + x end)

    IO.inspect(resultado)
  end
end

# DayThree.solve_pt1()
# DayThree.solve_pt2()
