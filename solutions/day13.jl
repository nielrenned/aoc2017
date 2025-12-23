function part1(input)
    max_layer = maximum(pair -> pair.first, input)
    scanners = Dict(x => (; pos=0, dir=1) for (x, _) ∈ input)

    score = 0
    for t ∈ 0:max_layer
        if t ∈ keys(scanners) && scanners[t].pos == 0
            score += input[t]*t
        end
        update_scanners(input, scanners)
    end
    score
end

function part2(input)
    max_layer = maximum(pair -> pair.first, input)
    delay = 0
    base_scanners = Dict(x => (; pos=0, dir=1) for (x, _) ∈ input)
    while true
        delay += 1
        update_scanners(input, base_scanners)
        scanners = copy(base_scanners)
        
        valid = true
        for t ∈ 0:max_layer
            if t ∈ keys(scanners) && scanners[t].pos == 0
                # We got caught
                valid = false
                break
            end
            update_scanners(input, scanners)
        end
        valid && return delay
    end
end

function update_scanners(input, scanners)
    for (scanner, (pos, dir)) ∈ scanners
        pos += dir
        if pos == 0 || pos == input[scanner] - 1
            dir = -dir
        end
        scanners[scanner] = (; pos, dir)
    end
end

function parse_raw_input(raw_input::String)
    Dict(map(split.(eachsplit(raw_input, '\n'), ": ")) do pair
        parse(Int, pair[1]) => parse(Int, pair[2])
    end)
end
get_raw_input(is_test::Bool)::String = readchomp(is_test ? "inputs/test/day13.txt" : "inputs/actual/day13.txt")

function main()
    input = parse_raw_input(get_raw_input(false))
    println("Part 1: ", part1(input))
    println("Part 2: ", part2(input))
end

main()