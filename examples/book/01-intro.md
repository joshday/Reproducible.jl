# Introduction

**Reproducible.jl** is a lightweight Julia package for generating reproducible reports.  
It works by evaluating the code blocks in a markdown document via customizable renderers.

The basic syntax for a code block is

````
```julia; <renderer>
x = 1
```
````

where `<renderer>` tells **Reproducible** how to evaluate and insert results into the output
document.  Renderers are customizable, but the built-in options are:

- `run`
    - Run the block and insert the source code.
- `hide`
    - Run the block, but hide the source code.
- `block`
    - Run the block and insert the source code and output of the last line.
- `repl`
    - Treat block as if it were entered into the Julia REPL.

# Renderer Examples

```julia; run;
"This is a `run` block"
```

```julia; hide;
"This is a `hide` block"
```

```julia; block;
"This is a `block` block"
```

```julia; repl;
"This is a `repl` block"
```