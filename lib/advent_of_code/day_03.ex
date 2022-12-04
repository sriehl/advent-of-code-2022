defmodule AdventOfCode.Day03 do
  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_charlist/1)
  end

  defp score_letter(letter) when letter >= 97, do: letter - ?a + 1
  defp score_letter(letter), do: letter - ?A + 27

  def part1(input) do
    input
    |> parse_input()
    |> Enum.map(fn rucksack ->
      len = rucksack |> length() |> div(2)
      first = Enum.slice(rucksack, 0..(len - 1))
      second = Enum.slice(rucksack, len..-1)
      MapSet.intersection(MapSet.new(first), MapSet.new(second))
    end)
    |> Enum.flat_map(&MapSet.to_list/1)
    |> Enum.map(&score_letter/1)
    |> Enum.sum()
  end

  def part2(input) do
    input
    |> parse_input()
    |> Enum.chunk_every(3)
    |> Enum.map(fn group ->
      group = Enum.map(group, &MapSet.new/1)
      a = Enum.at(group, 0)
      b = Enum.at(group, 1)
      c = Enum.at(group, 2)
      shared = MapSet.intersection(a, b)
      MapSet.intersection(shared, c)
    end)
    |> Enum.flat_map(&MapSet.to_list/1)
    |> Enum.map(&score_letter/1)
    |> Enum.sum()
  end
end
