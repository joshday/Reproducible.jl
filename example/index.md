# Reproducible.jl

1. Write markdown
2. Evaluate/interpolate code blocks
3. Pandoc it 

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


# Code Blocks

Suppose our input document has this:
````
```julia; <fun>
x = 1 
y = 2
```
````


## `repl`

```julia; repl;
x = 1
y = 2 
```

## `block`

```julia; block
x = 1
y = 2
```



