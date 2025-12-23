part1(input) = dist2origin(sum(map(d -> Δs[d], input)))
part2(input) = maximum(dist2origin, cumsum(map(d -> Δs[d], input)))

# https://www.redblobgames.com/grids/hexagons/#distances-cube
Δs = Dict(
    "n" => [0, -1, +1], "nw" => [-1, 0, +1], "ne" => [+1, -1, 0],
    "s" => [0, +1, -1], "se" => [+1, 0, -1], "sw" => [-1, +1, 0],
)
dist2origin(p) = maximum(abs.(p))

parse_raw_input(raw_input::String) = split(raw_input, ',')
get_raw_input(is_test::Bool)::String = readchomp(is_test ? "inputs/test/day11.txt" : "inputs/actual/day11.txt")

function main()
    input = parse_raw_input(get_raw_input(false))
    println("Part 1: ", part1(input))
    println("Part 2: ", part2(input))
end

main()