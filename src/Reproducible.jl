module Reproducible

export @hide

macro hide(s) 
    :($(esc(s)))
end

abstract type Chunk end

#-----------------------------------------------------------------------# MD
mutable struct MD <: Chunk
    input::String 
end
Base.show(io::IO, o::MD) = printstyled(io, o.input, color = :green)

#-----------------------------------------------------------------------# Code
mutable struct Code <: Chunk
    input::String 
    value 
end
Base.show(io::IO, o::Code) = printstyled(io, _md(o), color = :blue)

function _md(o::Code)
    if o.value == nothing 
        "$(o.input)"
    else
        """
        ```julia 
        $(o.input)
        ```
        ```
        $(_string(o.value))
        ```""" 
    end
end

_string(v) = string(v)
_string(v::Nothing) = ""

#-----------------------------------------------------------------------# Hidden Code 
mutable struct HiddenCode <: Chunk
    input::String
end
Base.show(io::IO, o::HiddenCode) = printstyled(io, o.input, color = :red)

#-----------------------------------------------------------------------# Document
mutable struct Document 
    doc::Vector{Chunk}
end
function Base.show(io::IO, d::Document)
    println(io, "Document with $(length(d.doc)) chunks:")
    for (i, item) in enumerate(d.doc)
        println(io, "#-------------------------------------------------------# Chunk $i")
        println(io, item)
    end
end

#-----------------------------------------------------------------------# preprocess/render
include("preprocess.jl")
include("render.jl")
end # module
