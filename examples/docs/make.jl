module DocMaker
using Reproducible, Random

import Reproducible: render

Random.seed!(1234)

function Reproducible.render(o::Reproducible.CodeBlock, r::Val{:thing}; kw...)
    """
    ```
    The first line of your code was $(strip((o.out[1][1])))
    ```
    ```
    The output of that line was $(o[1][2])
    ```
    """
end

srcdir = joinpath(dirname(pathof(Reproducible)), "..", "examples", "docs")

Reproducible.build(joinpath(srcdir, "index.md"), frontmatter = "title: Introduction")
Reproducible.build(joinpath(srcdir, "renderers.md"), frontmatter = "title: Renderers")
Reproducible.build(joinpath(srcdir, "rendertests.md"), frontmatter = "title: Render Tests")
end