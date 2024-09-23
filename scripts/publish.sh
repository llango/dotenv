#!/bin/bash

# ignore errors because we want to ignore duplicate packages
for file in output/**/*.conda; do
    magic run rattler-build upload prefix -c "mojo-force" "$file" || true
done
