using FastLevenshtein
using Documenter

makedocs(;
    modules=[FastLevenshtein],
    authors="Matt Kearns mattkearns@protonmail.com",
    repo="https://github.com/mattkearns/FastLevenshtein.jl/blob/{commit}{path}#L{line}",
    sitename="FastLevenshtein.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://mattkearns.github.io/FastLevenshtein.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/mattkearns/FastLevenshtein.jl",
)
