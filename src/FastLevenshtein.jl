module FastLevenshtein

    function fastlevenshtein(v1::Vector, v2::Vector, insert_cost::Real=1.0, delete_cost::Real=1.0, update_cost::Real=1.0)::Real
        """
        Efficiently Compute the Levenshtein (edit) distance between two vectors using dynamic programming.
        :param v1: The first vector is a Mx1 vector.
        :param v2: The second vector is a Nx1 vector.
        :return: The minimum number of edits required to make the vectors the same.
        """
        M::Int64, N::Int64 = length(v1), length(v2)

        # This table holds the subproblems we have to solve to get an answer
        table::Array{Real} = zeros(Real, (M+1, N+1))

        for i::Int64 ∈ 0:M
            for j::Int64 ∈ 0:N
                # if the length of the 1st vector is 0 then we need at least j edits
                if i == 0
                    table[i+1, j+1] = convert(AbstractFloat, j)
                # if the length of the 2nd vector is 0 then we need at least i edits
                elseif j == 0
                    table[i+1, j+1] = convert(AbstractFloat, i)
                # if the values are the same then the minumum number of edits hasn't changed
                elseif v1[i] == v2[j]
                    table[i+1, j+1] = table[i, j]
                # if the value are different then the minimum edits has increased by 1
                else
                    table[i+1, j+1] = min(
                        table[i+1, j] + insert_cost, # The minimum edits required if i > j (insert value @ current index)
                        table[i, j+1] + delete_cost, # The minimum edits required if i < j (remove value @ current index)
                        table[i, j]   + update_cost  # The minimum edits required if i = j (update value @ current index)
                    )
                end
            end
        end

        return table[M+1, N+1]
    end

    function fastlevenshtein(s1::AbstractString, s2::AbstractString, insert_cost::Real=1.0, delete_cost::Real=1.0, update_cost::Real=1.0)::Real
        """
        Efficiently Compute the Levenshtein (edit) distance between two strings using dynamic programming.
        :param s1: The first string contains M characters.
        :param s2: The second string contains N characters.
        :return: The minimum number of edits required to make the strings the same.
        """
        return fastlevenshtein(Vector{Char}(s1), Vector{Char}(s2), insert_cost, delete_cost, update_cost)
    end

    export fastlevenshtein
end
