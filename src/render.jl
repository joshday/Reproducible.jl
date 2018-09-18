#-----------------------------------------------------------------------# renderers
"""
    render(o::CodeBlock, r::Val{:renderer}; kw...)::String

Render a [`CodeBlock`](@ref) for the given `:renderer`, which can be used via

    ```julia; renderer;
    ...
    ```

`kw...` always contains `builddir`.
"""
function render(o::CodeBlock, r::Val{T}; kw...) where {T}
    @warn "Reproducible does not recognize the renderer `$T`.  Code block not eval-ed."
    block(codestring(o))
end

#-----------------------------------------------------------------------# run
render(o::CodeBlock, r::Val{:run}; kw...) = block(codestring(o), "julia; run;")

#-----------------------------------------------------------------------# hide
render(o::CodeBlock, r::Val{:hide}; kw...) = ""

#-----------------------------------------------------------------------# block
function render(o::CodeBlock, r::Val{:block}; out = x -> repr("text/plain", x), kw...)
    block(codestring(o)) * "\n" * block(out(last(o.out[end])), "julia; block;")
end

#-----------------------------------------------------------------------# repl
function render(o::CodeBlock, r::Val{:repl}; out = x -> repr("text/plain", x), kw...)
    s = ""
    for ex in o.out
        s *= "julia> " * strip(first(ex)) 
        !endswith(strip(first(ex)), ';') && (s *= '\n' * repr("text/plain", last(ex)))
        s *= "\n\n"
    end
    block(s, "julia; repl;")
end

#-----------------------------------------------------------------------# docstring
function render(o::CodeBlock, r::Val{:docstring}; kw...)
    Markdown.plain(Docs.doc(output(o)))
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