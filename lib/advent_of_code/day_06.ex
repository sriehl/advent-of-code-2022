defmodule AdventOfCode.Day06 do
  defp parse_input(input) do
    input
    |> String.split("", trim: true)
  end

  defp process_bits(_last_set, [], current_bit), do: current_bit

  defp process_bits([_head | last_set], [next_bit | datastream], current_bit) do
    last_set = List.insert_at(last_set, -1, next_bit)

    cond do
      Enum.uniq(last_set) == last_set ->
        current_bit

      true ->
        process_bits(last_set, datastream, current_bit + 1)
    end
  end

  @spec part1(String.t()) :: integer()
  def part1(input) do
    input = parse_input(input)

    process_bits(Enum.take(input, 4), Enum.drop(input, 4), 4 + 1)
  end

  def part2(input) do
    input = parse_input(input)

    process_bits(Enum.take(input, 14), Enum.drop(input, 14), 14 + 1)
  end
end
