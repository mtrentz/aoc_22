defmodule DayFiveTest do
  use ExUnit.Case

  describe "make_move/3" do
    test "moves once" do
      crates = [
        ["N", "D", "M", "Q", "B", "P", "Z"],
        ["C", "L", "Z", "Q"],
        ["Q", "H", "R", "D", "V"]
      ]

      crates_out = [
        ["N", "D", "M", "Q", "B", "P"],
        ["C", "L", "Z", "Q", "Z"],
        ["Q", "H", "R", "D", "V"]
      ]

      assert DayFive.make_move(crates, 0, 1) == crates_out
    end
  end

  describe "make_move/4" do
    test "move many" do
      crates = [
        ["N", "D", "M", "Q", "B", "P", "Z"],
        ["C", "L", "Z", "Q"],
        ["Q", "H", "R", "D", "V"]
      ]

      crates_out = [
        ["N", "D", "M", "Q", "B"],
        ["C", "L", "Z", "Q", "Z", "P"],
        ["Q", "H", "R", "D", "V"]
      ]

      assert DayFive.make_move(crates, 2, 0, 1) == crates_out
    end
  end

  describe "make_move_pt2/4" do
    test "move many" do
      crates = [
        ["N", "D", "M", "Q", "B", "P", "Z"],
        ["C", "L", "Z", "Q"],
        ["Q", "H", "R", "D", "V"]
      ]

      crates_out = [
        ["N", "D", "M", "Q", "B"],
        ["C", "L", "Z", "Q", "P", "Z"],
        ["Q", "H", "R", "D", "V"]
      ]

      assert DayFive.make_move_pt2(crates, 2, 0, 1) == crates_out
    end
  end
end
