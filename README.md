# Melodic Discrimination Test (MDT) - v1.0.1

R implementation of the adaptive Melodic Discrimination Test of Harrison, Collins, and Mullensiefen (2017).

This test is detailed in the following paper: Harrison, P. M. C., Collins, T., & Müllensiefen, D. (2017). 
Applying modern psychometric techniques to melodic discrimination testing: 
Item response theory, computerised adaptive testing, and automatic item generation. 
Scientific Reports, 7, 1–18. https://doi.org/10.1038/s41598-017-03586-z.

The implementation depends on a yet-to-be-released package, psychTestR. 
We hope to release psychTestR in the coming months.
In the meanwhile, if you would like to use the MDT for research purposes, 
please contact Peter at p.m.c.harrison@qmul.ac.uk.

This implementation can be cited using the following permanent link:
https://doi.org/10.5281/zenodo.1300951 

## Example description for paper

If you use the test in your own research, you could use the following
paragraphs as a template for describing the test in your subsequent write-up.

> We tested melodic working memory using the melodic discrimination test of Harrison, Collins, and Mullensiefen (2017). This test uses a three-alternative forced-choice (3-AFC) paradigm.  In each trial, the participant is played three versions of a new and unfamiliar melody, with successive versions being transposed a semitone higher in pitch. In one of these versions, a note has been altered, making that version the 'odd one out'. The participant's task is to identify which melody was the odd one out. The melodic discrimination task is argued to rely heavily on auditory working memory, as melodies must be held in working memory if they are to be compared and discriminated (Dowling, 1978; Harrison & Mullensiefen, 2016; Harrison et al., 2017). 

> We used an implementation of the melodic discrimination test provided by the original researchers and available at https://doi.org/10.5281/zenodo.1300951. Participants complete the test at a computer, using a mouse to select responses. The test uses an adaptive item selection procedure, administering harder items to higher-ability participants and easier items to lower-ability participants. Participant abilities are estimated using Item Response Theory (de Ayala, 2009). We used the test with default settings: length of 20 items, computing intermediate and final abilities with weighted-likelihood estimation, and using Urry's rule for item selection.

### References:

de Ayala, R. J. (2009). The theory and practice of item response theory. New York, NY: The Guilford Press.

Dowling, W. J. (1978). Scale and contour: Two components of a theory of memory for melodies. Psychological Review, 85(4), 341–354.

Harrison, P. M. C., Musil, J. J., & Müllensiefen, D. (2016). Modelling melodic discrimination tests: Descriptive and explanatory approaches. Journal of New Music Research, 45(3), 265–280. https://doi.org/10.1080/09298215.2016.1197953

Harrison, P. M. C., Collins, T., & Müllensiefen, D. (2017). Applying modern psychometric techniques to melodic discrimination testing: Item response theory, computerised adaptive testing, and automatic item generation. Scientific Reports, 7, 1–18. https://doi.org/10.1038/s41598-017-03586-z

Magis, D., & Gilles, R. (2012). Random generation of response patterns under computerized adaptive testing with the R package catR. Journal of Statistical Software, 48(8), 1–31.
