using Reproducible, Test

import Reproducible: CodeBlock

module TestMod
end

cb = CodeBlock("x = 1\ny = 2", TestMod)
@test strip(cb[1][1]) == "x = 1"
@test cb[1][2] == 1
@test cb[2][1] == "y = 2"
@test cb[2][2] == 2