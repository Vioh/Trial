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

# | Output | Original | Modified |\n
# |--------+---------------------|\n
# |  - A1  |        |        |\n
# |  0 B1  |        |        |\n
# |  + A1  |        |        |\n
# |  0 C1  |        |        |\n
   |        |        |
   |        |        |
   |        |        |
   |        |        |
   |        |        |
   |        |        |
   |        |        |
   |        |        |
   |        |        |
   |        |        |
   |        |        |
