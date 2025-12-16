using Combinatorics

part1(input) = sum(maximum(row) - minimum(row) for row ∈ input)
part2(input) = sum((i ≠ j && a % b == 0) ? a ÷ b : 0 for row ∈ input for (i, a) ∈ enumerate(row), (j, b) ∈ enumerate(row))

parse_raw_input(raw_input::String) = [parse.(Int, split(line)) for line ∈ eachsplit(raw_input, "\n")]
get_raw_input(is_test::Bool)::String = is_test ? readchomp("inputs/test/day02.txt") : readchomp("inputs/actual/day02.txt")

function main()
    raw_input = get_raw_input(false)
    input = parse_raw_input(raw_input)
    println("Part 1: ", part1(input))
    println("Part 2: ", part2(input))
end

main()