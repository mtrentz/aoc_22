defmodule DayFive do
  def get_crates() do
    [
      ["N", "D", "M", "Q", "B", "P", "Z"],
      [
        "C",
        "L",
        "Z",
        "Q",
        "M",
        "D",
        "H",
        "V"
      ],
      [
        "Q",
        "H",
        "R",
        "D",
        "V",
        "F",
        "Z",
        "G"
      ],
      [
        "H",
        "G",
        "D",
        "F",
        "N"
      ],
      [
        "N",
        "F",
        "Q"
      ],
      [
        "D",
        "Q",
        "V",
        "Z",
        "F",
        "B",
        "T"
      ],
      [
        "Q",
        "M",
        "T",
        "Z",
        "D",
        "V",
        "S",
        "H"
      ],
      [
        "M",
        "G",
        "F",
        "P",
        "N",
        "Q"
      ],
      [
        "B",
        "W",
        "R",
        "M"
      ]
    ]
  end

  def make_move(crates, fr, to) do
    # Get the stack in fr   
    fr_stack = Enum.at(crates, fr)
    # Pop the last value of the stack
    {move, fr_stack} = List.pop_at(fr_stack, -1)
    # Get the stack in to
    to_stack = Enum.at(crates, to)
    # Add move to the end of to_stack
    to_stack = List.insert_at(to_stack, -1, move)
    # Replace the stacks in crates
    crates = List.replace_at(crates, fr, fr_stack)
    crates = List.replace_at(crates, to, to_stack)
    crates
  end

  def make_move(crates, amnt, fr, to) do
    crates =
      Enum.reduce(
        1..amnt,
        crates,
        fn _, acc ->
          make_move(acc, fr, to)
        end
      )

    crates
  end

  def solve_pt1 do
    crates = get_crates()
    IO.puts("Starting crates")
    IO.inspect(crates)
    IO.puts("")

    resposta =
      File.read!("input/day5.txt")
      |> String.split("\n")
      |> Enum.map(fn string -> String.split(string, " ") end)
      # Now I'll return a list of [e1, e3, e5]
      # which are the movement numbers
      |> Enum.map(fn [_, e1, _, e2, _, e3] ->
        [String.to_integer(e1), String.to_integer(e2), String.to_integer(e3)]
      end)
      |> Enum.reduce(crates, fn [amnt, fr, to], acc ->
        make_move(acc, amnt, fr - 1, to - 1)
      end)
      |> Enum.map(fn stack -> List.last(stack) end)
      #   Reduce to a single string
      |> Enum.join("")

    IO.inspect(resposta)
  end

  ###### PT 2 ########

  def make_move_pt2(crates, amnt, fr, to) do
    # Get the stack in fr   
    fr_stack = Enum.at(crates, fr)
    # Get the last amnt elements
    move = Enum.slice(fr_stack, -amnt, amnt)
    # Remove the last amnt elements
    fr_stack = Enum.slice(fr_stack, 0, length(fr_stack) - amnt)
    # Get the stack in to
    to_stack = Enum.at(crates, to)
    # Add move to the end of to_stack
    to_stack = to_stack ++ move
    # Replace the stacks in crates
    crates = List.replace_at(crates, fr, fr_stack)
    crates = List.replace_at(crates, to, to_stack)
    crates
  end

  def solve_pt2 do
    IO.puts("Starting pt2")
    crates = get_crates()
    IO.puts("Starting crates")
    IO.inspect(crates)
    IO.puts("")

    resposta =
      File.read!("input/day5.txt")
      |> String.split("\n")
      |> Enum.map(fn string -> String.split(string, " ") end)
      |> Enum.map(fn [_, e1, _, e2, _, e3] ->
        [String.to_integer(e1), String.to_integer(e2), String.to_integer(e3)]
      end)
      |> Enum.reduce(crates, fn [amnt, fr, to], acc ->
        make_move_pt2(acc, amnt, fr - 1, to - 1)
      end)
      |> Enum.map(fn stack -> List.last(stack) end)
      |> Enum.join("")

    IO.inspect(resposta)
  end
end

DayFive.solve_pt1()
DayFive.solve_pt2()
