module Reproducible

export @code

macro code(s) 
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
    """
    ```julia 
    $(o.input)
    ```
    ```
    $(_string(o.value))
    ```
    """ 
end

_string(v) = string(v)

#-----------------------------------------------------------------------# Hidden Code 
mutable struct HiddenCode <: Chunk
    input::String
end
Base.show(io::IO, o::HiddenCode) = printstyled(io, o.input, color = :red)

# #-----------------------------------------------------------------------# Code
# mutable struct Code
#     input::String 
#     hidden::Bool  # should the evaled input be hidden from the doc?
#     processor     # function to turn output into a string
#     Code(input, hidden, processor=string) = new(string(input), hidden, processor)
# end
# Base.show(io::IO, o::Code) = printstyled(io, o.input, color = o.hidden ? :red : :blue)

# function chunk2string(mod, o::Code)
#     """
#     Input:
#     ```
#     $(o.input)
#     ```

#     Output:
#     ```
#     $(o.processor(chunkeval(mod, o)))
#     ```
#     """
# end

# #-----------------------------------------------------------------------# MD
# mutable struct MD
#     input::String 
# end
# Base.show(io::IO, o::MD) = printstyled(io, o.input, color = :green)

# chunk2string(mod, o::MD) = o.input

# #-----------------------------------------------------------------------# common 
# chunkeval(mod, chunk) = @eval mod Meta.parse($(chunk.input))


#-----------------------------------------------------------------------# Document
mutable struct Document 
    doc::Vector{Chunk}
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
# include("render.jl")
end # module
