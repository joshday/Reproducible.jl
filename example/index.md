# Reproducible.jl

1. Write markdown
2. Evaluate/interpolate code blocks

# Usage 

`Reproducible.build(source, builddir = joinpath(dirname(source), "build"))`

Note: this page is built by running `Reproducible.build("example/index.md", "docs")`.

# Markdown

Reproducible uses Julia's built in `Markdown` package to parse a markdown file, so any 
valid markdown syntax is fair game.

| Here | is | a | table |
|------|----|---|-------|
| A    | B  | C | D     |

- Here
- is
- a
- list

```julia
# here is some julia code with syntax highlighting

f(x) = x ^ 2
```


# Code Blocks

Suppose our input document has this:
````
```julia; fun
x = 1 
y = 2
```
````


## `fun == repl`

```julia; repl;
x = 1
y = 2 
```

## `fun == block`

```julia; block
x = 1
y = 2
```



