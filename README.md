# Reproducible

Reproducible.jl is a lightweight (<100 lines!) package for creating markdown files with 
evaluated julia code inserted into the document.

## Process 

Markdown -> Markdown with interpolated code -> Pandoc

## Usage

```
import Reproducible

Reproducible.build(path; buildpath, css, to)
```

where 
- `path` is the path to a markdown file
- `buildpath = joinpath(dirname(path), "build")` is the directory where pandoc output goes
- `css = "http://b.enjam.info/panam/styling.css"` is a URL or local path to a css file
- `to = :html` is the type of file to export from pandoc