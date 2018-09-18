---
title: Introduction
---

# Usage

`Reproducible.build(source, <builddir>; frontmatter="")`

# Markdown

Reproducible uses Julia's standard library `Markdown` package to parse a markdown file, so any  valid markdown syntax is fair game.

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

* `julia; run;`

Evaluate the block, but do not return output.

```julia
x = 1 
y = 2
```

* `julia; hide;`

Evaluate and hide the block



* `julia; block;`

Evaluate the block and also render the final value as an output.

```
x = 1 
y = 2
```

```julia
2
```

* `julia; repl;`

```julia
julia> x = 1
1

julia> y = 2
2
```

Treat the block as if it was entered into the Julia REPL.

# Languages Other Than Julia

Other languages will be left alone, but there's no reason the approach of **Reproducible** could not be extended via [PyCall](https://github.com/JuliaPy/PyCall.jl),  [RCall](https://github.com/JuliaInterop/RCall.jl), etc.

* Input file:

````
```python
import pandas as pd
```
````

* Output file:

```python
import pandas as pd
```

