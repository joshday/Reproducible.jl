**Reproducible.jl** is a lightweight Julia package for creating reproducible reports. 

The process:

1. Write Markdown
2. Generate Markdown (with *rendered* code blocks)

**Reproducible** treats code blocks in the source document according to a *renderer*,
but simply copies over all other parts of the source.
The basic syntax for a **Reproducible** code block is

````
```julia; <renderer>
x = 1
```
````

If you are already familiar with the fantastic [Documenter.jl](https://github.com/JuliaDocs/Documenter.jl) 
package, think of **Reproducible** as a more customizable way to write `@example`, `@repl`, etc. blocks.

# Usage

To render the code blocks in a `source` file, use the `Reproducible.build` function:

`Reproducible.build(source, <builddir>; frontmatter="")`

Note that **Reproducible** uses Julia's `Markdown` package in the standard library, which does not parse
YAML frontmatter, e.g.

```
---
title: Introduction
author: Josh Day
---
```

To work around this, `frontmatter` can be passed as a keyword argument to `build` e.g.
`build(src; frontmatter = "title:Introduction\nauthor:Josh Day")`

# Built-in Renderers

Renderers are meant to be customizable (see [renderers.md](renderers.md)), but there are some
built into **Reproducible**:

- `run`
    - Run the block and insert the source code.
```julia; run;
x = "This is rendered via `julia; run;`"
```

- `hide`
    - Run the block, but hide the source code.
```julia; hide;
x = "This is rendered via `julia; hide;`"
```

- `block`
    - Run the block and insert the source code and output of the last line.
```julia; block;
x = "This is rendered via `julia; block;`"
```

- `repl`
    - Treat block as if it were entered into the Julia REPL.
```julia; repl;
x = "This is rendered via `julia; repl;`"
```

# Markdown

Reproducible uses Julia's standard library `Markdown` package to parse a markdown file, so any 
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

Everything in the original source markdown file is treated as normal markdown, apart from 
code blocks.  If a code block's language is `julia; <renderer>`, **Reproducible** will 
evaluate the code block and insert something into the output document based on the `renderer`.

- `julia; run;`

Evaluate the block, but do not return output.

```julia; run;
x = 1 
y = 2
```

- `julia; hide;`

Evaluate and hide the block

```julia; hide;
x = 1
y = 2
```

- `julia; block;`

Evaluate the block and also render the final value as an output.

```julia; block;
x = 1 
y = 2
```

- `julia; repl;`

```julia; repl;
x = 1 
y = 2
```

Treat the block as if it was entered into the Julia REPL.

# Languages Other Than Julia

Other languages will be left alone, but there's no reason the approach of **Reproducible**
could not be extended via [PyCall](https://github.com/JuliaPy/PyCall.jl), 
[RCall](https://github.com/JuliaInterop/RCall.jl), etc.

- Input file:
````
```python
import pandas as pd
```
````
- Output file:
  
```python
import pandas as pd
```