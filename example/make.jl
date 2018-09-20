module DocMaker
import Reproducible, Random

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

Reproducible.build(joinpath(dirname(pathof(Reproducible)), "..", "example", "index.md"); toc=true)
end