include("knot_hash.jl")

function part1(input)
    (nums, _, _) = knot_hash_step(Array(0:255), input)
    nums[1] * nums[2]
end

function part2(input)
    knot_hash(input)
end

parse_raw_input(raw_input::String) = parse.(Int, eachsplit(raw_input, ','))
get_raw_input(is_test::Bool)::String = readchomp(is_test ? "inputs/test/day10.txt" : "inputs/actual/day10.txt")

function main()
    raw_input = get_raw_input(false)
    input = parse_raw_input(raw_input)
    println("Part 1: ", part1(input))
    println("Part 2: ", part2(raw_input))
end

main()