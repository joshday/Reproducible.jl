using Reproducible

"""
---
title: How to Use Reproducible.jl
description: A tutorial on generating reproducible reports in Julia
author: Josh Day
---

# Section

Inline code is just interpolation: $(4 + 5)

Here is some code:
"""

x = 1 + 1

@code y = 2 + 2

@code begin 
    z = randn(50)
    plot(z)
end x-> (png("temp.png"); "![](temp.png)")
