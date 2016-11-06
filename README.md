INF3331 - Assignment 5 (syhd)
=============================

Testing the highlighter
-----------------------

I have written the syntax/theme files for 2 programming languages (python and
assembly) as well as for the output of the diff utility. To improve readability, 
I have designed the highlighter in such a way that it is possible to add some
comments here and there within the syntax or the theme files. These comments are 
always started with a hashtag (#) just like in bash or in python. Because of 
this, I thought that it may be a cool idea to add the colour support for the 
syntax files as well, such that we can read any syntax files with colours.

The `syntax` and the `theme` directory contain all the syntax and theme files
neccessary for testing. We will be using the highlighter on the test files that
are inside the `test` directory. Assuming that you are using bash, run the
following commands for testing:

```shell
python3 hl.py syntax/python theme/python test/test.py    # use on black/purple bg
python3 hl.py syntax/python theme/python2 test/test.py   # use on white bg
python3 hl.py syntax/assembly theme/assembly test/test.s # test assembly
python3 hl.py syntax/syntax theme/syntax syntax/python   # test on syntax file
```

Testing ```diff``` utility
--------------------------

```shell
python3 diff.py test/d1.txt test/d2.txt       # run diff on d1.txt and d2.txt
python3 hl.py syntax/diff theme/diff diff.log # view the diff output
```

My implementation of the standard ```diff``` utility is based heavily on the
LCS (longest common subsequence) algorithm. I have created 5 different test
cases, which are all contained inside the ```d1.txt``` and ```d2.txt``` files.
Down here are the desired/expected outputs which I have myself computed by
hands. These should later be compared to the actual output from the ```diff``` 
utility to see it everything works correctly.

```
|------------------------------|
| Output | Original | Modified |
|--------+----------+----------|
|  - A1  |    A1    |    B1    |
|  0 B1  |    B1    |    A1    |
|  + A1  |    C1    |    C1    |
|  0 C1  |          |          |
|--------+----------+----------|
|  - A2  |    A2    |    B2    |
|  + B2  |    C2    |    C2    |
|  0 C2  |    D2    |    B2    |
|  + B2  |    E2    |    D2    |
|  0 D2  |          |          |
|  - E2  |          |          |
|--------+----------+----------|
|  - A3  |    A3    |    F3    |
|  - B3  |    B3    |    G3    |
|  - C3  |    C3    |    H3    |
|  - D3  |    D3    |          |
|  - E3  |    E3    |          |
|  + F3  |          |          |
|  + G3  |          |          |
|  + H3  |          |          |
|--------+----------+----------|
|  - A4  |    A4    |    Z4    |
|  - Z4  |    Z4    |    C4    |
|  - B4  |    B4    |    D4    |
|  0 Z4  |    Z4    |    F4    |
|  0 C4  |    C4    |          |
|  0 D4  |    D4    |          |
|  - E4  |    E4    |          |
|  + F4  |          |          |
|--------+----------+----------|
|  + A5  |    Z5    |    A5    |
|  + Z5  |    C5    |    Z5    |
|  + B5  |    D5    |    B5    |
|  0 Z5  |    F5    |    Z5    |
|  0 C5  |          |    C5    |
|  0 D5  |          |    D5    |
|  - F5  |          |    E5    |
|  + E5  |          |          |
|------------------------------|
```