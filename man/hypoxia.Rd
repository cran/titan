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
\author{
  Tom Price
  \email{tom@spirit.gcrc.upenn.edu}
}
\references{
  Elvidge, G., Price, T. S., Glenny, L. and Ragoussis, I.
  \emph{Development and evaluation of real-competitive PCR for high-throughput quantitative applications.}
  Anal Biochem. 2005;339(2):231-241.
}
\keyword{misc}
