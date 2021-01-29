# Two Fer

`Two-fer` or `2-fer` is short for two for one. One for you and one for me.

Given a name, return a string with the message:

```text
One for X, one for me.
```

Where X is the given name.

However, if the name is missing, return the string:

```text
One for you, one for me.
```

Here are some examples:

|Name    | String to return 
|:------:|:-----------------: 
|Alice   | One for Alice, one for me. 
|Bob     | One for Bob, one for me.
|        | One for you, one for me.
|Zaphod  | One for Zaphod, one for me.

* * * *

For installation and learning resources, refer to the
[exercism Racket page](http://exercism.io/languages/racket).

You can run the provided tests through DrRacket, or via the command line.

To run the test through DrRacket, simply open the test file and click the 'Run' button in the upper right.

To run the test from the command line, run the test from the exercise directory with the following command:

```
raco test two-fer-test.rkt
```

which will display the following:

```
raco test: (submod "two-fer-test.rkt" test)
2 success(es) 0 failure(s) 0 error(s) 2 test(s) run
0
2 tests passed
```

## Source

[https://github.com/exercism/problem-specifications/issues/757](https://github.com/exercism/problem-specifications/issues/757)

## Submitting Incomplete Solutions
It's possible to submit an incomplete solution so you can see how others have completed the exercise.
