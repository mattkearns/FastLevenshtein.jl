module FastLevenshtein

    function fastlevenshtein(v1::Vector, v2::Vector)::Int64
        """
        Efficiently Compute the Levenshtein (edit) distance between two vectors using dynamic programming.
        :param v1: The first vector is a Mx1 vector.
        :param v2: The second vector is a Nx1 vector.
        :return: The minimum number of edits required to make the vectors the same.
        """
        M::Int64, N::Int64 = length(v1), length(v2)

        # This table holds the subproblems we have to solve to get an answer
        table::Array{Int64} = zeros(Int64, (M+1, N+1))

        for i::Int64 ∈ 0:M
            for j::Int64 ∈ 0:N
                # if the length of the 1st vector is 0 then we need at least j edits
                if i == 0
                    table[i+1, j+1] = j
                # if the length of the 2nd vector is 0 then we need at least i edits
                elseif j == 0
                    table[i+1, j+1] = i
                # if the values are the same then the minumum number of edits hasn't changed
                elseif v1[i] == v2[j]
                    table[i+1, j+1] = table[i, j]
                # if the value are different then the minimum edits has increased by 1
                else
                    table[i+1, j+1] = 1 + min(
                        table[i+1, j], # The minimum edits required if i > j (insert value @ current index)
                        table[i, j+1], # The minimum edits required if i < j (remove value @ current index)
                        table[i, j]    # The minimum edits required if i = j (update value @ current index)
                    )
                end
            end
        end

        return table[M+1, N+1]
    end

    function fastlevenshtein(s1::AbstractString, s2::AbstractString)
        """
        Efficiently Compute the Levenshtein (edit) distance between two strings using dynamic programming.
        :param s1: The first string contains M characters.
        :param s2: The second string contains N characters.
        :return: The minimum number of edits required to make the strings the same.
        """
        return fastlevenshtein(Vector{Char}(s1), Vector{Char}(s2))
    end

    export fastlevenshtein
end
