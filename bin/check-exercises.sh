#!/usr/bin/env sh

set -e

for exercise in *; do
    if [ -d "$exercise" ]; then
        if [ -f "$exercise/$exercise"-test.rkt ]; then
            if [ -f "$exercise/$exercise".rkt ]; then
                mv "$exercise/$exercise".rkt "$exercise/$exercise".rkt_
            fi
            mv "$exercise"/example.rkt "$exercise/$exercise".rkt
        fi
    fi
done
raco test -x --jobs 5 -Q --table .
SUCCESS=$?
for exercise in *; do
    if [ -f "$exercise/$exercise".rkt_ ]; then
        mv "$exercise/$exercise".rkt "$exercise"/example.rkt
        mv "$exercise/$exercise".rkt_ "$exercise/$exercise".rkt
    fi
done
if [ $SUCCESS -ne 0 ]; then
    exit $SUCCESS
fi
