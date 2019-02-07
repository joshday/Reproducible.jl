module DocMaker
import Reproducible, Random

Random.seed!(1234)

function Reproducible.render(o::Reproducible.CodeBlock, r::Val{:thing}; kw...)
    """
    ```
    The first line of your code was $(strip((o.rows[1].input)))
    ```
    ```
    The output of that line was $(o.rows[1].repldisplay)
    ```
    """
end

Reproducible.build(joinpath(@__DIR__(), "index.md"); toc=true)
end