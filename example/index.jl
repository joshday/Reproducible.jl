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

@hide x = 1 + 1

y = 2 + 2

""

y = 3 + 3

y2 = 4 + 4

"Here is a vector:"

z = randn(5)

"""
And here is a plot of that same vector.
"""

using Plots
plot(z)
