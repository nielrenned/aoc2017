function part1(input)
    (nums, _, _) = knot_hash(Array(0:255), input)
    nums[1] * nums[2]
end

function part2(input)
    lengths = vcat(Int.(collect(input)), [17, 31, 73, 47, 23])
    nums, pos, skip = Array(0:255), 1, 0
    for _ in 1:64
        (nums, pos, skip) = knot_hash(nums, lengths, pos, skip)
    end

    join(map(Iterators.partition(nums, 16)) do chunk
        s = string(reduce(⊻, chunk), base=16)
        length(s) == 2 ? s : "0"*s
    end)
end

function knot_hash(in, lengths, pos=1, skip=0)
    L = length(in)
    out = copy(in)
    for l ∈ lengths
        for j ∈ 1:l÷2
            a, b = mod1(pos+j-1, L), mod1(pos+l-j, L)
            out[a], out[b] = out[b], out[a]
        end
        pos += l + skip
        skip += 1
    end
    (out, pos, skip)
end

parse_raw_input(raw_input::String) = parse.(Int, eachsplit(raw_input, ','))
get_raw_input(is_test::Bool)::String = readchomp(is_test ? "inputs/test/day10.txt" : "inputs/actual/day10.txt")

function main()
    raw_input = get_raw_input(false)
    input = parse_raw_input(raw_input)
    println("Part 1: ", part1(input))
    println("Part 2: ", part2(raw_input))
end

main()