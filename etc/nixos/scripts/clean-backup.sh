#!/bin/bash

echo "Deleting ol' backup files..."
find "$HOME" -type f -name '*.backup' -delete
