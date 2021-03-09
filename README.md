
# Word Frequency Toytools
Code to generate/annotate/handle lists of frequency from corpora.

## Normalize Word Frequency [v0.1.5](https://github.com/franfranz/Word_Frequency_Toytools/blob/main/Normalize_word_frequency_v0_1_5.R)
R code to normalize raw frequency counts into fpmw, fpbw, zipf, zipf per billion and other popular measures to indicate word frequency. 
To use Normalize Word Frequency :

Prepare your input file:
- make sure your txt or csv input files have a header: the column with raw frequency you want to normalize must be called "Frequency" 

Set input specifications in the code:
- set the paths for input and output files (line 28-30)
- set the file extension (36)
- set the file separators (48)
- set size of corpus (70) - this version reports the size of Itwac.

Set output specifications in the code:
- choose what transformations to apply by commenting/ uncommenting (56-65)


## Normalize Word Frequency v0.1.4
This version has been deprecated.
