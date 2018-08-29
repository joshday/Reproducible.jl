module Reproducible

using Markdown

function build(path::String, buildpath::String = joinpath(dirname(path), "build"))
    md = Markdown.parse(read(path, String))
    mod = Main.eval(:(module __Temp__ end))
    isdir(buildpath) && rm(buildpath; recursive=true, force=true)
    open(touch(joinpath(mkdir(buildpath), basename(path))), "w") do f
        for x in md.content
            write(f, isa(x, Markdown.Code) ? code2string(x, mod) : Markdown.plain(x))
            write(f, '\n')
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

#-----------------------------------------------------------------------# CodeOptions
struct CodeOptions 
    eval        # should the code be evaluated?
    echo        # should source be included?
    include     # should return be included?
    hook        # function to turn the output result into a string
    collapse    # should source and return value go in the same markdown code block?
    custom      # f(code::String, mod::Module) that overwrites all other options
end
function CodeOptions(;eval=true, echo=true, include=true, hook=string, collapse=false, custom=nothing)
    CodeOptions(eval, echo, include, hook, collapse, custom)
end
function parseoptions(s::String)
    ex = Meta.parse(s)
    
end

#-----------------------------------------------------------------------# code2string
function code2string(o::Markdown.Code, mod::Module)
    opts = parseoptions(o.language)
end


# #-----------------------------------------------------------------------# juliahide
# function juliahide(o, mod) 
#     runcode(o, mod)
#     return "<!-- $(rstrip(Markdown.plain(o))) -->\n"
# end

# #-----------------------------------------------------------------------# juliablock
# function juliablock(o, mod) 
#     out = runcode(o, mod)
#     s = Markdown.plain(o)
#     if o.code[end] != ';' 
#         s *= "\n```\n$(out[end])\n```\n"
#     end
#     return s
# end

# #-----------------------------------------------------------------------# juliarepl
# function juliarepl(o, mod)
#     s = "```\n"
#     n = 1 
#     while n < length(o.code)
#         nold = n
#         ex, n = Meta.parse(o.code, n)
#         val = @eval(mod, $ex)
#         s *= "julia> $(o.code[nold:n-1])"
#         n > length(o.code) && (s *= "\n")
#         s *= "$val"
#         n < length(o.code) && (s *= "\n\n")
#     end
#     s *= "\n```"
#     return s
# end

# blockfunction(::Val) = (code, mod) -> ""
# blockfunction(::Val{:juliablock}) = juliablock
# blockfunction(::Val{:juliarepl})  = juliarepl
# blockfunction(::Val{:juliahide})  = juliahide

# function code2string(code::Markdown.Code, mod::Module)
#     blockfunction(Val(Symbol(split(code.language)...)))(code, mod)
# end

end # module
