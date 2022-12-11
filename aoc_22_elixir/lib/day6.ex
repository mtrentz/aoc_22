defmodule DaySix do
  def all_unique(list) do
    length(list) == length(Enum.uniq(list))
  end

  def solve_pt1 do
    resultado =
      File.read!("input/day6.txt")
      |> String.codepoints()
      |> Enum.reduce(
        %{
          buffer: [],
          index: 0,
          found: false
        },
        fn letter, acc ->
          cond do
            # If not enough length, just add to buffer and increment index
            length(acc.buffer) < 4 ->
              %{buffer: acc.buffer ++ [letter], index: acc.index + 1, found: false}

            # If all unique and not yet found, add to buffer, increment index and set found to true
            all_unique(acc.buffer) and not acc.found ->
              %{buffer: acc.buffer, index: acc.index, found: true}

            # If yet not found, remove first from buffer, add new element and increment index
            acc.found == false ->
              %{
                buffer: Enum.slice(acc.buffer, 1, 3) ++ [letter],
                index: acc.index + 1,
                found: false
              }

            # Default, does nothing
            true ->
              acc
          end
        end
      )

    IO.inspect(resultado)
  end

  def solve_pt2 do
    resultado =
      File.read!("input/day6.txt")
      |> String.codepoints()
      |> Enum.reduce(
        %{
          buffer: [],
          index: 0,
          found: false
        },
        fn letter, acc ->
          cond do
            # If not enough length, just add to buffer and increment index
            length(acc.buffer) < 14 ->
              %{buffer: acc.buffer ++ [letter], index: acc.index + 1, found: false}

            # If all unique and not yet found, add to buffer, increment index and set found to true
            all_unique(acc.buffer) and not acc.found ->
              %{buffer: acc.buffer, index: acc.index, found: true}

            # If yet not found, remove first from buffer, add new element and increment index
            acc.found == false ->
              %{
                buffer: Enum.slice(acc.buffer, 1, 13) ++ [letter],
                index: acc.index + 1,
                found: false
              }

            # Default, does nothing
            true ->
              acc
          end
        end
      )

    IO.inspect(resultado)
  end

  def solve_test do
    {:ok, datastream} = File.read("input/day6.txt")

    res =
      datastream
      |> String.graphemes()
      # DEVERIA TER USADO ISSO
      |> Enum.chunk_every(4, 1, :discard)

    # E tb Enum.uniq

    IO.inspect(res)
  end
end

DaySix.solve_pt1()
DaySix.solve_pt2()
# DaySix.solve_test()
