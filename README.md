# Paper Surveys
A GNU/Octave tool to digitize paper surveys.

## Purpose and scope of use
The purpose of this project is to have a tool to digitize (aka digitalize)
surveys in paper format, transforming them into a CSV file.  The expected
format for the survey is the following type of questionaire.

 Questions | Answers
-----------|---------
 Question1 | 1 2 ~~3~~ 4
 Question2 | 1 ~~2~~ 3 4


Disclaimer: methods such as digit recognition, OCR or artificial intelligence
are not used in this project (so far).


## How does it works
The idea behind the digitalization algorithm is rather simple. Basically, the
script will be provided regions where the numbered answers are placed. Then it
will measure the amount of ink in every region, taking as the marked answer the
region that contains the most ink in the row.

Of course, the algorithm has been optimized to avoid false positives, as well
as to avoid false negatives, even when two or more answers are marked for a
single question.


## How to use it
1. First, you need to get and install GNU/Octave. The signal package is used
   within this project.
2. Then, you have to add the centers of every region in `get_centers.m`. This
   file works on a x/y-axis basis.
3. When everything is set up, you can run `surveys.m` from GNU/Octave. You may
   need to adjust the first lines (custom variables) before running it.

You're all set! You should now have a beautiful CSV file with the answers of
your survey.


## Performance
The script takes a while to run, that's true... I guess image processing is
always kind of heavy stuff. Apart from this, the script performs pretty well
(as far as I've measured). First results suggest a precission over 95% with
scanned paper questinaires.


## Contributing
I started this project becausge I didn't know any specific tool to perform this
task in the Open Source community. This project is Free Software (see
`LICENSE`) and you're very welcome to make contributions (enhancing the
documentation, usability, the algorithm itself, asking for new features...
whatever!).

