#problem Statement
#A car company produces 2 models, model A and model B. Long-term projections indicate an expected demand of 
#at least 100 model A cars and 80 model B cars each day. Because of limitations on production capacity, no more than 200 model A cars 
#and 170 model B cars can be made daily. To satisfy a shipping contract, a total of at least 200 cars much be shipped each day. 
#If each model A car sold results in a $2000 loss, but each model B car produces a $5000 profit, 
#how many of each type should be made daily to maximize net profits?

# Install lpsolve library if not installed
install.packages("lpSolveAPI")

# Load lpsolve library
library("lpSolveAPI")

#Represent our problem
#make.lp(constraints, decision variables) we have 2 decision variables A & B
lprec <- make.lp(0, 2)

#sense='max' as we want to maximize the profit
lp.control(lprec, sense="max")

#objective Function for two variables 
set.objfn(lprec, c(-2000, 5000))

#Setting up the constraints
#A+B>=200 at least 200 cars much be shipped each day
add.constraint(lprec, c(1, 1), ">=",200)
#100 <= A <= 200 demand of at least 100 and limitations on production capacity is 200
add.constraint(lprec, c(1,0), ">=", 100)
add.constraint(lprec, c(1,0), "<=", 200)
#80 <= B <= 170 demand of at least 80 and limitations on production capacity is 170
add.constraint(lprec, c(0,1), ">=", 80)
add.constraint(lprec, c(0,1), "<=", 170)
RowNames <- c("Shipment", "ProCapacityA", "DemandA","ProCapacityB", "DemandB")
ColNames <- c("A", "B")
dimnames(lprec) <- list(RowNames, ColNames)

#Display the lpsolve matrix
lprec

# Solve the problem
solve(lprec)
# if the return value is 0 Then command was successful otherwise fail
#Get maximum profit we can get
get.objective(lprec)

#Get the solution as how many model A and B cars to be produced to get more profit
get.variables(lprec)
# For, to achieve the maximum profit ($650000), the company should produce 100 model A cars and 170 model B cars

plot(lprec)

#saving the results
write.lp(lprec,'model.lp',type='lp')
