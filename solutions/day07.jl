using StatsBase

function part1(input)
    all_children = union((node.children for node ∈ values(input))...)
    # The root is the only node that is not a child of another node
    for node_name ∈ keys(input)
        node_name ∉ all_children && return node_name
    end
end

function part2(input, root)
    # Recurse on any child that is not balanced
    node = input[root]
    for child ∈ node.children
        if !allequal(weight(input, grandchild) for grandchild ∈ input[child].children)
            return part2(input, child)
        end
    end

    # Or, if all children are balaced, find and return the expected weight of the outlier
    weights = [weight(input, child) for child ∈ node.children]
    counts = countmap(weights)

    expected_weight = findfirst(>(1), counts)
    outlier_weight = findfirst(==(1), counts)
    Δweight = expected_weight - outlier_weight

    outlier = input[node.children[findfirst(==(outlier_weight), weights)]]
    return outlier.weight + Δweight
end

weight(input, node) = input[node].weight + sum(weight(input, child) for child ∈ input[node].children; init = 0)

function parse_raw_input(raw_input::String)
    Dict(map(eachsplit(raw_input, '\n')) do line
        m = match(r"(\w+) \((\d+)\)(?: -> ([\w, ]+))?", line)
        name = m[1]
        weight = parse(Int, m[2])
        children = isnothing(m[3]) ? [] : split(m[3], ", ")
        name => (; weight, children) # named tuple
    end)
end

get_raw_input(is_test::Bool)::String = readchomp(is_test ? "inputs/test/day07.txt" : "inputs/actual/day07.txt")

function main()
    raw_input = get_raw_input(false)
    input = parse_raw_input(raw_input)
    part1_answer = part1(input)
    println("Part 1: ", part1_answer)
    println("Part 2: ", part2(input, part1_answer))
end

main()