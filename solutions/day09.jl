part1(input) = score(group(input, 1)[2])
score(groups, depth=1) = depth + sum(score.(filter(g -> typeof(g) != String, groups), depth+1); init = 0)

part2(input) = count_garbage(group(input, 1)[2])
count_garbage(groups) = sum(typeof(g) === String ? length(g) : count_garbage(g) for g ∈ groups; init = 0)

function group(input, i)
    j = i + 1 # Consume opening '{'
    children = []
    while true
        c = input[j]
        if c == '{'
            (Δ, child) = group(input, j)
            j += Δ
            push!(children, child)
        elseif c == '<'
            (Δ, child) = garbage(input, j)
            j += Δ
            push!(children, child)
        elseif c == ','
            j += 1
        elseif c == '}'
            return (j - i + 1, children)
        end
    end
end

function garbage(input, i)
    j = i
    contents = ""
    while true
        j += 1
        c = input[j]
        if c == '!'
            j += 1 # Jump forward an extra character
        elseif c == '>'
            return (j - i + 1, contents)
        else
            contents *= c
        end
    end
end

get_raw_input(is_test::Bool)::String = readchomp(is_test ? "inputs/test/day09.txt" : "inputs/actual/day09.txt")

function main()
    input = get_raw_input(false)
    println("Part 1: ", part1(input))
    println("Part 2: ", part2(input))
end

main()