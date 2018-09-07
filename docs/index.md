# Reproducible.jl

1. Write markdown
2. Evaluate/interpolate code blocks

# Usage

`Reproducible.build(source)`

# Markdown

Reproducible uses Julia's built in `Markdown` package to parse a markdown file, so any  valid markdown syntax is fair game.

| Here |  is |   a | table |
| ----:| ---:| ---:| -----:|
|    A |   B |   C |     D |

  * Here
  * is
  * a
  * list

```julia
# here is some julia code with syntax highlighting

f(x) = x ^ 2
```

# Code Blocks

Everything in the original source markdown file is treated as normal markdown, apart from  code blocks.  If a code block's language is `julia; <renderer>`, **Reproducible** will  evaluate the code block and insert something into the output document based on the `renderer`.

## `julia;`

Evaluate the block, but do not return output.

```julia
x = 1 
y = 2
```

## `julia; hide;`

Evaluate and hide the block


## `julia; block;`

Evaluate the block and also render the final value as an output.

```julia
x = 1 
y = 2
```

```
2
```

## `julia; repl;`

```julia
julia> x = 1
1

julia> y = 2
2
```

Treat the block as if it was entered into the Julia REPL.

## Custom Renderers

Reproducible creates a `CodeBlock` object from markdown code blocks.  `CodeBlock` is an  object that stores a vector of pairs that are essentially `codestring => eval(parse(codestring))`.

To create a custom renderer, you must overload

```julia
Reproducible.render(o::CodeBlock, r::Val{myrenderer})
```

which should return the String that you wish to be inserted into the output document.

