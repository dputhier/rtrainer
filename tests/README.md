# Tutorial Testing Framework

This directory contains scripts and tools for testing all tutorials in the rtrainer package.

## Quick Start

### Test all tutorials
```bash
make test_tutorials
```

### Test a specific tutorial by name
```bash
make test_tutorial TUTORIAL=02_vectors
```

### Test a specific tutorial by number
```bash
make test_tutorial TUTORIAL=2
```

### List all available tutorials
```bash
make list_tutorials
```

## Manual Usage

If you prefer to run the scripts directly:

### Test all tutorials
```bash
Rscript tests/test_all_tutorials.R
```

### Test a single tutorial
```bash
Rscript tests/test_single_tutorial.R 02_vectors
# or by number
Rscript tests/test_single_tutorial.R 2
```

### List available tutorials
```bash
Rscript tests/list_tutorials.R
```

## What Gets Tested

The testing framework uses the `check_tuto()` function to:

1. Extract all R code chunks from each tutorial `.Rmd` file
2. Filter out:
   - Chunks with `eval=FALSE`
   - Solution chunks (these are tested via their exercise chunks)
   - Check chunks (gradethis validation chunks)
   - CSS/HTML/non-R code chunks
3. Execute the remaining chunks in sequence
4. Report any errors encountered

## Exit Codes

- `0`: All tests passed
- `1`: One or more tests failed

## CI/CD Integration

To integrate with continuous integration:

```yaml
# Example for GitHub Actions
- name: Test tutorials
  run: make test_tutorials
```

## Adding to R CMD check

The tests are designed to work with the package structure. To run during `R CMD check`, the package must be installed first, which happens automatically with the `make check` target.

## Troubleshooting

If a tutorial fails:

1. Run it individually to see the full error:
   ```bash
   make test_tutorial TUTORIAL=<name>
   ```

2. The error will show which code chunk failed and why

3. Common issues:
   - Missing package dependencies
   - Code that depends on external files or data not included
   - Code that requires interactive input
   - Exercises without proper setup chunks

## Implementation Details

- **test_all_tutorials.R**: Orchestrates testing of all tutorials, provides summary report
- **test_single_tutorial.R**: Tests one tutorial with detailed output
- **list_tutorials.R**: Lists all available tutorials with their numbers
- **check_tuto()**: Core function in `R/check_tuto.R` that validates tutorial code
