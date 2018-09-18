---
title: Render Tests
---

# Render Tests

## Test 1 (empty line)

**Render Test for block**:

````
```julia; block
x = 1

y = 2
```
````

```
x = 1

y = 2
```

```julia; block;
2
```

**Render Test for repl**:

````
```julia; repl
x = 1

y = 2
```
````

```julia; repl;
julia> x = 1
1

julia> y = 2
2
```

**Render Test for run**:

````
```julia; run
x = 1

y = 2
```
````

```julia; run;
x = 1

y = 2
```

## Test 2 (with `;`)

**Render Test for block**:

````
```julia; block
x = 1;

y = 2
```
````

```
x = 1;

y = 2
```

```julia; block;
2
```

**Render Test for repl**:

````
```julia; repl
x = 1;

y = 2
```
````

```julia; repl;
julia> x = 1;

julia> y = 2
2
```

**Render Test for run**:

````
```julia; run
x = 1;

y = 2
```
````

```julia; run;
x = 1;

y = 2
```

## Test 3 (Matrix)

**Render Test for block**:

````
```julia; block
randn(3,3)
```
````

```
randn(3,3)
```

```julia; block;
3×3 Array{Float64,2}:
  0.867347  -0.902914   0.532813
 -0.901744   0.864401  -0.271735
 -0.494479   2.21188    0.502334
```

**Render Test for repl**:

````
```julia; repl
randn(3,3)
```
````

```julia; repl;
julia> randn(3,3)
3×3 Array{Float64,2}:
  0.867347  -0.902914   0.532813
 -0.901744   0.864401  -0.271735
 -0.494479   2.21188    0.502334
```

**Render Test for run**:

````
```julia; run
randn(3,3)
```
````

```julia; run;
randn(3,3)
```

