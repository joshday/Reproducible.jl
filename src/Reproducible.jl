module Reproducible

using Markdown

function build(path::String, builddir::String = joinpath(dirname(path), "build"))
    mod = Main.eval(:(module __Temp__ end))
    !isdir(builddir) && mkdir(builddir)
    file = touch(joinpath(builddir, basename(path)))
    open(file, "w") do io
        for x in Markdown.parse(read(path, String)).content
            write(io, markdown2string(x, mod) * '\n')
        end
    end
    return file
end

function markdown2string(x, mod)
    if isa(x, Markdown.Code) 
        code2string(x, mod)
    else
        Markdown.plain(x)
    end
end

#-----------------------------------------------------------------------# eval/render
# parse and eval `code` into `mod`
function eval_in(code::String, mod::Module)
    n = 1 
    out = Pair{String,Any}[]  
    while n < length(code)
        nold = n
        ex, n = Meta.parse(code, n)
        push!(out, code[nold:n-1] => @eval(mod, $ex))
    end
    out  # Vector{Pair}: code => result
end

function repl(code, mod; hook=identity)
    out = eval_in(code, mod)
    s = "```julia"
    for outi in out 
        s *= "\njulia> $(strip(outi[1]))\n$(outi[2])\n"
    end
    hook(s * "```\n")
end
function block(code, mod; hide=false, hook=identity)
    out = eval_in(code, mod)
    hook(hide ? "" : "```\n$code\n```\n\n```\n$(out[end][2])\n```\n")
end

#-----------------------------------------------------------------------# code2string
function code2string(o::Markdown.Code, mod::Module)
    x = Meta.parse(o.language)
    x isa Nothing       && return Markdown.plain(o)
    x isa Symbol        && return Markdown.plain(o)
    x.args[1] != :julia && return Markdown.plain(o)
    kw = namedtuple(x.args[3:end])
    try 
        getfield(Reproducible, x.args[2])(o.code, mod; kw...)
    catch
        @warn("Attempted to treat code block with `$(x.args[2])`.  Use `block` or `repl`")
    end
end

# take vector of expressions like :(hide = true) and create a NamedTuple
function namedtuple(args::Vector)
    prs = [Pair(a.args[1], a.args[2]) for a in args]
    names = tuple([p[1] for p in prs]...)
    tup = tuple([p[2] for p in prs]...)
    NamedTuple{names, typeof(tup)}(tup)
end

end # module
