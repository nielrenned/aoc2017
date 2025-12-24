part1(input, is_test) = dance(input, join('a':(is_test ? 'e' : 'p')))

function part2(input, is_test)
    start = join('a':(is_test ? 'e' : 'p'))
    line = start
    cycle_len = 0
    while true
        line = dance(input, line)
        cycle_len += 1
        line == start && break
    end
    
    for _ ∈ 1:(1_000_000_000 % cycle_len)
        line = dance(input, line)
    end
    line
end

function dance(moves, start::String)
    line = collect(start)
    for move ∈ moves
        instr = move[1]
        operand = move[2:end]
        if instr == 's'
            size = parse(Int, operand)
            line = vcat(line[end-size+1:end], line[1:end-size])
        elseif instr == 'x'
            i, j = parse.(Int, split(operand, '/'))
            line[i+1], line[j+1] = line[j+1], line[i+1]
        elseif instr == 'p'
            c, d = split(operand, '/')
            i, j = indexin(c, line), indexin(d, line)
            line[i], line[j] = line[j], line[i]
        end
    end
    join(line)
end

parse_raw_input(raw_input::String) = split(raw_input, ',')
get_raw_input(is_test::Bool)::String = readchomp(is_test ? "inputs/test/day16.txt" : "inputs/actual/day16.txt")

function main()
    is_test = false
    input = parse_raw_input(get_raw_input(is_test))
    println("Part 1: ", part1(input, is_test))
    println("Part 2: ", part2(input, is_test))
end

main()