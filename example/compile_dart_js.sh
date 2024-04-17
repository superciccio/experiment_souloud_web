#!/bin/bash

DIR="web"

for file in "$DIR"/*_js.dart; do
    dart compile js -o "%%F.js" "$file"
done
