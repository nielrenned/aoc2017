function part1(input::Int)
    buffer = [0]
    i = 1
    for j ∈ 1:2017
        i = mod1(i + input, length(buffer))
        i = mod1(i+1, length(buffer)+1)
        insert!(buffer, i, j)
    end
    buffer[mod1(i+1, length(buffer))]
end

function part2(input::Int)
    # buffer = [0]
    i = 1
    l = 1
    value = 0
    for j ∈ 1:50_000_000
        i = mod1(i + input, l)
        if i == 1
            # We're inserting right after 0
            value = j
        end
        i = mod1(i+1, l+1)
        l += 1
    end
    value
end

parse_raw_input(raw_input::String) = parse(Int, raw_input)
get_raw_input(is_test::Bool)::String = readchomp(is_test ? "inputs/test/day17.txt" : "inputs/actual/day17.txt")

function main()
    input = parse_raw_input(get_raw_input(false))
    println("Part 1: ", part1(input))
    println("Part 2: ", part2(input))
end

main()