module Reproducible

using Markdown

function build(path::String, buildpath::String = joinpath(dirname(path), "build"))
    md = Markdown.parse(read(path, String))
    mod = Main.eval(:(module Temp end))
    isdir(buildpath) && rm(buildpath; recursive=true, force=true)
    open(touch(joinpath(mkdir(buildpath), basename(path))), "w") do f
        for item in md.content
            write(f, isa(item, Markdown.Code) ? evalcode(item, mod) : Markdown.plain(item))
            write(f, '\n')
        end
    end
    md
end

# run the code in the block and return the outputs of each expression
function runcode(o::Markdown.Code, mod)
    n = 1 
    out = []
    while n < length(o.code)
        ex, n = Meta.parse(o.code, n)
        push!(out, @eval(mod, $ex))
    end
    out
end

#-----------------------------------------------------------------------# functions
function juliahide(o, mod) 
    runcode(o, mod)
    return "<!-- $(rstrip(Markdown.plain(o))) -->\n"
end

function juliablock(o, mod) 
    out = runcode(o, mod)
    s = Markdown.plain(o)
    if o.code[end] != ';' 
        s *= "\n```\n$(out[end])\n```\n`"
    end
    return s
end

function juliarepl(o, mod)
    s = "```\n"
    n = 1 
    while n < length(o.code)
        nold = n
        ex, n = Meta.parse(o.code, n)
        val = @eval(mod, $ex)
        s *= "julia> $(o.code[nold:n-1])"
        n > length(o.code) && (s *= "\n")
        s *= "$val"
        n < length(o.code) && (s *= "\n\n")
    end
    s *= "\n```"
    return s
end

function evalcode(o::Markdown.Code, mod) 
    args = split(o.language)
    length(args) == 1 && return Markdown.plain(o)
    if args[1] == "julia"
        args[2] == "hide" && return juliahide(o, mod)
        args[2] == "block" && return juliablock(o, mod)
        args[2] == "repl" && return juliarepl(o, mod)
        @warn("code block argument not identified and was not eval-ed.")
    end
    @warn("code block isn't Julia and was not eval-ed")
end



end # module
