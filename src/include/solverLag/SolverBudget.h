/*
 * SolverBudget.h
 *
 *  Created on: Mar 29, 2015
 *      Author: markus
 */

#ifndef SolverBudget_H_
#define SolverBudget_H_

#include "SolverLag.h"

#include "instance/Instance.h"
#include <list>
#include <vector>

class SolverBudget : public SolverLag {
    std::vector<std::vector<double>> M;

    double myBound = 0.0;
    double calculateCurrentSolution(bool save);
    bool primalHeuristic();
    int lagrangianPegging();
    int addInitCuts();

public:
    SolverBudget(Instance& instance, Parameters& params);
    // SolverBudget(const SolverBudget&);
    virtual ~SolverBudget();
};

#endif /* SolverBudget_H_ */
