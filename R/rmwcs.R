rmwcs_class <- "rmwcs_solver"

sep_methods <- c("strong", "fast")
subgradients <- c("classic", "average", "cft")

check_rmwcs_solver <- function(solver) {
    if (!inherits(solver, rmwcs_class)) {
        stop("Function called with an invalid rmwcs solver instance")
    }
}

#' @export
parameters.rmwcs_solver <- function(solver) {
    params(parameter("timelimit", type = "integer", positive =  TRUE,
                   is_null_possible = TRUE),
         parameter("max_iterations", type = "integer", positive = TRUE,
                   is_null_possible = TRUE),
         parameter("max_age", type = "integer", positive = TRUE),
         parameter("beta_iterations", type = "integer", positive = TRUE),
         parameter("separation", type = "mc", mc = sep_methods),
         parameter("sep_iterations", type = "integer", positive = TRUE),
         parameter("start_constraints", type = "logical"),
         parameter("pegging", type = "logical"),
         parameter("sep_iter_freeze", type = "integer", positive = TRUE),
         parameter("heur_iterations", type = "integer", positive = TRUE),
         parameter("subgradient", type = "mc", mc = subgradients),
         parameter("beta", type = "float"),
         parameter("verbose", type = "logical"))
}

#' Generates a rmwcs solver with corresponding parameters
#' @param timelimit Timelimit in seconds
#' @param max_iterations Maximum number of subgradient iterations
#' @param beta_iterations Number of nonimproving iterations until beta is halfed
#' @param separation Separation: "strong" of "fast"
#' @param sep_iterations Extending the life of non-violated inequalities
#' @param start_constraints Whether to add flow-conservation/degree cons at start
#' @param pegging Pegging (variable fixing)
#' @param max_age extending the life of non-violated inequalities
#' @param sep_iter_freeze After how many iterations we are checking added ineqs
#' @param heur_iterations After how many iterations we are doing heuristics
#' @param subgradient Subgradient: "classic", "average", "cft"
#' @param beta Beta for subgradient
#' @param verbose Whether to print solving progress
#' @export
#' @import igraph
rmwcs_solver <- function(timelimit = 1800L,
                  max_iterations = 1000L,
                  beta_iterations = 50L,
                  separation = "strong",
                  start_constraints = TRUE,
                  pegging = TRUE,
                  max_age = 3,
                  sep_iterations= 1L,
                  sep_iter_freeze = 1L,
                  heur_iterations = 1L,
                  subgradient = "classic",
                  beta = 2.0,
                  verbose = FALSE) {
    solver_ctor(c(rmwcs_class, mwcs_solver_class))
}

#' Solves MWCS problem using relax-and-cut approach
#' @inheritParams solve_mwcsp
#' @param max_cardinality integer maximum number of vertices in solution.
#' @param budget numeric maximum budget of solution.
#' @export
solve_mwcsp.rmwcs_solver <- function(solver, instance, max_cardinality = NULL,
                                     budget = NULL, ...) {
    check_rmwcs_solver(solver)

    if (!is.null(max_cardinality) && !is.null(budget)) {
        stop("One of the arguments 'max_cardinality' and 'budget' must be NULL")
    }

    instance <- igraph::simplify(instance)

    solver$separation <- pmatch(solver$separation, sep_methods) - 1
    solver$subgradient <- pmatch(solver$subgradient, subgradients) - 1

    instance_rep <- instance_from_graph(instance)
    instance_rep$vertex_weights <- attr_values(instance, "weight", "V")

    if (!is.null(budget)) {
        instance_rep$budget_cost <- attr_values(instance, "budget_cost", "V")
        budget <- as.numeric(budget)
        if (!is.numeric(budget)) {
            stop("Budget must be numeric value or NULL")
        }
        instance_rep$budget <- budget
    }

    if (!is.null(max_cardinality)) {
        max_cardinality <- as.integer(max_cardinality)
        stopifnot(max_cardinality > 0)
        instance_rep$cardinality <- max_cardinality
    }

    vs <- rmwcs_solve(instance_rep, solver)

    subgraph <- igraph::induced_subgraph(instance, vs$graph)
    weight <- sum(instance_rep$vertex_weights[vs$graph])
    opt <- isTRUE(all.equal(weight, vs$ub))
    solution(subgraph, weight, opt, upper_bound = vs$ub)
}
