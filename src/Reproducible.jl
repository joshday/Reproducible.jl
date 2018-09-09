module Reproducible

using Markdown

#-----------------------------------------------------------------------# build
function build(path::String, builddir = joinpath(dirname(path), "build"); frontmatter::String = "")
    mod = Main.eval(:(module __Temp__ end))
    !isdir(builddir) && mkdir(builddir)
    # isfile(joinpath(builddir, basename(path))) && rm(joinpath(builddir, basename(path)))
    file = touch(joinpath(builddir, basename(path)))
    open(file, "w") do io
        !isempty(frontmatter) && write(io, "---\n$(strip(frontmatter))\n---\n\n")
        for x in Markdown.parse(read(path, String)).content
            write(io, markdown2string(x, mod) * '\n')
        end
    end
    return file
end

function build(paths, builddir = joinpath(dirname(paths[1]), "build"))
    files = []
    for path in paths 
        push!(files, build(path, builddir))
    end
    files
end

function markdown2string(x, mod) 
    if isa(x, Markdown.Code)
        isa(Meta.parse(x.language), Expr) ? code2string(x, mod) : Markdown.plain(x)
    else
        Markdown.plain(x)
    end
end

function code2string(x::Markdown.Code, mod::Module)
    ex = Meta.parse(x.language)
    lang = ex.args[1]
    if lang == :julia
        v = Val(Meta.parse(x.language).args[end])
        render(CodeBlock(x.code, mod), v)
    else
        @warn "Reproducible doesn't know how to eval a code block with language $lang...skipping"
        Markdown.plain(x)
    end
end
#-----------------------------------------------------------------------# CodeBlock
"""
    CodeBlock(code::String, mod::Module)

Object to represent code for a **Reproducible** renderer.  The constructor parses/evaluates
the code inside the provided module.  A `CodeBlock` is a wrapper around a vector of pairs
where each element is:

    codestring => eval(parse(codestring))

This allows renderers to have access to all of the inputs and outputs of a code block.  
For docs on writing a new renderer, see [`render`](@ref).
"""
struct CodeBlock
    out::Vector{Pair{String, Any}}
end
function CodeBlock(code::String, mod::Module)
    n = 1 
    out = Pair{String,Any}[]  
    while n < length(code)
        nold = n
        ex, n = Meta.parse(code, n)
        push!(out, code[nold:n-1] => @eval(mod, $ex))
    end
    CodeBlock(out)
end
Base.getindex(o::CodeBlock, i) = o.out[i]

# utils
codestring(o::CodeBlock) = join(first.(o.out))
juliablock(s::String) = "```julia\n$(strip(s))\n```\n"
block(s::String) = "```\n$(strip(s))\n```\n"

#-----------------------------------------------------------------------# renderers
"""
    render(o::CodeBlock, r::Val{:renderer})::String

Render a [`CodeBlock`](@ref) for the given `:renderer`, which can be used via

    ```julia; renderer;
    ...
    ```
"""
function render(o::CodeBlock, r::Val{T}) where {T}
    @warn "Reproducible does not recognize the renderer $T.  Code block not evaled."
    block(codestring(o))
end

render(o::CodeBlock, r::Val{:julia}) = juliablock(codestring(o))
render(o::CodeBlock, r::Val{:hide}) = ""

function render(o::CodeBlock, r::Val{:block})
    juliablock(codestring(o)) * "\n" * block(string(last(o.out[end])))
end

function render(o::CodeBlock, r::Val{:repl})
    s = ""
    for ex in o.out
        s *= "julia> " * strip(first(ex)) * '\n' * string(last(ex)) * "\n\n"
    end
    juliablock(s)
end

end # module
