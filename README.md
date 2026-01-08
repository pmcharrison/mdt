# Melodic Discrimination Test (MDT) 

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.1300950.svg)](https://doi.org/10.5281/zenodo.1300950)

The MDT is an adaptive test of the ability to discriminate melodies.

We invite you to try the test [here](https://shiny.gold-msi.org/longgold_demo/) and
to read the paper [here](https://doi.org/10.1038/s41598-017-03586-z).

Want to use this test in your own online study, but don't want to go to the trouble of setting up your own 
web server? You are invited to host your study on the DOTS testing server of the 
[German Society for Music Psychology (DGM)](https://musikpsychologie.de/en).
This service is free of charge, but requires a current membership of the GDM, which currently (as of January 2026)
costs 60 euros per year (25 euros for students and the unemployed).
For more information please contact Klaus Frieler (kgf@omniversum.de).


## Citation

When using the MDT in your own research, you can cite the original MDT research paper:

> Harrison, P. M. C., Collins, T., & Müllensiefen, D. (2017). 
Applying modern psychometric techniques to melodic discrimination testing: 
Item response theory, computerised adaptive testing, and automatic item generation. 
Scientific Reports, 7, 1–18. https://doi.org/10.1038/s41598-017-03586-z.

and this implementation:

> Harrison, P. M. C., & Müllensiefen, D. (2018). 
Melodic Discrimination Test (MDT), psychTestR implementation. Zenodo.
https://doi.org/10.5281/zenodo.1300950

We also advise mentioning the software versions you used,
in particular the versions of the `mdt`, `psychTestR`, and `psychTestRCAT` packages.
You can find these version numbers from R by running the following commands:

``` r
library(mdt)
library(psychTestR)
library(psychTestRCAT)
if (!require(devtools)) install.packages("devtools")
x <- devtools::session_info()
x$packages[x$packages$package %in% c("mdt", "psychTestR", "psychTestRCAT"), ]
```

## Acknowledgements

We are grateful to the following individuals for translating the MDT
into new languages:

- Pauline Larrouy-Maestri (French)
- Dania Hollemann, Klaus Frieler, Daniel Müllensiefen (German)
- Elina Tsigeman and Maxim Likhanov (Russian)
- Elvira Brattico (Italian)

## Installation instructions (local use)

1. If you don't have R installed, install it from here: https://cloud.r-project.org/

2. Open R.

3. Install the ‘devtools’ package with the following command:

`install.packages('devtools')`

4. Install the melody discrimination test:

`devtools::install_github('pmcharrison/mdt')`

5. Tell Shiny to use your computer's default browser, instead of the RStudio browser,
   which doensn't play well with this test.
   First, open your .Rprofile file:

```r
install.packages("usethis")
usethis::edit_r_profile()
```

   Add the following lines:

```r
options(shiny.launch.browser = .rs.invokeShinyWindowExternal)
```

  Save the file, then restart your R session (in the RStudio toolbar, click Session then Restart R).

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

The MDT currently supports English (EN), French (FR),
Russian (RU), Italian (IT), Latvian (LV),
and German (both informal and formal).
If you would like to add a new language to this list, please contact us.
You can select one of these languages by passing a language code as 
an argument to `standalone_mdt()`, e.g. `standalone_mdt(languages = "DE")`,
or alternatively by passing it as a URL parameter to the test browser,
eg. http://127.0.0.1:4412/?language=DE (note that the `p_id` argument must be empty).
Please note that the demo version of the test (`demo_mdt`) only supports English.

### Results

The main output from the MDT is an `ability` score,
corresponding to the ability estimate for the participant.
It is computed from the underlying item response model and ranges approximately from -4 to +4.
A secondary output is an `ability_sem` score, 
corresponding to the standard error of measurement for the ability estimate;
again, it is computed from the underlying IRT model.
For most applications you would only use the `ability` value,
unless using a statistical analysis technique that allows you to specify measurement error explicitly.
For more information about item response theory, see the [Wikipedia](https://en.wikipedia.org/wiki/Item_response_theory) article;
for more information about MDT scores, see
[Harrison et al. (2017)](https://doi.org/10.1038/s41598-017-03586-z).

psychTestR provides several ways of retrieving test results (see http://psychtestr.com/).
Most are accessed through the test's admin panel.

* If you are just interested in the participants' final scores,
the easiest solution is usually to download the results in CSV format from the admin panel.
* If you are interested in trial-by-trial results, you can run the command
`compile_trial_by_trial_results()` from the R console
(having loaded the MDT package using `library(mdt)`).
Type `?compile_trial_by_trial_results()` for more details.
* If you want still more detail, you can examine the individual RDS output files using `readRDS()`. 
Detailed results are stored as the 'metadata' attribute for the ability field. 
You can access it something like this: 

``` r
x <- readRDS("output/results/id=1&p_id=german_test&save_id=1&pilot=false&complete=true.rds")
attr(x$MDT$ability, "metadata")
```

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

Versions <= 1.3.0 of this package experimented with weighted likelihood
ability estimation for item selection.
However, current versions of the package revert to Bayes modal
ability estimation for item selection,
for consistency with the original MDT paper.

## Example description for paper

If you use the test in your own research, you could use the following
paragraphs as a template for describing the test in your subsequent write-up.

> We tested melodic working memory using the melodic discrimination test of Harrison, Collins, and Müllensiefen (2017). This test uses a three-alternative forced-choice (3-AFC) paradigm.  In each trial, the participant is played three versions of a new and unfamiliar melody, with successive versions being transposed a semitone higher in pitch. In one of these versions, a note has been altered, making that version the 'odd one out'. The participant's task is to identify which melody was the odd one out. The melodic discrimination task is argued to rely heavily on auditory working memory, as melodies must be held in working memory if they are to be compared and discriminated (Dowling, 1978; Harrison & Mülllensiefen, 2016; Harrison et al., 2017). 

> We used an implementation of the melodic discrimination test provided by the original researchers and available at https://doi.org/10.5281/zenodo.1300951. Participants complete the test at a computer, using a mouse to select responses. The test uses an adaptive item selection procedure, administering harder items to higher-ability participants and easier items to lower-ability participants. Participant abilities are estimated using Item Response Theory (de Ayala, 2009). We used the test with default settings: length of 20 items, computing intermediate and final abilities with weighted-likelihood estimation, and using Urry's rule for item selection
(Magis & Gilles, 2012).

## Adding new languages

See `data-raw/dict-russian.csv` for an example of a foreign-language dictionary.
Create a new dictionary for your new language following this format.
Prepare a merge request for submitting your changes, 
perhaps using a fork of the original repository.
Place the file in `data-raw`.
Update `data-raw/mdt-dict.R`, adding a new four-line section for your new language,
following the lines used to add previous languages.
Run the file and commit the changes to Git.
Update the `mdt_languages` function in `languages.R` to include the new language.
Update the languages section in `README.md` to credit the translator.
Rebuild the R package locally and test that you can use the test with
your new translations.
Submit your changes as a merge request.


## References:

de Ayala, R. J. (2009). The theory and practice of item response theory. New York, NY: The Guilford Press.

Dowling, W. J. (1978). Scale and contour: Two components of a theory of memory for melodies. Psychological Review, 85(4), 341–354.

Harrison, P. M. C., Musil, J. J., & Müllensiefen, D. (2016). Modelling melodic discrimination tests: Descriptive and explanatory approaches. Journal of New Music Research, 45(3), 265–280. https://doi.org/10.1080/09298215.2016.1197953

Harrison, P. M. C., Collins, T., & Müllensiefen, D. (2017). Applying modern psychometric techniques to melodic discrimination testing: Item response theory, computerised adaptive testing, and automatic item generation. Scientific Reports, 7, 1–18. https://doi.org/10.1038/s41598-017-03586-z

Magis, D., & Gilles, R. (2012). Random generation of response patterns under computerized adaptive testing with the R package catR. Journal of Statistical Software, 48(8), 1–31.
