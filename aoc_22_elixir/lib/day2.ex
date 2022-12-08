defmodule DayTwo do
  def score_play(acc, enemy, mine) do
    cond do
      # Enemy plays rock
      enemy == "A" ->
        cond do
          # I play rock, draw
          mine == "X" -> acc + 3
          # I play paper, I win
          mine == "Y" -> acc + 6
          # I play scissors, I lose
          mine == "Z" -> acc + 0
        end

      # Enemy plays paper
      enemy == "B" ->
        cond do
          # I play rock, I lose
          mine == "X" -> acc + 0
          # I play paper, draw
          mine == "Y" -> acc + 3
          # I play scissors, I win
          mine == "Z" -> acc + 6
        end

      # Enemy plays scissors
      enemy == "C" ->
        cond do
          # I play rock, I win
          mine == "X" -> acc + 6
          # I play paper, I lose
          mine == "Y" -> acc + 0
          # I play scissors, draw
          mine == "Z" -> acc + 3
        end

      true ->
        acc
    end
  end

  def add_bonus(acc, mine) do
    cond do
      mine == "X" -> acc + 1
      mine == "Y" -> acc + 2
      mine == "Z" -> acc + 3
    end
  end

  # Takes the strings for each player
  # return the score. Score is based on my (mine) play
  def rock_paper_scissors(plays) do
    enemy = List.first(plays)
    mine = List.last(plays)

    final_score =
      0
      |> score_play(enemy, mine)
      |> add_bonus(mine)

    final_score
  end

  def solve_pt1 do
    resultado =
      File.read!("input/day2.txt")
      # Split by newline
      |> String.split("\n")
      # Split each string by spaces, now its a list of list,
      # each list has two values ["enemy", "mine"]
      |> Enum.map(fn line -> String.split(line, " ") end)
      # For each list, get the score
      |> Enum.map(fn x -> rock_paper_scissors(x) end)
      # Sum all scores
      |> Enum.reduce(0, fn x, acc -> acc + x end)

    IO.puts("Resultado: #{resultado}")
  end

  ########## PART 2 vai ser totalmente diferente minha lógica, qro tentar outro jeito ###

  # Cases needing to lose
  # Oponent plays rock, I play scissors
  def play("A", "X"), do: 0 + 3
  # Oponent plays paper, I play rock
  def play("B", "X"), do: 0 + 1
  # Oponent plays scissors, I play paper
  def play("C", "X"), do: 0 + 2

  # Cases when need to draw
  # Oponent plays rock, I play rock
  def play("A", "Y"), do: 3 + 1
  # Oponent plays paper, I play paper
  def play("B", "Y"), do: 3 + 2
  # Oponent plays scissors, I play scissors
  def play("C", "Y"), do: 3 + 3

  # Cases when need to win
  # Oponent plays rock, I play paper
  def play("A", "Z"), do: 6 + 2
  # Oponent plays paper, I play scissor
  def play("B", "Z"), do: 6 + 3
  # Oponent plays scissors, I play rock
  def play("C", "Z"), do: 6 + 1

  def solve_pt2 do
    resultado =
      File.read!("input/day2.txt")
      # Split by newline
      |> String.split("\n")
      # Split each string by spaces, now its a list of list,
      # each list has two values ["oponent", "mine"]
      |> Enum.map(fn line -> String.split(line, " ") end)
      # For each list, get the score
      |> Enum.map(fn x -> play(List.first(x), List.last(x)) end)
      # Sum all scores
      |> Enum.reduce(0, fn x, acc -> acc + x end)

    # Print
    IO.puts("Resultado: #{resultado}")
  end
end

DayTwo.solve_pt1()
DayTwo.solve_pt2()
