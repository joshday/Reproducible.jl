#-----------------------------------------------------------------------# renderers
"""
    render(o::CodeBlock, r::Val{:renderer})::String

Render a [`CodeBlock`](@ref) for the given `:renderer`, which can be used via

    ```julia; renderer;
    ...
    ```
"""
function render(o::CodeBlock, r::Val{T}) where {T}
    @warn "Reproducible does not recognize the renderer $T.  Code block not eval-ed."
    block(codestring(o))
end

render(o::CodeBlock, r::Val{:julia}) = juliablock(codestring(o))
render(o::CodeBlock, r::Val{:hide}) = ""

function render(o::CodeBlock, r::Val{:block})
    juliablock(codestring(o)) * "\n" * block(string(last(o.out[end])))
end

function render(o::CodeBlock, r::Val{:repl})
    s = ""
    for ex in o.out
        s *= "julia> " * strip(first(ex)) * '\n' * string(last(ex)) * "\n\n"
    end
    juliablock(s)
end