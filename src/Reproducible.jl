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

function evalcode(o::Markdown.Code, mod) 
    args = split(o.language)
    (o.language == "" || length(args) == 1) && return Markdown.plain(o)

    function runcode()
        n = 1 
        out = []
        while n < length(o.code)
            ex, n = Meta.parse(o.code, n)
            push!(out, @eval(mod, $ex))
        end
        out
    end

    if startswith(o.language, "julia hide")
        runcode()
        return ""
    elseif startswith(o.language, "julia repl")
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
    elseif startswith(o.language, "julia block")
        return "$(Markdown.plain(o))\n```\n$(runcode()[end])\n```\n"
    end

end


end # module
