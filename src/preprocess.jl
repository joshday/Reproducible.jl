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

    # TODO: merge adjacent chunks if they are the same type
    # i = length(out)
    # while i > 1 
    #     if typeof(out[i-1]) == typeof(out[i])
    #         out[i-1].input *= "\n" * out[i].input
    #         out[i-1].value = out[i].value
    #         deleteat!(out, i)
    #     end
    #     i -= 1
    # end
    for chunk in out
        chunk.input = lstrip(rstrip(chunk.input))
    end

    d = Document(out)
end