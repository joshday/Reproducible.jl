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
        (ex == nothing  || (isa(ex, Expr) && ex.head == :incomplete) || line == "\n") && continue 

        val = if isa(ex, Expr)
            e = ex.head == :macrocall ? ex.args[3] : ex
            @eval mod $e
        else
            @eval(mod, $ex)
        end
        # val = ex.head == :macrocall ? @eval(mod, $(ex.args[3])) :  # eval into Temp
        temp = rstrip(lstrip(temp)) 
        if isa(val, AbstractString)
            push!(out, MD(val))
        elseif occursin("@code", temp)
            push!(out, Code(_code(temp), val))  # remove @code wrapper
        else
            push!(out, HiddenCode(temp))  # add the block (for debugging only)
        end
        temp = ""
    end

    Document(out)
end


function _code(temp)
    temp = lstrip(replace(temp, "@code" => ""))
    if startswith(temp, "begin")
        temp = lstrip(replace(temp, "begin" => ""))
        temp = rstrip(replace(temp, "end" => ""))
    end
    temp
end