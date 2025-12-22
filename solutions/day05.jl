part1(input) = count_steps(input, Δ -> 1)
part2(input) = count_steps(input, Δ -> Δ < 3 ? 1 : -1)

function count_steps(input, mutator)
    mut_input = copy(input)
    i = 1
    steps = 0
    while 1 ≤ i ≤ length(input)
        Δ = mut_input[i]
        mut_input[i] += mutator(Δ)
        i += Δ
        steps += 1
    end
    steps
end

parse_raw_input(raw_input::String) = parse.(Int, eachsplit(raw_input, '\n'))
get_raw_input(is_test::Bool)::String = readchomp(is_test ? "inputs/test/day05.txt" : "inputs/actual/day05.txt")

function main()
    raw_input = get_raw_input(false)
    input = parse_raw_input(raw_input)
    println("Part 1: ", part1(input))
    println("Part 2: ", part2(input))
end

main()