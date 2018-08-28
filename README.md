# Reproducible

Reproducible.jl is a lightweight (<100 lines!) package for creating markdown files with 
evaluated julia code inserted into the document.

## Usage


    Reproducible.build(path::String, buildpath::String = joinpath(dirname(path), "build"))

Evaluate the `julia` code blocks in the markdown file specified by `path` and output the 
document into `buildpath`.

The following types of code blocks will be evaluated:

- Show the block and the final return value
````
```julia block
x = 1
y = 2
```
````

- Treat the code as if it were entered into the Julia REPL

````
```julia repl
x = 1
y = 2
```
```` 

- Evaluate the code, but do not show the code or return value

````
```julia hide
x = 1
y = 2
```
````

## Example

### Input

````
```julia hide
using Reproducible, Plots
builddir = "/Users/joshday/.julia/dev/Reproducible/example/build"
```

# My Title!

## Getting Started

Here is a `julia repl` block.

```julia repl 
x = 1 
y = 2
```

Here is a `julia block` block.

```julia block
x = 1 
y = 2
```

Here I'll make a plot and save it with a hidden block.

```julia block
using Plots
plot(randn(100));
```

```julia hide
png(joinpath(builddir, "img.png"))
```

![](img.png)
````

### Output

````
<!-- ```julia hide
using Reproducible, Plots
builddir = "/Users/joshday/.julia/dev/Reproducible/example/build"
``` -->

# My Title!

## Getting Started

Here is an example of using `julia repl`.

```
julia> x = 1 
1

julia> y = 2
2
```
Here is an example of using `julia block`.

```julia block
x = 1 
y = 2
```

```
2
```

Here I'll use `julia block` to create a plot.  I'll end the block  with `;` to suppress the output, and then use `julia hide` to save my plot to my build directory.

```julia block
using Plots
plot(randn(100));
```

<!-- ```julia hide
png(joinpath(builddir, "img.png"))
``` -->

![](img.png)
````