```julia hide
builddir = "/Users/joshday/.julia/dev/Reproducible/example/build"
```

# My Title!

## Getting Started

Here is an example of using `julia repl`.

```julia
x = 1 
y = 2
```

Here is an example of using `julia block`.

```julia
x = 1 
y = 2
```

Here I'll use `julia block` to create a plot.  I'll end the block 
with `;` to suppress the output, and then use `julia hide` to save
my plot to my build directory.

```julia block
using Plots
plot(randn(100));
```

```julia hide
png(joinpath(builddir, "img.png"))
```

![](img.png)

## Customized blocks

```julia custom
x = 1
```
