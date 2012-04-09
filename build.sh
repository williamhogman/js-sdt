#!/bin/bash

#
# Build script for js-sdt
# 

mkdir "dist"

echo "Building js-sdt"

type coffee >/dev/null 2>&1 || {
    echo "Missing CoffeeScript, halting"
    exit 1
}

echo "Compiling"
coffee -o dist -c sdt.coffee 

coffee_exit=$?

if [[ $coffee_exit != 0 ]] ; then
    echo "Compilation failed"
    exit 1
else
    echo "Compilation successful"
fi

type yuicompressor >/dev/null 2>&1 && {
    echo "Compressing using yuicompressor"
    yuicompressor -o dist/sdt.min.js dist/sdt.js
}

cp vendor/jstat* dist/
cp vendor/jquery.flot* dist/

echo "Done!"
