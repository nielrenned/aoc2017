using Graphs
include("knot_hash.jl")

part1(input) = sum(count.("1", input))

function part2(input)
    g = SimpleGraph(128^2 + 1)
    for x ∈ 1:128, y ∈ 1:128
        index = 128*(y-1) + x

        if input[y][x] == '1'
            for (nx, ny) ∈ neighbors([x, y], 128, 128)
                if input[ny][nx] == '1'
                    add_edge!(g, index, 128*(ny-1) + nx)
                end
            end
        else
            # Connect all the zeroes in their own component
            add_edge!(g, index, 128^2 + 1)
        end
    end

    # Subtract 1 for the zero-component
    length(connected_components(g)) - 1
end

neighbors(p, w, h) = filter(p -> 1 ≤ p[1] ≤ w && 1 ≤ p[2] ≤ h, [p .+ Δ for Δ ∈ [(-1, 0), (0, -1), (1, 0), (0, 1)]])

get_raw_input(is_test::Bool)::String = readchomp(is_test ? "inputs/test/day14.txt" : "inputs/actual/day14.txt")

function main()
    input = get_raw_input(false)
    hashed_input = map(0:127) do i
        hash = knot_hash(string(input, "-", i))
        join(lpad.(string.(parse.(Int, collect(hash), base=16), base=2), 4, "0"))
    end
    println("Part 1: ", part1(hashed_input))
    println("Part 2: ", part2(hashed_input))
end

main()