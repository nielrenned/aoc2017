CI = CartesianIndex

function both_parts(input)
    start_x = findfirst(==('|'), input[:, 1])
    p = CI(start_x, 1)
    Δp = CI(0, 1)

    result = ""
    count = 0
    while checkbounds(Bool, input, p)
        c = input[p]
        c == ' ' && break

        if c == '+'
            for Δ ∈ (CI(-1, 0), CI(0, -1), CI(1, 0), CI(0, 1))
                Δ == -Δp && continue
                
                q = p + Δ
                if checkbounds(Bool, input, q) && input[q] != ' '
                    Δp = Δ
                    break
                end
            end
        elseif c ∉ ('|', '-')
            result *= c
        end

        p += Δp
        count += 1
    end
    
    result, count
end

parse_raw_input(raw_input::String) = stack(collect.(eachsplit(raw_input, '\n')))
get_raw_input(is_test::Bool)::String = readchomp(is_test ? "inputs/test/day19.txt" : "inputs/actual/day19.txt")

function main()
    input = parse_raw_input(get_raw_input(false))
    part1_answer, part2_answer = both_parts(input)
    println("Part 1: ", part1_answer)
    println("Part 2: ", part2_answer)
end

main()