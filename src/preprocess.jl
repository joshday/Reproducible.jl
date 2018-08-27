# Create the `Document` from the path to a .jl file 
# Each chunk contains a string that will get parsed by the renderer
function preprocess(path)
    out = []
    temp = ""
    mod = Core.eval(Main, Meta.parse("module Temp\n end"))  # module to eval code into

    for line in eachline(path)
        line = line * "\n"
        # if block doesn't parse, add the next line and try again
        ex = Meta.parse(temp *= line; raise=false)
        isa(ex, Expr) && ex.head == :incomplete && continue 

        val = @eval mod $ex
        temp = rstrip(lstrip(temp))
        if isa(val, String) 
            push!(out, MD(rstrip(lstrip(val))))
        elseif !occursin("@hide", temp) 
            push!(out, Code(temp, val))
        else 
            push!(out, HiddenCode(temp))
        end
        temp = ""
    end

    for i in length(out):-1:2 
        if typeof(out[i]) == typeof(out[i-1])
            out[i-1].input *= "\n" * out[i].input
            out[i-1].value = out[i].value 
            deleteat!(out, i)
        end
    end
    for chunk in out
        chunk.input = lstrip(rstrip(chunk.input))
    end

    d = Document(out)
end

# remove @code or @code begin ... end block
function _code(temp)
    # @code
    temp = rstrip(lstrip(replace(temp, "@code" => "")))

    # @code begin ... end
    if startswith(temp, "begin")
        s = split(temp, "\n")
        s = s[2:(end-1)]
        all(x -> startswith(x, "    "), s) && (s = [si[5:end] for si in s])
        temp = rstrip(lstrip(join(s, "\n")))
    end
    temp
end