function part1(input)
    seen = Set([input])

    count = 0
    while true
        input = redistribute(input)
        count += 1
        (input ∈ seen) && break
        push!(seen, input)
    end

    count
end

function part2(input, part1_answer)
    for _ in 1:part1_answer
        input = redistribute(input)
    end
    part1(input)
end

function redistribute(banks::Vector{Int64})::Vector{Int64}
    i = argmax(banks)
    new_banks = copy(banks)
    new_banks[i] = 0
    blocks = banks[i]
    for _ ∈ 1:blocks
        i = mod1(i + 1, length(banks))
        new_banks[i] += 1
    end
    new_banks
end

parse_raw_input(raw_input::String) = parse.(Int, eachsplit(raw_input, '\t'))
get_raw_input(is_test::Bool)::String = readchomp(is_test ? "inputs/test/day06.txt" : "inputs/actual/day06.txt")

function main()
    raw_input = get_raw_input(false)
    input = parse_raw_input(raw_input)
    part1_answer = part1(input)
    println("Part 1: ", part1_answer)
    println("Part 2: ", part2(input, part1_answer))
end

main()