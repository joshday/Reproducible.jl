module Reproducible

using Markdown

function build(path::String, buildpath::String = joinpath(dirname(path), "build"); 
        to = :html, 
        style = joinpath(@__DIR__(), "..", "styles", "github.css"),
        css = "https://raw.githubusercontent.com/sindresorhus/github-markdown-css/gh-pages/github-markdown.css")
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
    run(`pandoc --from markdown --katex --to $to $file -o $output --css $css`)
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

function repl(code, mod)
    out = eval_in(code, mod)
    s = "```"
    for outi in out 
        s *= "\njulia> $(strip(outi[1]))\n$(outi[2])\n"
    end
    s * "```\n"
end


#-----------------------------------------------------------------------# code2string
function code2string(o::Markdown.Code, mod::Module)
    blocktype = Meta.parse(o.language)
    if blocktype isa Symbol 
        return Markdown.plain(o)
    elseif blocktype isa Expr 
        if blocktype.args[1] != :julia
            return Markdown.plain(o)
        else
            repl(o.code, mod)
        end
    end
end

end # module
