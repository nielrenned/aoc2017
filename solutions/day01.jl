function get_raw_input(is_test::Bool)::String
    is_test ? readchomp("inputs/test/day01.txt") : readchomp("inputs/actual/day01.txt")
end

function part1(input::String)::Int
    sum(eachindex(input)) do i
        j = mod1(i + 1, length(input))
        input[i] == input[j] ? parse(Int, input[i]) : 0
    end
end

function part2(input::String)::Int
    halfway = length(input) ÷ 2
    sum(eachindex(input)) do i
        j = mod1(i + halfway, length(input))
        input[i] == input[j] ? parse(Int, input[i]) : 0
    end
end

function main()
    input = get_raw_input(false)
    println("Part 1: ", part1(input))
    println("Part 2: ", part2(input))
end

main()