#!/usr/bin/env sh

for exercise in *; do
    if [ -d "$exercise" ]; then
        cd "$exercise" || exit
        if [ -f "$exercise"-test.rkt ]; then
            echo Testing "$exercise"...
            if [ -f "$exercise".rkt ]; then
                mv "$exercise".rkt "$exercise".rkt_
            fi
            mv example.rkt "$exercise".rkt
            racket "$exercise"-test.rkt
            SUCCESS=$?
            mv "$exercise".rkt example.rkt
            if [ -f "$exercise".rkt_ ]; then
                mv "$exercise".rkt_ "$exercise".rkt
            fi
            if [ $SUCCESS -ne 0 ]; then
                exit $SUCCESS
            fi
        fi
        cd ..
    fi
done
