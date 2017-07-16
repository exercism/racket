# Allergies

Given a person's allergy score, determine whether or not they're allergic to a given item, and their full list of allergies.

An allergy test produces a single numeric score which contains the
information about all the allergies the person has (that they were
tested for).

The list of items (and their value) that were tested are:

* eggs (1)
* peanuts (2)
* shellfish (4)
* strawberries (8)
* tomatoes (16)
* chocolate (32)
* pollen (64)
* cats (128)

So if Tom is allergic to peanuts and chocolate, he gets a score of 34.

Now, given just that score of 34, your program should be able to say:

- Whether Tom is allergic to any one of those allergens listed above.
- All the allergens Tom is allergic to.

Note: a given score may include allergens **not** listed above (i.e.
allergens that score 256, 512, 1024, etc.).  Your program should
ignore those components of the score.  For example, if the allergy
score is 257, your program should only report the eggs (1) allergy.


* * * *

For installation and learning resources, refer to the
[exercism Racket page](http://exercism.io/languages/racket).

You can run the provided tests through DrRacket, or via the command line.

To run the test through DrRacket, simply open the test file and click the 'Run' button in the upper right.

To run the test from the command line, simply run the test from the exercise directory. For example, if the test suite is called `hello-world-test.rkt`, you can run the following command:

```
raco test hello-world-test.rkt
```

which will display the following:

```
raco test: (submod "hello-world-test.rkt" test)
2 success(es) 0 failure(s) 0 error(s) 2 test(s) run
0
2 tests passed
```

## Source

Jumpstart Lab Warm-up [http://jumpstartlab.com](http://jumpstartlab.com)

## Submitting Incomplete Solutions
It's possible to submit an incomplete solution so you can see how others have completed the exercise.
