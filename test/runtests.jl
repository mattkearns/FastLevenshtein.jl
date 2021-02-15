using FastLevenshtein
using Test

@testset "The Levenshtein distance should be 0 if..." begin
    @testset "the sequences are empty." begin
        @test fastlevenshtein("", "") == 0
        @test fastlevenshtein([], []) == 0
    end
    @testset "the sequences are the same." begin
        @test fastlevenshtein("a", "a") == 0
        @test fastlevenshtein("abc", "abc") == 0
        @test fastlevenshtein([1], [1]) == 0
        @test fastlevenshtein([1, 2, 3], [1, 2, 3]) == 0
    end
end;

@testset "The Levenshtein distance should be 1 if..." begin
    @testset "we only need to insert 1 value." begin
        @test fastlevenshtein("abc", "ab") == 1
        @test fastlevenshtein("abc", "ac") == 1
        @test fastlevenshtein("abc", "bc") == 1
        @test fastlevenshtein([1, 2, 3], [1, 2]) == 1
        @test fastlevenshtein([1, 2, 3], [1, 3]) == 1
        @test fastlevenshtein([1, 2, 3], [2, 3]) == 1
    end
    @testset "we only need to update 1 value." begin
        @test fastlevenshtein("abc", "abd") == 1
        @test fastlevenshtein("abc", "adc") == 1
        @test fastlevenshtein("abc", "dbc") == 1
        @test fastlevenshtein([1, 2, 3], [1, 2, 4]) == 1
        @test fastlevenshtein([1, 2, 3], [1, 4, 3]) == 1
        @test fastlevenshtein([1, 2, 3], [4, 2, 3]) == 1
    end
    @testset "we only need to remove 1 value." begin
        @test fastlevenshtein("abc", "dabc") == 1
        @test fastlevenshtein("abc", "adbc") == 1
        @test fastlevenshtein("abc", "abdc") == 1
        @test fastlevenshtein("abc", "abcd") == 1
        @test fastlevenshtein([1, 2, 3], [4, 1, 2, 3]) == 1
        @test fastlevenshtein([1, 2, 3], [1, 4, 2, 3]) == 1
        @test fastlevenshtein([1, 2, 3], [1, 2, 4, 3]) == 1
        @test fastlevenshtein([1, 2, 3], [1, 2, 3, 4]) == 1
    end
end;
