
##**************************************************************************************************
##Project:		Coursera > R Programming > Assignment 2
##Author:			David.m.baron@icloud.com 
##Course ID:	rprog-033
##___________________________________________________________________________________________________
##Test: 
## matcheck <- matrix(data = c(15,9,10,22), nrow = 2, ncol = 2)
## matcheck2 <- makeCacheMatrix(matcheck)
## cacheSolve(matcheck2)
##___________________________________________________________________________________________________
##Revision History
##Date	  Author  Reason for Change
##2015-10-18	Update cashematrix.R function script 
##-------	 ------- -----------------------------------------------------------------------
##***************************************************************************************************

makeCacheMatrix <- function(x = matrix()) {
  m<-NULL
  set<-function(y){
    x<<-y
    m<<-NULL
  }
  get<-function() x
  setmatrix<-function(solve) m<<- solve
  getmatrix<-function() m
  list(set=set, get=get,
       setmatrix=setmatrix,
       getmatrix=getmatrix)
}

cacheSolve <- function(x=matrix(), ...) {
  m<-x$getmatrix()
  if(!is.null(m)){
    message("getting cached data")
    return(m)
  }
  matrix<-x$get()
  m<-solve(matrix, ...)
  x$setmatrix(m)
  m
}