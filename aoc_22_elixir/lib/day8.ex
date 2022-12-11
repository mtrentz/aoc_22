defmodule DayEight do
  def transpose(matrix) do
    matrix
    |> List.zip()
    |> Enum.map(&Tuple.to_list/1)
  end

  def visible_horizontal?(matrix, row_pos, col_pos) do
    row = Enum.at(matrix, row_pos)

    left = Enum.take(row, col_pos)
    right = Enum.drop(row, col_pos + 1)

    val = Enum.at(row, col_pos)

    cond do
      # If val is higher than any on left, then its visible
      Enum.all?(left, fn x -> val > x end) -> true
      # If val is higher than any on right, then its visible
      Enum.all?(right, fn x -> val > x end) -> true
      true -> false
    end
  end

  # This is a visible horizontal but the matrix is 
  # transposed and the row and col are inverted
  def visible_vertical?(matrix, row, col) do
    transposed = transpose(matrix)
    # Flip row and col
    [row, col] = [col, row]

    # Now check if visible horizontal on the transposed matrix
    visible_horizontal?(transposed, row, col)
  end

  def solve_pt1 do
    matrix =
      File.read!("input/day8.txt")
      |> String.split("\n")
      |> Enum.map(&String.codepoints(&1))
      # Convert to int
      |> Enum.map(fn row ->
        Enum.map(row, fn char ->
          String.to_integer(char)
        end)
      end)

    # Map list of list and print the value, row index and col index
    r =
      matrix
      |> Enum.map(fn row ->
        Enum.with_index(row)
      end)
      |> Enum.with_index()
      # This transform into a list of list, where elemnts are
      # {val, row_index, col_index}
      |> Enum.map(fn {row, row_index} ->
        Enum.map(row, fn {val, col_index} ->
          {val, row_index, col_index}
        end)
      end)
      # Now map again each element, check if visible horizontally
      # and transform to tuple with {val, row, col, visible_horizontal}
      |> Enum.map(fn row ->
        Enum.map(row, fn {val, row_index, col_index} ->
          {val, row_index, col_index, visible_horizontal?(matrix, row_index, col_index)}
        end)
      end)
      # Do the same for vertical: {val, row, col, visible_horizontal, visible_vertical}
      |> Enum.map(fn row ->
        Enum.map(row, fn {val, row_index, col_index, visible_horizontal} ->
          {val, row_index, col_index, visible_horizontal,
           visible_vertical?(matrix, row_index, col_index)}
        end)
      end)

    # IO.inspect(r, label: "r")

    # Now remove the first and last row
    truth_matrix =
      r
      # Now do it again and transform to a unique value
      # comparting (visible_horizontal or visible_vertical)?
      |> Enum.map(fn row ->
        Enum.map(row, fn {_, _, _, visible_horizontal, visible_vertical} ->
          visible_horizontal or visible_vertical
        end)
      end)
      |> Enum.drop(1)
      |> Enum.drop(-1)
      # Drop first col
      |> Enum.map(fn row ->
        Enum.drop(row, 1)
      end)
      # Drop last col
      |> Enum.map(fn row ->
        Enum.drop(row, -1)
      end)

    res =
      truth_matrix
      # Count the number of trues
      |> Enum.map(fn row ->
        Enum.count(row, fn x -> x end)
      end)
      |> Enum.sum()

    # IO.inspect(truth_matrix, label: "truth_matrix")

    # Answer is the number of elements in the border + the "final"
    num_rows = Enum.count(matrix)
    num_cols = Enum.count(Enum.at(matrix, 0))

    border = num_rows * 2 + num_cols * 2 - 4

    answer = border + res
    IO.inspect(border, label: "border")
    IO.inspect(answer, label: "answer")
  end

  ###### PART 2 ######

  # This one assumes that the we're checking 
  # the score to the right. Like "val", list[0], list[1]
  def score(val, list) do
    Enum.reduce_while(list, 0, fn x, acc ->
      if x < val do
        {:cont, acc + 1}
      else
        {:halt, acc + 1}
      end
    end)
  end

  def horizontal_score(matrix, row_pos, col_pos) do
    row = Enum.at(matrix, row_pos)

    left = Enum.take(row, col_pos)
    right = Enum.drop(row, col_pos + 1)

    val = Enum.at(row, col_pos)

    # To calculate score, both need to be "right" lists
    # so I'll reverse the left one
    left_reversed = Enum.reverse(left)

    left_score = score(val, left_reversed)
    right_score = score(val, right)

    # The score is multiplied
    left_score * right_score
  end

  # Thsi one i'm doing a trick where i'll transpose
  # the matrix and then call the horizontal_score
  def vertical_score(matrix, row_pos, col_pos) do
    transposed = transpose(matrix)
    # Flip row and col pos
    [row_pos, col_pos] = [col_pos, row_pos]

    horizontal_score(transposed, row_pos, col_pos)
  end

  def solve_pt2 do
    matrix =
      File.read!("input/day8.txt")
      |> String.split("\n")
      |> Enum.map(&String.codepoints(&1))
      # Convert to int
      |> Enum.map(fn row ->
        Enum.map(row, fn char ->
          String.to_integer(char)
        end)
      end)

    # Each element is {val, row_index, col_index}
    numbered_matrix =
      matrix
      |> Enum.map(fn row ->
        Enum.with_index(row)
      end)
      |> Enum.with_index()
      # This transform into a list of list, where elemnts are
      # {val, row_index, col_index}
      |> Enum.map(fn {row, row_index} ->
        Enum.map(row, fn {val, col_index} ->
          {val, row_index, col_index}
        end)
      end)

    # Now i'll map over values and score each val
    scored_matrix =
      numbered_matrix
      |> Enum.map(fn row ->
        Enum.map(row, fn {val, row_index, col_index} ->
          {val, row_index, col_index, horizontal_score(matrix, row_index, col_index),
           vertical_score(matrix, row_index, col_index)}
        end)
      end)

    # Now I'll iterate again through all of them
    # and calculate the final score which is multiplied
    # the vertical and horizontal score
    final_matrix =
      scored_matrix
      |> Enum.map(fn row ->
        Enum.map(row, fn {_, _, _, horizontal_score, vertical_score} ->
          horizontal_score * vertical_score
        end)
      end)

    # Find the max
    max =
      final_matrix
      |> Enum.map(fn row ->
        Enum.max(row)
      end)
      |> Enum.max()

    # IO.inspect(matrix, label: "matrix")
    # IO.inspect(numbered_matrix, label: "numbered_matrix")
    # IO.inspect(scored_matrix, label: "scored_matrix")
    # IO.inspect(final_matrix, label: "final_matrix")
    # IO.inspect(max, label: "max")

    # val = 3

    # res =
    #   Enum.reduce_while([1, 3, 5, 6, 7, 3, 2, 7, 12], 0, fn x, acc ->
    #     if x <= val, do: {:cont, acc + 1}, else: {:halt, acc}
    #   end)

    # IO.inspect(res, label: "res")
  end

  def solve_pt2_at_once do
    matrix =
      File.read!("input/day8.txt")
      |> String.split("\n")
      |> Enum.map(&String.codepoints(&1))
      # Convert to int
      |> Enum.map(fn row ->
        Enum.map(row, fn char ->
          String.to_integer(char)
        end)
      end)

    res =
      matrix
      |> Enum.map(fn row ->
        Enum.with_index(row)
      end)
      |> Enum.with_index()
      |> Enum.map(fn {row, row_index} ->
        Enum.map(row, fn {_, col_index} ->
          horizontal_score(matrix, row_index, col_index) *
            vertical_score(matrix, row_index, col_index)
        end)
      end)
      |> Enum.map(fn row ->
        Enum.max(row)
      end)
      |> Enum.max()

    # IO.inspect(res, label: "res")
  end
end

# DayEight.solve_pt1()
# DayEight.solve_pt2()
# DayEight.solve_pt2_at_once()
IO.inspect(:timer.tc(DayEight, :solve_pt2, []), label: "time pt2")
IO.inspect(:timer.tc(DayEight, :solve_pt2_at_once, []), label: "time pt2 at once")
