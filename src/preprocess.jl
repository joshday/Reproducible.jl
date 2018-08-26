# Create the `Document` from the path to a .jl file 
# Each chunk contains a string that will get parsed by the renderer
function preprocess(path)
    out = []
    temp = ""
    mod = eval(Meta.parse("module Temp end"))

    for line in eachline(path)
        line = line * "\n"
        ex = Meta.parse(temp *= line; raise=false)
        (ex == nothing  || (isa(ex, Expr) && ex.head == :incomplete) || line == "\n") && continue 
        val = @eval mod $ex 
        temp = rstrip(lstrip(temp))
        if isa(val, AbstractString)
            push!(out, MD(val))
        elseif occursin("@code", temp)
            push!(out, Code(_code(temp), val))
        else
            push!(out, HiddenCode(temp))
        end
        @show temp
        temp = ""
    end

    Document(out)
end


function _code(temp)
    
end