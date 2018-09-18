module BookMake
using Glob, Reproducible

files = glob("*.md", @__DIR__())

builddir = joinpath(@__DIR__(), "build")

Reproducible.build(files, builddir)
end