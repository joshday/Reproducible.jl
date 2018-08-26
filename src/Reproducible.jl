module Reproducible

function _string()
end

mutable struct Code
    input::String 
    processor
    output::String 
    Code(input, processor=string) = Code(input, processor, "")
end

mutable struct MD
    input::String 
    output::String 
    MD(input) = MD(input, "")
end

mutable struct Document 
    doc::Vector
end

include("preprocess.jl")


# mutable struct Code <: Chunk
#     s::String
# end
# function Base.show(io::IO, o::Code) 
#     s = split(rstrip(o.s), "\n")
#     for si in s 
#         printstyled(io, "code | " * si; color = :blue)
#         println(io)
#     end
# end

# mutable struct MD <: Chunk
#     s::String 
# end
# function Base.show(io::IO, o::MD) 
#     s = split(rstrip(o.s), "\n")
#     for si in s 
#         printstyled(io, "md   | " * si; color = :green)
#         println(io)
#     end
# end

# struct Document 
#     chunks::Vector{Chunk}
# end
# function Base.show(io::IO, o::Document)
#     for chunk in o.chunks 
#         show(io, chunk)
#     end
# end


# include("preprocess.jl")
# 
end # module
