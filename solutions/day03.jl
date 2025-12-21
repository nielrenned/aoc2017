function part1(input::Int)
    (x, y) = spiral_coords(input)
    abs(x) + abs(y)
end

function part2(input::Int)
    values = Dict()
    values[(0, 0)] = 1
    i = 2
    while true
        q = spiral_coords(i)
        values[q] = sum(get!(values, p, 0) for p in neighbors(q))
        if values[q] > input
            return values[q]
        end
        i += 1
    end
end

neighbors(p) = [p .+ Δ for Δ ∈ [(-1, 0), (0, -1), (1, 0), (0, 1), (-1, -1), (-1, 1), (1, -1), (1, 1)]]

function spiral_coords(i::Int)::Tuple{Int64, Int64}
    s::Int = ceil(sqrt(i))
    s = isodd(s) ? s - 1 : s

    p = (s ÷ 2, s ÷ 2)
    j = (s + 1) ^ 2
    # Traverse the sides of the square in reverse until we get to index i
    for Δ ∈ [(-1, 0), (0, -1), (1, 0), (0, 1)]
        if i < j - s
            p = p .+ (s .* Δ)
        elseif j - s ≤ i < j
            p = p .+ ((j - i) .* Δ)
        else
            break
        end
        j -= s
    end
    p
end

parse_raw_input(raw_input::String) = parse(Int, raw_input)
get_raw_input(is_test::Bool)::String = is_test ? readchomp("inputs/test/day03.txt") : readchomp("inputs/actual/day03.txt")

function main()
    raw_input = get_raw_input(false)
    input = parse_raw_input(raw_input)
    println("Part 1: ", part1(input))
    println("Part 2: ", part2(input))
end

main()