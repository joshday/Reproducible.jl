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

Reproducible.build(
    ["example/index.md", 
     "example/pandoc.md"],
    "docs"
)