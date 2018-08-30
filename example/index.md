```julia; block; hide=true;
builddir = "/Users/joshday/.julia/dev/Reproducible/example/build"
```

# Running this example $(1 + 1)

To run this example, use

```julia
using Reproducible

Reproducible.build("index.md")
```

# Example on using Reproducible.jl

Here is some math:

\$\$ f(x) = x ^ 2 \$\$

## Getting Started

This code block uses `julia`, and does not get eval-ed

```julia
x = 1 
y = 2
```
Compare that with this block, which uses `julia; repl;`

```julia; repl;
x = 1 
y = 2
```

Compare that with this block, which uses `julia; block;`

```julia; block;
x = 1 
y = 2
```

## Markdown Stuff

| Left Justified | Right Justified |
|:---------------|----------------:|
| I'm left       | I'm right       |
| 1              | 2               |
