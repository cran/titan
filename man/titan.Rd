\name{titan}
\alias{titan}
\title{Titration Analysis}
\description{
  GUI to analyze mass spectrometric data on the relative abundance of two substances from a titration series.
  }
\usage{
titan(
    data =       NULL,
    trace =      TRUE,
    widget =     TRUE,
    dataFile =   "",
    outFile =    "",
    pdfFile =    "",
    flagRaw =    FALSE,
    flagFitted = FALSE,
    freqLo =     .05,
    freqHi =     .95,
    reg =        "least.squares",
    term =       "linear",
    sel =        "wald",
    alpha =      .05,
    rx0 =        NULL,
    rx1 =        NULL,
    gene0 =      NULL,
    gene1 =      NULL,
    R =          1000,
    seed =       0,
    ciConf =     .95,
    ciType =     "all"
)
}
\arguments{
  \item{data}{A data frame containing the factors \code{gene} and \code{treatment} (or \code{rx}),
    the numeric vectors \code{frequency} and \code{competitor} (or \code{concentration}),
    and the numeric vector \code{flag} taking binary values. \code{gene} and \code{treatment}
    specify the sample, and \code{competitor} the concentration of the competitor.
    \code{flag} takes the value 0 for data points that are to be used in the analysis, and 1 for
    data points that are to be ignored. If this parameter is set to \code{NULL},
    the user must supply the address of a data file containing this information:
    see \code{dataFile} below.
  }
  \item{trace}{
    A logical scalar. If \code{TRUE}, the output is printed as the function proceeds.
  }
  \item{widget}{
    A logical scalar. If \code{TRUE}, the GUI is used to specify the data and set parameters for the
    analysis. Otherwise, the following arguments must be supplied:
  }
  \item{dataFile}{
    A character string specifying the location of the input data file. The file should be a
    tab-delimited text file with column headings containing the fields specified for the \code{data} parameter
    above.
  }
  \item{pdfFile}{
    A character string specifying the location in which to save the output pdf file. If set to
    a null string, the output is printed on the default device.
  }
  \item{outFile}{
    A character string specifying the location in which to save the output text file. If set to
    a null string, the output is printed on the default device.
  }
  \item{freqLo}{
    A numeric value between 0 and 1 specifying the lower bound for cDNA frequency.
  }
  \item{freqHi}{
    A numeric value between 0 and 1 specifying the higher bound for cDNA frequency.
  }
  \item{flagRaw}{
    A logical value. If TRUE, flag raw cDNA frequency values outside the range specified by
    \code{freqLo} and \code{freqHi}.
  }
  \item{flagFitted}{
    A logical value. If TRUE, flag fitted cDNA frequency values outside the range specified by
    \code{freqLo} and \code{freqHi}.
  }
  \item{reg}{
    A character string specifying the type of regression to be used: \code{"least.squares"},
    \code{"robust"}, or \code{"spline"} for least squares, robust, or natural spline regressions, respectively.
  }
  \item{term}{
    A character string specifying the terms to be entered into the regression. Least squares and
    robust regressions may take the values \code{"linear"}, \code{"quadratic"} or \code{"parallel.linear"}.
    \code{"linear"} fits a regression with a linear term and intercept for each combination of gene and
    treatment condition. \code{"quadratic"} also fits quadratic terms. \code{"parallel.linear"} estimates
    only one linear term per gene, with intercepts for each combination of gene and treatment.
    Natural spline regressions specify the number of degrees of freedom in the regression as either a
    numeric or character vector.
  }
  \item{sel}{
    A character string identifying the selection method for terms in the regression. For least squares regressions,
    the two options are \code{"wald"}, indicating backwards selection by the Wald test, or \code{"aic"},
    signifying stepwise selection by AIC. Robust regressions use only backwards selection by the Wald test.
    Natural spline regressions use only stepwise selection by AIC.
  }
  \item{alpha}{
    A numeric scalar containing the value of alpha (maximum p-value) for selection by the Wald test.
  }
  \item{rx0}{
    A character string specifying the name of the baseline level of the factor \code{treatment}, against which
    other treatments are compared when calculating fold changes. If NULL, the first level of \code{treatment}
    is taken as the baseline condition.
  }
  \item{rx1}{
    A character vector containing the names of the levels of the factor \code{treatment}
    that are entered into the analysis as test conditions when calculating fold changes.
    If NULL, it is assumed that all the treatments other than that specified in \code{rx0}
    are test conditions.
  }
  \item{gene0}{
    A character vector containing the names of the 'housekeeping' or control genes
    in the factor \code{gene}.
    If NULL, it is assumed that none of the genes are housekeeping genes.
  }
  \item{gene1}{
    A character vector containing the names of the test genes in the factor \code{gene}.
    If NULL, it is assumed that all the genes other than those specified in \code{gene0}
    are test genes.
  }
  \item{R}{
    A numeric scalar specifying the umber of bootstrap replicates to be performed.
    If zero, no bootstrap analysis is performed.
  }
  \item{seed}{
    A numeric scalar containing the seed for the random number generator used in the bootstrap.
    If NULL, a random seed is supplied.
  }
  \item{ciConf}{
    A scalar or vector containing the confidence level(s) of the required bootstrap interval(s).
  }
  \item{ciType}{
    A vector of character strings representing the type of intervals
    required. The value should be any subset of the values
    \code{c("norm","basic", "perc", "bca")} or simply \code{"all"}
    which will compute all four types of intervals.
  }
}
\details{
  Further details are available from the references below.
}
\value{
  An object of class \code{"titan"} containing the output.
  it has components
  \item{data}{
    A data frame containing the data as input to the function, including \code{flag}
    which contains the actual data flags used in the analysis.
  }
  \item{opt}{
    A list of arguments supplied to the function, either directly or using the GUI.
  }
  \item{reg}{
    An object of class \code{lm} or \code{rlm}, the output from the regression.
  }
  \item{interpolation}{
    A list containing a matrix \code{roots} containing the interpolated values for each
    combination of gene and treatment, i.e. the equivalence points.
    If there is more than one treatment, the list contains a further matrix
    \code{log10fold} containing the base 10 logarithms of the fold changes,
    calculated relative to the baseline treatment, and adjusted for the fold changes
    for the housekeeping or control genes.
  }
  \item{boot}{
    An object of class \code{boot}, the output from the bootstrap.
  }
  \item{bootci}{
    An object of class \code{titanbootci} containing the boostrap confidence intervals.
  }
}
\examples{
data(hypoxia)

# Analyze titration series using GUI (code not run):
#
# t1 <- titan(data = hypoxia, R=0)

# Perform an identical reanalysis without using GUI:
#
# first get previous options
#
opt <- list(data = hypoxia, R=0)
#
# adjust the options so that
# no further data points are flagged
#
opt$flagRaw <- FALSE
opt$flagFitted <- FALSE
#
# turn off GUI
#
opt$widget <- FALSE
#
# call function
t2 <- do.call( "titan", opt )

# Reanalyze data with different parameters:
#
opt$reg <- "robust"
opt$sel <- "wald"
t3 <- do.call( "titan", opt )
}
\author{
  Tom Price
  \email{tom@spirit.gcrc.upenn.edu}
}
\references{
  Elvidge, G., Price, T. S., Glenny, L. and Ragoussis, I.
  \emph{Development and evaluation of real-competitive PCR for high-throughput quantitative applications.}
  Anal Biochem. 2005;339(2):231-241.

  \url{http://www.tomprice.net/titan/userguide.pdf}
}
\keyword{misc}
