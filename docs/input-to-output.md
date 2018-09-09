---
title: Render Tests
---

## Block

  * Source:

````
```julia; block;
x = 1

y = 2
```
````

  * Rendered:

```julia
x = 1

y = 2
```

```
2
```

---

  * Source:

````
```julia; block;
x = randn(3, 3)
```
````

  * Rendered:

```julia
x = randn(3, 3)
```

```
[-0.301106 -0.612104 0.815945; -2.37738 -1.08269 0.854214; -1.82146 -0.722992 0.0653711]
```

## Repl

  * Source:

````
```julia; repl;
x = 1

y = 2
```
````

  * Rendered:

```julia
julia> x = 1
1

julia> y = 2
2
```

---

  * Source:

````
```julia; repl;
x = randn(3, 3)
```
````

  * Rendered:

```julia
julia> x = randn(3, 3)
[-0.200734 0.313571 0.54887; -0.972026 0.587109 -1.72777; 0.82165 -0.614287 -0.672044]
```

