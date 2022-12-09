defmodule AdventOfCode.Day05 do
  defp parse_instructions(instructions) do
    instructions
    |> String.split("\n", trim: true)
    |> Enum.map(fn instruction ->
      [_move, qty, _from, from, _to, to] = String.split(instruction, " ", trim: true)
      %{qty: String.to_integer(qty), from: String.to_integer(from), to: String.to_integer(to)}
    end)
  end

  defp parse_stacks(stacks) do
    stacks
    |> String.split("\n", trim: true)
    |> Enum.drop(-1)
    |> Enum.flat_map(fn line ->
      line |> String.graphemes() |> Enum.drop(1) |> Enum.take_every(4) |> Enum.with_index(1)
    end)
    |> Enum.group_by(&elem(&1, 1))
    |> Enum.map(fn {column, vals} ->
      {column, vals |> Enum.map(&elem(&1, 0)) |> Enum.reject(&Kernel.==(&1, " "))}
    end)
    |> Map.new()
  end

  defp parse_input(input) do
    [stacks, instructions] = String.split(input, "\n\n", trim: false)
    [parse_stacks(stacks), parse_instructions(instructions)]
  end

  defp do_instructions(stacks, []), do: stacks

  defp do_instructions(stacks, [instruction | instructions]) do
    stacks = move(stacks, instruction.from, instruction.to, instruction.qty)
    do_instructions(stacks, instructions)
  end

  defp move(stacks, _from, _to, 0), do: stacks

  defp move(stacks, from_stack, to_stack, qty) do
    [box | from] = stacks[from_stack]
    to = [box | stacks[to_stack]]

    stacks =
      stacks
      |> Map.replace(from_stack, from)
      |> Map.replace(to_stack, to)

    move(stacks, from_stack, to_stack, qty - 1)
  end

  def part1(input) do
    [stacks, instructions] = parse_input(input)
    IO.inspect(stacks)
    IO.inspect(instructions)
    result = do_instructions(stacks, instructions)

    result
    |> Map.keys()
    |> Enum.map(fn stack_num -> List.first(result[stack_num]) end)
    |> Enum.join("")
  end

  def part2(_args) do
  end
end
