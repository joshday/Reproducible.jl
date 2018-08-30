module Reproducible

using Markdown

function build(path::String, buildpath::String = joinpath(dirname(path), "build"); 
        to = :html, 
        style = joinpath(@__DIR__(), "..", "styles", "github.css"),
        css = "http://b.enjam.info/panam/styling.css")
    mod = Main.eval(:(module __Temp__ end))
    @eval mod using Reproducible
    md = Markdown.parse(read(path, String))
    isdir(buildpath) && rm(buildpath; recursive=true, force=true)
    file = touch(joinpath(mkdir(buildpath), basename(path)))
    open(file, "w") do io
        for x in md.content
            write(io, isa(x, Markdown.Code) ? code2string(x, mod) : Markdown.plain(x))
            write(io, '\n')
        end
    end
    output = file[1:(end-3)] * ".$to"
    run(`pandoc --standalone --from markdown --katex --to $to $file -o $output --css $css`)
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

function repl(code, mod)
    out = eval_in(code, mod)
    s = "```"
    for outi in out 
        s *= "\njulia> $(strip(outi[1]))\n$(outi[2])\n"
    end
    s * "```\n"
end
function block(code, mod)
    out = eval_in(code, mod)
    "```\n$code\n```\n\n```\n$(out[end][2])\n```"
end
hide(code, mod) = (eval_in(code, mod); "")

#-----------------------------------------------------------------------# code2string
function code2string(o::Markdown.Code, mod::Module)
    blocktype = Meta.parse(o.language)
    if blocktype isa Symbol 
        return Markdown.plain(o)
    elseif blocktype isa Expr 
        if blocktype.args[1] != :julia
            return Markdown.plain(o)
        else
            f = blocktype.args[2]
            f == :repl && return repl(o.code, mod)
            f == :block && return block(o.code, mod)
            f == :hide && return hide(o.code, mod)
        end
    end
end

end # module
