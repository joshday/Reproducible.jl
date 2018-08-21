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
    x = 1 + 1
end

"""
## Subsection

Here is a plot 
"""

using Plots

@code plot(randn(50)) x->(png("temp.png"), "![](temp.png)")

# this is ignored
2 + 2
