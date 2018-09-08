function pandoc(src, dest)
    run(`pandoc -o $dest $src`)
end