```julia hide
builddir = "/Users/joshday/.julia/dev/Reproducible/example/build"
```

# My Title!

## Getting Started

Here is an example of using `julia repl`.

```julia repl 
x = 1 
y = 2
```

Here is an example of using `julia block`.

```julia block
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

```julia block
import Markdown
import Reproducible: blockfunction

blockfunction(::Val{:juliamyblock}) = juliamyblock

function juliamyblock(o::Markdown.Code, mod::Module)
    @eval mod o.code
    return "I eval-ed the code but I'm inserting nonsense into the document"
end
```

```julia myblock
rand(5)
```