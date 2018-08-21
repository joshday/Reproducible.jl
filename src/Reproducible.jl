module Reproducible

export @code

#-----------------------------------------------------------------------# Chunks
abstract type Chunk end

mutable struct Code <: Chunk
    s::String
end
function Base.show(io::IO, o::Code) 
    s = split(rstrip(o.s), "\n")
    for si in s 
        printstyled(io, "code | " * si; color = :blue)
        println(io)
    end
end

mutable struct MD <: Chunk
    s::String 
end
function Base.show(io::IO, o::MD) 
    s = split(rstrip(o.s), "\n")
    for si in s 
        printstyled(io, "md   | " * si; color = :green)
        println(io)
    end
end

struct Document 
    chunks::Vector{Chunk}
end
function Base.show(io::IO, o::Document)
    for chunk in o.chunks 
        show(io, chunk)
    end
end

#-----------------------------------------------------------------------# @code

macro code(s)
    :(__output__from__chunk__ = $(string(s)); $s)
end

include("preprocess.jl")

end # module
