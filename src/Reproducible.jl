module Reproducible

export @code

# function __init__()
#     @require Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80" _init_plots()
# end
abstract type Chunk end
mutable struct Content <: Chunk
    s::String
end
mutable struct Code <: Chunk
    s::String 
end

macro content(s) nothing end 

# expression, value, writer
macro code(s, writer=string) 
    :($(esc(s)), $writer)
end

include("preprocess.jl")

end # module
