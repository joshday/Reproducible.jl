module Reproducible

function _string()
end

#-----------------------------------------------------------------------# Code
mutable struct Code
    input::String 
    hidden::Bool  # should the evaled input be hidden from the doc?
    processor     # function to turn output into a string
    Code(input, hidden, processor=string) = new(string(input), hidden, processor)
end
Base.show(io::IO, o::Code) = printstyled(io, o.input, color = o.hidden ? :red : :blue)

#-----------------------------------------------------------------------# MD
mutable struct MD
    input::String 
end
Base.show(io::IO, o::MD) = printstyled(io, o.input, color = :green)

#-----------------------------------------------------------------------# Document
mutable struct Document 
    doc::Vector
end
function Base.show(io::IO, d::Document)
    println(io, "Document with $(length(d.doc)) chunks:")
    for item in d.doc
        println(io, item)
        println(io)
    end
end

#-----------------------------------------------------------------------# preprocess/render
include("preprocess.jl")
include("render.jl")
end # module
