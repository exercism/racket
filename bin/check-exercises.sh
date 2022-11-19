#!/usr/bin/env sh

set -e

cd exercises/practice

for exercise in *; do
    if [ -d "$exercise" ]; then
        if [ -f "$exercise/$exercise"-test.rkt ]; then
            if [ -f "$exercise/$exercise".rkt ]; then
                mv "$exercise/$exercise".rkt "$exercise/$exercise".rkt_
            else
                echo "$exercise needs a stub!"
            fi
            mv "$exercise"/.meta/example.rkt "$exercise/$exercise".rkt
        fi
    fi
done

raco test -x --jobs 5 -Q --table .
SUCCESS=$?

for exercise in *; do
    if [ -d "$exercise" ]; then
	if [ -f "$exercise/$exercise"-test.rkt ]; then
	    mv "$exercise/$exercise".rkt "$exercise"/.meta/example.rkt
	    if [ -f "$exercise/$exercise".rkt_ ]; then
		mv "$exercise/$exercise".rkt_ "$exercise/$exercise".rkt
	    fi
	fi
    fi
done

if [ $SUCCESS -ne 0 ]; then
    exit $SUCCESS
fi
