using Reproducible

import Reproducible: render

function Reproducible.render(o::Reproducible.CodeBlock, r::Val{:thing})
    """
    ```
    The first line of your code was $(strip((o.out[1][1])))
    ```
    ```
    The output of of that line was $(o.out[1][2])
    ```
    """
end

srcdir = joinpath(dirname(pathof(Reproducible)), "..", "examples", "docs")
builddir = joinpath(dirname(pathof(Reproducible)), "..", "docs")

Reproducible.build(joinpath(srcdir, "index.md"), builddir, frontmatter = "title: Introduction")
Reproducible.build(joinpath(srcdir, "pandoc.md"), builddir, frontmatter = "title: Using Reproducible with Pandoc")