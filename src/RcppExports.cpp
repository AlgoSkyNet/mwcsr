// Generated by using Rcpp::compileAttributes() -> do not edit by hand
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#include <Rcpp.h>

using namespace Rcpp;

// sa_solve
List sa_solve(List& instance, List& solver);
RcppExport SEXP _mwcsr_sa_solve(SEXP instanceSEXP, SEXP solverSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< List& >::type instance(instanceSEXP);
    Rcpp::traits::input_parameter< List& >::type solver(solverSEXP);
    rcpp_result_gen = Rcpp::wrap(sa_solve(instance, solver));
    return rcpp_result_gen;
END_RCPP
}
// rmwcs_solve
Rcpp::List rmwcs_solve(Rcpp::List& network, Rcpp::List& params);
RcppExport SEXP _mwcsr_rmwcs_solve(SEXP networkSEXP, SEXP paramsSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< Rcpp::List& >::type network(networkSEXP);
    Rcpp::traits::input_parameter< Rcpp::List& >::type params(paramsSEXP);
    rcpp_result_gen = Rcpp::wrap(rmwcs_solve(network, params));
    return rcpp_result_gen;
END_RCPP
}

static const R_CallMethodDef CallEntries[] = {
    {"_mwcsr_sa_solve", (DL_FUNC) &_mwcsr_sa_solve, 2},
    {"_mwcsr_rmwcs_solve", (DL_FUNC) &_mwcsr_rmwcs_solve, 2},
    {NULL, NULL, 0}
};

RcppExport void R_init_mwcsr(DllInfo *dll) {
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}
