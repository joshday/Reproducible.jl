using Reproducible

"""
---
title: How to Use Reproducible.jl
description: A tutorial on generating reproducible reports in Julia
author: Josh Day
---

# Section

Inline uses Julia's built in interpolation: 4 + 5 = $(4 + 5)

Here is some code:
"""

x = 1 + 1

@code y = 2 + 2

"Here is a vector:"

@code begin 
    z = randn(5)
end
