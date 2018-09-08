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

  * `julia;`

Evaluate the block, but do not return output.

```julia
x = 1 
y = 2
```

  * `julia; hide;`

Evaluate and hide the block


  * `julia; block;`

Evaluate the block and also render the final value as an output.

```julia
x = 1 
y = 2
```

```
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

# Custom Renderers

**Reproducible** creates a `CodeBlock` object from markdown code blocks.  `CodeBlock` is an  object that stores a vector of pairs that are essentially `codestring => eval(parse(codestring))`.

To create a custom renderer so that you can use 

````
```julia; myrenderer;
...
```
````

you must overload

```julia
Reproducible.render(o::CodeBlock, r::Val{:myrenderer})
```

which should return the String that you wish to be inserted into the output document.

## Custom Renderer Example

If you were to run this in a Julia session before calling `Reproducible.build`

```julia
import Reproducible

function Reproducible.render(o::Reproducible.CodeBlock, r::Val{:thing})
    """
    ```
    The first line of your code was $(strip((o.out[1][1])))
    ```
    ```
    The output of of that line was $(o.out[1][2])
    ```
    """
end
```

and the input document contained

````
```julia;thing;
1 + 1
2 + 2
```
````

the output would look like:

```
The first line of your code was 1 + 1
```
```
The output of of that line was 2
```

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

