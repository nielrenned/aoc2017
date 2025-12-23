function knot_hash(in)
    lengths = vcat(Int.(collect(in)), [17, 31, 73, 47, 23])
    nums, pos, skip = Array(0:255), 1, 0
    for _ in 1:64
        (nums, pos, skip) = knot_hash_step(nums, lengths, pos, skip)
    end

    join(map(Iterators.partition(nums, 16)) do chunk
        s = string(reduce(⊻, chunk), base=16)
        lpad(s, 2, "0")
    end)
end

function knot_hash_step(in, lengths, pos=1, skip=0)
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