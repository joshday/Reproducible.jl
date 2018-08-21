# Reproducible

A lightweight package for reproducible reports.

- Triple-quoted strings get inserted directly into the markdown doc.
- Code inside `@code` blocks gets evaluated and inserted into the markdown doc.
- `include`-ing a script inserts that file in place.
- Everything else is ignored.