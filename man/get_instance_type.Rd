% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/solvers.R
\name{get_instance_type}
\alias{get_instance_type}
\title{Check the type and the validity of an MWCS instance}
\usage{
get_instance_type(instance)
}
\arguments{
\item{instance}{`igraph` object, containing an instance to be checked}
}
\value{
a list with members `type` containing the type of the instance,
`valid` -- boolean flag indicating whether the instance is valid or not,
`errors` -- a character vector containing the error messages
}
\description{
Check the type and the validity of an MWCS instance
}
\examples{
data(mwcs_example)
get_instance_type(mwcs_example)
}
