mutable struct Program
    pid::Int
    ip::Int
    instructions::Vector{Vector{String}}
    mp::Int
    messages::Vector{Int128}
    regs::Dict{String, Int128}
    timeout::Int
end

Program(pid, instructions, include_pid_reg=true) = Program(pid, 1, instructions, 1, [], include_pid_reg ? Dict("p" => pid) : Dict(), 0)

function step(prog::Program, output::Vector{Int128})
    instr = prog.instructions[prog.ip]
    prog.ip += 1

    op = instr[1]
    r1 = instr[2]
    r2 = length(instr) ≥ 3 ? instr[3] : nothing

    if op == "set"
        prog.regs[r1] = get_value(prog, r2)
    elseif op == "add"
        prog.regs[r1] = get_value(prog, r1) + get_value(prog, r2)
    elseif op == "mul"
        prog.regs[r1] = get_value(prog, r1) * get_value(prog, r2)
    elseif op == "mod"
        prog.regs[r1] = get_value(prog, r1) % get_value(prog, r2)
    elseif op == "jgz" && get_value(prog, r1) > 0
        prog.ip += get_value(prog, r2) - 1
    elseif op == "snd"
        push!(output, get_value(prog, r1))
    elseif op == "rcv"
        if prog.mp ≤ length(prog.messages)
            prog.timeout = 0
            prog.regs[r1] = prog.messages[prog.mp]
            prog.mp += 1
        else
            # Block until we have a messages
            prog.timeout += 1
            prog.ip -= 1
        end
    end
end

function part1(input)
    prog = Program(0, input, false)
    output::Vector{Int128} = []
    while prog.timeout == 0
        step(prog, output)
    end
    output[end]
end

function part2(input)
    prog0 = Program(0, input)
    prog1 = Program(1, input)

    while prog0.timeout == 0 || prog1.timeout == 0
        step(prog0, prog1.messages)
        step(prog1, prog0.messages)
    end

    length(prog0.messages)
end

get_value(program::Program, value::String) = something(tryparse(Int128, value), get!(program.regs, value, 0))

parse_raw_input(raw_input::String)::Vector{Vector{String}} = split.(eachsplit(raw_input, '\n'))
get_raw_input(is_test::Bool)::String = readchomp(is_test ? "inputs/test/day18.txt" : "inputs/actual/day18.txt")

function main()
    input = parse_raw_input(get_raw_input(false))
    println("Part 1: ", part1(input))
    println("Part 2: ", part2(input))
end

main()