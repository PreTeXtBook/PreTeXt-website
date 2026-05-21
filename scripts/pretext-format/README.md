# PreTeXt Source Formatter

Pretty-prints PreTeXt XML source.  Used in the website build to
format the source of the sample article and sample book before
producing the annotated ("View Source") HTML versions.

### `update-format`
`bash` script to (re-)install the formatter via `npm`.

### `package.json`
Manages the dependency on `@pretextbook/format`.

The CLI binary appears at `node_modules/.bin/pretext-format`
after a successful install.
