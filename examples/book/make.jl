using Glob, Reproducible

Reproducible.build(glob("*.md", @__DIR__()), joinpath(@__DIR__(), "build"))