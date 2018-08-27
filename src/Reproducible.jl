module Reproducible

using Markdown

function build(path::String, buildpath::String = joinpath(dirname(path), "build"))
    md = Markdown.parse(read(path, String))
    mod = Core.eval(Main, Meta.parse("module Temp end"))
    isdir(buildpath) && rm(buildpath; recursive=true, force=true)
    file = touch(joinpath(mkdir(buildpath), basename(path)))
    open(file, "w") do f
        for item in md.content
            write(f, getstring(item) * '\n')
        end
    end
    md
end

getstring(o) = Markdown.plain(o)

function getstring(o::Markdown.Code) 
    if o.language == ""
        return Markdown.plain(o)
    elseif o.language == "julia"
        return Markdown.plain(o)
    else 
        return Markdown.plain(o)
    end

end


end # module
