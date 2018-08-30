module Reproducible

using Markdown

function build(path::String, buildpath::String = joinpath(dirname(path), "build"))
    s = read(path, String)
    mod = Main.eval(:(module __Temp__ end))
    s2 = @eval mod $s
    md = Markdown.parse(s2)
    isdir(buildpath) && rm(buildpath; recursive=true, force=true)
    open(touch(joinpath(mkdir(buildpath), basename(path))), "w") do io
        for x in md.content
            write(io, isa(x, Markdown.Code) ? code2string(x, mod) : Markdown.plain(x))
            write(io, '\n')
        end
    end
end

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

# knitr options
    # eval        # should the code be evaluated?
    # echo        # should source be included?
    # include     # should return be included?
    # hook        # function to turn the output result into a string
    # collapse    # should source and return value go in the same markdown code block?
    # custom      # f(code::String, mod::Module) that overwrites all other options


#-----------------------------------------------------------------------# code2string
function code2string(o::Markdown.Code, mod::Module)
    blocktype = Meta.parse(o.language)
    if blocktype isa Symbol 
        return Markdown.plain(o)
    elseif blocktype isa Expr 
        if blocktype.args[1] != :julia
            return Markdown.plain(o)
        else
            @show blocktype.args
            # FIXME
            return ""
        end
    end
end

end # module
