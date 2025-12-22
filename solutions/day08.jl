function both_parts(input)::Tuple{Int, Int}
    registers = Dict{String, Int}()
    max_seen = typemin(Int)
    
    for (reg, op, value, comp_reg, comparison) ∈ input
        if comparison(get(registers, comp_reg, 0))
            Δ = (op == "inc" ? value : -value)
            registers[reg] = get(registers, reg, 0) + Δ
            max_seen = max(max_seen, registers[reg])
        end
    end
    
    maximum(values(registers)), max_seen
end

function parse_raw_input(raw_input::String)
    map(eachsplit(raw_input, '\n')) do line
        m = match(r"(\w+) (inc|dec) (-?\d+) if (\w+) (>|<|<=|>=|==|!=) (-?\d+)", line)
        
        op_value = parse(Int, m[3])
        comp_value = parse(Int, m[6])
        
        comparison = 
            if m[5] == ">"
                >(comp_value)
            elseif m[5] == "<"
                <(comp_value)
            elseif m[5] == ">="
                >=(comp_value)
            elseif m[5] == "<="
                <=(comp_value)
            elseif m[5] == "!="
                !=(comp_value)
            elseif m[5] == "=="
                ==(comp_value)
            end

        (m[1], m[2], op_value, m[4], comparison)
    end
end

get_raw_input(is_test::Bool)::String = readchomp(is_test ? "inputs/test/day08.txt" : "inputs/actual/day08.txt")

function main()
    raw_input = get_raw_input(false)
    input = parse_raw_input(raw_input)
    part1_answer, part2_answer = both_parts(input)
    println("Part 1: ", part1_answer)
    println("Part 2: ", part2_answer)
end

main()