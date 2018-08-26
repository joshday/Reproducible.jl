function render(d::Document, builddir = tempdir())
    file = touch(joinpath(builddir, "thing.md"))
    mod = eval(Meta.parse("module Temp end"))
    open(file, "w") do io 
        for chunk in d.doc
            write(io, chunk2string(mod, chunk))
            write(io, "\n")
        end
    end
    run(`open $file`)
end