defmodule AdventOfCode.Day01 do
  defp sum_strings(strings) do
    strings
    |> Enum.map(&String.to_integer/1)
    |> Enum.sum()
  end

  defp parse_input(input) do
    input
    |> String.split("\n\n", trim: true)
    |> Enum.map(&String.split/1)
    |> Enum.map(&sum_strings/1)
  end

  @spec part1(String.t()) :: integer
  def part1(input) do
    input
    |> parse_input()
    |> Enum.max()
  end

  @spec part2(String.t()) :: integer
  def part2(input) do
    input
    |> parse_input()
    |> Enum.sort()
    |> Enum.reverse()
    |> Enum.take(3)
    |> Enum.sum()
  end
end
