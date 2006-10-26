\name{hypoxia}
\alias{hypoxia}
\title{Gene Expression Under Hypoxia/Normoxia}
\description{
  Gene expression of MCF7 cells under conditions of hypoxia and normoxia.
  }
\usage{
data(hypoxia)
}
\format{
  A data frame with 1009 observations on 5 variables.
  \describe{
    \item{\code{freq}}{cDNA frequency (numeric, 0-1)}
    \item{\code{gene}}{Gene (factor)}
    \item{\code{rx}}{Treatment condition (factor)}
    \item{\code{comp.conc}}{Concentration of competitor (numeric, M)}
    \item{\code{flag}}{Exclude data point (numeric, 0 or 1)}
  }
}
\details{
  Further details are available from the reference below.
}
\examples{
data(hypoxia)

# Analyze titration series using GUI (code not run):
#
# t1 <- titan(data = hypoxia)

# Perform an identical reanalysis without using GUI:
#
# first get previous options
#
opt <- list(data = hypoxia)
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
  Manuscript submitted for pulication.
}
\keyword{misc}