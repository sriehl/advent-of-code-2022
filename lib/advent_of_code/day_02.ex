defmodule AdventOfCode.Day02 do
  @moduledoc """
  A - Rock
  B - Paper
  C - Scissors

  p1:
  X - Rock
  Y - Paper
  Z - Scissors

  p2:
  X - should loose
  Y - should draw
  Z - should win

  Scoring:
  selected shape score:
  X - 1
  Y - 2
  Z - 3
  + outcome:
  lost - 0
  tie - 3
  win - 6
  """

  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn round ->
      round
      |> String.split()
      |> List.to_tuple()
    end)
  end

  defp score_round({theirs, :rock}) do
    case theirs do
      :rock -> 4
      :paper -> 1
      :scissors -> 7
    end
  end

  defp score_round({theirs, :paper}) do
    case theirs do
      :rock -> 8
      :paper -> 5
      :scissors -> 2
    end
  end

  defp score_round({theirs, :scissors}) do
    case theirs do
      :rock -> 3
      :paper -> 9
      :scissors -> 6
    end
  end

  defp convert_p1({theirs, ours}) do
    theirs =
      case theirs do
        "A" -> :rock
        "B" -> :paper
        "C" -> :scissors
      end

    ours =
      case ours do
        "X" -> :rock
        "Y" -> :paper
        "Z" -> :scissors
      end

    {theirs, ours}
  end

  defp convert_p2({theirs, result}) do
    theirs =
      case theirs do
        "A" -> :rock
        "B" -> :paper
        "C" -> :scissors
      end

    ours =
      case {theirs, result} do
        {:rock, "X"} -> :scissors
        {:rock, "Y"} -> :rock
        {:rock, "Z"} -> :paper
        {:paper, "X"} -> :rock
        {:paper, "Y"} -> :paper
        {:paper, "Z"} -> :scissors
        {:scissors, "X"} -> :paper
        {:scissors, "Y"} -> :scissors
        {:scissors, "Z"} -> :rock
      end

    {theirs, ours}
  end

  def part1(input) do
    input
    |> parse_input()
    |> Enum.map(&convert_p1/1)
    |> Enum.map(&score_round/1)
    |> Enum.sum()
  end

  def part2(input) do
    input
    |> parse_input()
    |> Enum.map(&convert_p2/1)
    |> Enum.map(&score_round/1)
    |> Enum.sum()
  end
end
