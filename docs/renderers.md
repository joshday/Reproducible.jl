---
title: Renderers
---

# Custom Renderers

**Reproducible** creates a `CodeBlock` object from markdown code blocks.  `CodeBlock` is an  object that stores a vector of pairs that are essentially `codestring => eval(parse(codestring))`.

To create a custom renderer so that you can use

````
```julia; myrenderer; ky1=true, ky2 = 10
...
```
````

you must overload

```julia
Reproducible.render(o::CodeBlock, r::Val{:myrenderer}; kw...)
```

which should return the String that you wish to be inserted into the output document.

## Custom Renderer Example

If you were to run this in a Julia session before calling `Reproducible.build`

```julia
import Reproducible

function Reproducible.render(o::Reproducible.CodeBlock, r::Val{:thing}; kw...)
    """
    ```
    The first line of your code was $(strip(o[1][1]))
    ```
    ```
    The output of that line was $(o[1][2])
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
The output of that line was 2
```

