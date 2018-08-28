# Reproducible

A lightweight package for reproducible reports.  Takes a markdown file as input and
generates a markdown file as output (with evaluated code blocks).

The three kinds of code blocks are: `julia hide`, `julia block`, and `julia repl`.

## `julia hide`

- This:

````
```julia hide
x = 1 
y = 2
```
````

- Inserts into the document:

````
<!-- ```julia hide 
x = 1
y = 2
``` -->
````

## `julia block`

- This:

````
```julia block
x = 1 
y = 2
```
````

- Inserts into the document:
````
```julia block
x = 2
y = 2
```

```
2
```
````

## `julia repl`

- This:

````
```julia repl
x = 1 
y = 2
```
````

- Inserts into the document:

```
julia> x = 1
1

julia> y = 2
2
```