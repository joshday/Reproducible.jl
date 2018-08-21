#-----------------------------------------------------------------------# Introduction
"""
# Introduction

## Basics of BookGenerator.jl

BookGenerator relies on macros to generate markdown files with evaluated Julia code interspersed
in the file.  Here is an example of an evaluated code block.  The syntax 

```
@code begin 
    1 + 1
end
```

results in the output:
"""

@code begin 
    1 + 1
end

#-----------------------------------------------------------------------# Plots
"""
## Plots

Here is a plot
"""

@code begin 
    using Plots

    plot(randn(100))
end x -> (png("temp.png"); "![](temp.png)")