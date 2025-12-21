part1(input) = count(has_no_duplicates, input)
part2(input) = count(has_no_anagrams, input)

has_no_duplicates(passphrase) = allunique(passphrase)
has_no_anagrams(passphrase) = allunique(sort.(collect.(passphrase)))

parse_raw_input(raw_input::String) = split.(eachsplit(raw_input, "\n"))
get_raw_input(is_test::Bool)::String = readchomp(is_test ? "inputs/test/day04.txt" : "inputs/actual/day04.txt")

function main()
    raw_input = get_raw_input(false)
    input = parse_raw_input(raw_input)
    println("Part 1: ", part1(input))
    println("Part 2: ", part2(input))
end

main()