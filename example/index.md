```julia hide
using Reproducible, Plots
builddir = "/Users/joshday/.julia/dev/Reproducible/example/build"
```

# My Title!

## Getting Started

This block executes each line as if it were in a Julia REPL.
Use julia repl:

```julia repl 
x = 1 
y = 2
```

This executes the block together and includes the output:

```julia block
x = 1 
y = 2
```

Here is a chunk of text
And then I make a plot!

```julia block
using Plots
plot(randn(100));
```

```julia hide
png(joinpath(builddir, "img.png"))
```

![](img.png)