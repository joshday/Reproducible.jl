# Reproducible

Reproducible.jl is a lightweight (<100 lines!) package for creating markdown files with 
evaluated julia code inserted into the document.

## Usage


    Reproducible.build(path::String, buildpath::String = joinpath(dirname(path), "build"))

Evaluate the `julia` code blocks in the markdown file specified by `path` and output the 
document into `buildpath`.

The following types of code blocks will be evaluated:

- Show the block and the final return value
````
```julia block
x = 1
y = 2
```
````

- Treat the code as if it were entered into the Julia REPL

````
```julia repl
x = 1
y = 2
```
```` 

- Evaluate the code, but do not show the code or return value

````
```julia hide
x = 1
y = 2
```
````

## Example

See [example/index.md](example/index.md)