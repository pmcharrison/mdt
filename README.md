# Melodic Discrimination Test (MDT) 

Try the MDT here! http://shiny.pmcharrison.com/mdt-demo

This test is detailed in the following paper: Harrison, P. M. C., Collins, T., & Müllensiefen, D. (2017). 
Applying modern psychometric techniques to melodic discrimination testing: 
Item response theory, computerised adaptive testing, and automatic item generation. 
Scientific Reports, 7, 1–18. https://doi.org/10.1038/s41598-017-03586-z.

This implementation can be cited using the following permanent link:
https://doi.org/10.5281/zenodo.1300950

The demo version of the MDT  (http://shiny.pmcharrison.com/mdt-demo)
gives you feedback after each question,
but in real experiments this feedback is disabled.
For using the test in your own studies, we recommend local installation (see below).

## Installation instructions (local use)

1. If you don't have R installed, install it from here: https://cloud.r-project.org/

2. Open R.

3. Install the ‘devtools’ package with the following command:

`install.packages('devtools')`

4. Install the melody discrimination test:

`devtools::install_github('pmcharrison/mdt')`

## Usage

### Quick demo 

You can demo the melodic discrimination test at the R console, as follows:

``` r
# Load the mdt package
library(mdt)

# Run a demo test, with feedback as you progress through the test,
# and not saving your data
demo_mdt()

# Run a demo test, skipping the training phase, and only asking 5 questions
demo_mdt(num_items = 5, take_training = FALSE)
```

### Testing a participant

The `standalone_mdt()` function is designed for real data collection.
In particular, the participant doesn't receive feedback during this version.

``` r
# Load the mdt package
library(mdt)

# Run the test as if for a participant, using default settings,
# saving data, and with a custom admin password
standalone_mdt(admin_password = "put-your-password-here")
```

You will need to enter a participant ID for each participant.
This will be stored along with their results.

Each time you test a new participant,
rerun the `standalone_mdt()` function,
and a new participation session will begin.

You can retrieve your data by starting up a participation session,
entering the admin panel using your admin password,
and downloading your data.
For more details on the psychTestR interface, 
see http://psychtestr.com/.

## Installation instructions (Shiny Server)

1. Complete the installation instructions described under 'Local use'.
2. If not already installed, install Shiny Server Open Source:
https://www.rstudio.com/products/shiny/download-server/
3. Navigate to the Shiny Server app directory.

`cd /srv/shiny-server`

4. Make a folder to contain your new Shiny app.
The name of this folder will correspond to the URL.

`sudo mkdir mdt`

5. Make a text file in this folder called `app.R`
specifying the R code to run the app.

- To open the text editor: `sudo nano mdt/app.R`
- Write the following in the text file:

``` r
library(mdt)
standalone_mdt(admin_password = "put-your-password-here")
```

- Save the file (CTRL-O).

6. Change the permissions of your app directory so that `psychTestR`
can write its temporary files there.

`sudo chown -R shiny mdt`

where `shiny` is the username for the Shiny process user
(this is the usual default).

7. Navigate to your new shiny app, with a URL that looks like this:
http://my-web-page.org:3838/mdt

## Usage notes

- The MDT runs in your web browser.
- By default, audio files are hosted online on our servers.
The test therefore requires internet connectivity.

## Implementation notes

By default, the MDT implementation always estimates participant abilities
using weighted-likelihood estimation.
This differs from our validation study, 
where online abilities were scored using Bayes modal estimation.
We adopt weighted-likelihood estimation for this release 
because this technique makes fewer assumptions about the participant group being tested.
This makes the test better suited to testing with diverse participant groups
(e.g. children, clinical populations).

## Example description for paper

If you use the test in your own research, you could use the following
paragraphs as a template for describing the test in your subsequent write-up.

> We tested melodic working memory using the melodic discrimination test of Harrison, Collins, and Müllensiefen (2017). This test uses a three-alternative forced-choice (3-AFC) paradigm.  In each trial, the participant is played three versions of a new and unfamiliar melody, with successive versions being transposed a semitone higher in pitch. In one of these versions, a note has been altered, making that version the 'odd one out'. The participant's task is to identify which melody was the odd one out. The melodic discrimination task is argued to rely heavily on auditory working memory, as melodies must be held in working memory if they are to be compared and discriminated (Dowling, 1978; Harrison & Mülllensiefen, 2016; Harrison et al., 2017). 

> We used an implementation of the melodic discrimination test provided by the original researchers and available at https://doi.org/10.5281/zenodo.1300951. Participants complete the test at a computer, using a mouse to select responses. The test uses an adaptive item selection procedure, administering harder items to higher-ability participants and easier items to lower-ability participants. Participant abilities are estimated using Item Response Theory (de Ayala, 2009). We used the test with default settings: length of 20 items, computing intermediate and final abilities with weighted-likelihood estimation, and using Urry's rule for item selection
(Magis & Gilles, 2012).

## References:

de Ayala, R. J. (2009). The theory and practice of item response theory. New York, NY: The Guilford Press.

Dowling, W. J. (1978). Scale and contour: Two components of a theory of memory for melodies. Psychological Review, 85(4), 341–354.

Harrison, P. M. C., Musil, J. J., & Müllensiefen, D. (2016). Modelling melodic discrimination tests: Descriptive and explanatory approaches. Journal of New Music Research, 45(3), 265–280. https://doi.org/10.1080/09298215.2016.1197953

Harrison, P. M. C., Collins, T., & Müllensiefen, D. (2017). Applying modern psychometric techniques to melodic discrimination testing: Item response theory, computerised adaptive testing, and automatic item generation. Scientific Reports, 7, 1–18. https://doi.org/10.1038/s41598-017-03586-z

Magis, D., & Gilles, R. (2012). Random generation of response patterns under computerized adaptive testing with the R package catR. Journal of Statistical Software, 48(8), 1–31.
