using BenchmarkTools
using FastLevenshtein


one_hot_vector_1 = rand((0, 1), 10_000)
one_hot_vector_2 = rand((0, 1), 10_000)

@benchmark fastlevenshtein(one_hot_vector_1, one_hot_vector_2)