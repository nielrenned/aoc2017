factorA = 16807
factorB = 48271
N = 2147483647

function part1(input)
    genA, genB = input
    
    count = 0
    for _ in 1:40_000_000
        genA = (genA * factorA) % N
        genB = (genB * factorB) % N
        if (genA & 0xffff) == (genB & 0xffff)
            count += 1
        end
    end
    count
end

function part2(input)
    genA, genB = input
    
    count = 0
    for _ in 1:5_000_000
        while true
            genA = (genA * factorA) % N
            (genA % 4 == 0) && break
        end

        while true
            genB = (genB * factorB) % N
            (genB % 4 == 0) && break
        end

        if (genA & 0xffff) == (genB & 0xffff)
            count += 1
        end
    end
    count
end

function parse_raw_input(raw_input::String)
    genA, genB = split(raw_input, '\n')
    (parse(Int, split(genA)[end]), parse(Int, split(genB)[end]))
end
get_raw_input(is_test::Bool)::String = readchomp(is_test ? "inputs/test/day15.txt" : "inputs/actual/day15.txt")

function main()
    input = parse_raw_input(get_raw_input(false))
    println("Part 1: ", part1(input))
    println("Part 2: ", part2(input))
end

main()