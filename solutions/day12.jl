using Graphs

function both_parts(input)
    g = Graph(length(input))
    for (v, neighbors) ∈ input
        for n ∈ neighbors
            add_edge!(g, v+1, n+1)
        end
    end

    components = connected_components(g)
    main_component = only(filter(comp -> 1 ∈ comp, components))
    length(main_component), length(components)
end

function parse_raw_input(raw_input::String)
    map(eachsplit(raw_input, '\n')) do line
        vertex_str, neighbors_str = split(line, " <-> ")
        vertex = parse(Int, vertex_str)
        neighbors = parse.(Int, split(neighbors_str, ", "))
        (vertex, neighbors)
    end
end

get_raw_input(is_test::Bool)::String = readchomp(is_test ? "inputs/test/day12.txt" : "inputs/actual/day12.txt")

function main()
    input = parse_raw_input(get_raw_input(false))
    part1_answer, part2_answer = both_parts(input)
    println("Part 1: ", part1_answer)
    println("Part 2: ", part2_answer)
end

main()