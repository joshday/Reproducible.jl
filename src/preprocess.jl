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

    # for i in reverse(1:(length(out) - 1))
    #     if typeof(out[i]) == typeof(out[i+1])
    #         out[i].input *= "\n" * out[i+1].input
    #         out[i].value = deepcopy(out[i+1].value)
    #         deleteat!(out, i+1)
    #     end
    # end
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