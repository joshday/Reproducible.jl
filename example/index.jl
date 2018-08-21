using Reproducible

"""
---
title: How to Use Reproducible.jl
description: A tutorial on generating reproducible reports in Julia
author: Josh Day
---

# Section

Here is some code:
"""

@code begin 
    1 + 1
end

"""
## Subsection

Here is a plot 
"""

using Plots

@code plot(randn(5)) x->(png("temp.png"), "![](temp.png)")

"This is ignored"

# so is this 
2 + 2

include("ch1.jl")
