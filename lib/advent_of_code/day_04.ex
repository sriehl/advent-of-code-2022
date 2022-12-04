defmodule AdventOfCode.Day04 do
  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn ranges ->
      {:ok, [a1, a2, b1, b2], _, _, _, _} = AdventOfCode.Day04.Parse.ranges(ranges)
      {a1, a2, b1, b2}
    end)
  end

  defp full_overlap(a1, a2, b1, b2) when a1 >= b1 and a2 <= b2, do: true
  defp full_overlap(a1, a2, b1, b2) when b1 >= a1 and b2 <= a2, do: true
  defp full_overlap(_, _, _, _), do: false

  def part1(input) do
    input
    |> parse_input()
    |> Enum.map(fn {a1, a2, b1, b2} -> full_overlap(a1, a2, b1, b2) end)
    |> Enum.count(fn bool -> bool end)
  end

  def part2(input) do
    input
    |> parse_input()
    |> Enum.map(fn {a1, a2, b1, b2} -> !Range.disjoint?(a1..a2, b1..b2) end)
    |> Enum.count(fn bool -> bool end)
  end
end

defmodule AdventOfCode.Day04.Parse do
  import NimbleParsec

  ranges =
    integer(min: 1)
    |> ignore(string("-"))
    |> integer(min: 1)
    |> ignore(string(","))
    |> integer(min: 1)
    |> ignore(string("-"))
    |> integer(min: 1)

  defparsec(:ranges, ranges)
end
