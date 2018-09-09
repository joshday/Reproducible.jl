#-----------------------------------------------------------------------# renderers
"""
    render(o::CodeBlock, r::Val{:renderer}; kw...)::String

Render a [`CodeBlock`](@ref) for the given `:renderer`, which can be used via

    ```julia; renderer;
    ...
    ```
"""
function render(o::CodeBlock, r::Val{T}; kw...) where {T}
    @warn "Reproducible does not recognize the renderer `$T`.  Code block not eval-ed."
    block(codestring(o))
end

render(o::CodeBlock, r::Val{:run}; kw...) = juliablock(codestring(o))
render(o::CodeBlock, r::Val{:hide}; kw...) = ""

function render(o::CodeBlock, r::Val{:block}; kw...)
    juliablock(codestring(o)) * "\n" * block(string(last(o.out[end])))
end

function render(o::CodeBlock, r::Val{:repl}; kw...)
    s = ""
    for ex in o.out
        s *= "julia> " * strip(first(ex)) * '\n' * string(last(ex)) * "\n\n"
    end
    juliablock(s)
end

#-----------------------------------------------------------------------# test utils
function render(o::CodeBlock, r::Val{:rendertest}; renderer::Symbol=:block)
    """
    **Render Test for $renderer**:

    ````
    $(block(codestring(o), "julia; $renderer"))````

    $(render(o, Val(renderer)))
    """
end

function render(o::CodeBlock, r::Val{:testall}; kw...)
    render(o, Val(:rendertest); renderer = :block) * 
        render(o, Val(:rendertest); renderer = :repl) * 
        render(o, Val(:rendertest); renderer = :run)
end