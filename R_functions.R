# Dplyr Functions with TQDM-like progress bar
# Ex: Instead of doing apply(df, 1, foo), call apply_pb(df, 1, foo).

apply_pb <- function(X, MARGIN, FUN, ...)
  {
    env <- environment()
    pb_Total <- sum(dim(X)[MARGIN])
    counter <- 0
    pb <- txtProgressBar(min = 0, max = pb_Total,
                         style = 3)
    wrapper <- function(...)
    {
      curVal <- get("counter", envir = env)
      assign("counter", curVal +1 ,envir= env)
      setTxtProgressBar(get("pb", envir= env),
                             curVal +1)
      FUN(...)
    }
    res <- apply(X, MARGIN, wrapper, ...)
    close(pb)
    res
  }
  
lapply_pb <- function(X, FUN, ...)
  {
   env <- environment()
   pb_Total <- length(X)
   counter <- 0
   pb <- txtProgressBar(min = 0, max = pb_Total, style = 3)   
   # wrapper around FUN
   wrapper <- function(...){
     curVal <- get("counter", envir = env)
     assign("counter", curVal +1 ,envir=env)
     setTxtProgressBar(get("pb", envir=env), curVal +1)
     FUN(...)
   }
   res <- lapply(X, wrapper, ...)
   close(pb)
   res
  }

sapply_pb <- function(X, FUN, ...)
  {
    env <- environment()
    pb_Total <- length(X)
    counter <- 0
    pb <- txtProgressBar(min = 0, max = pb_Total, style = 3)
    wrapper <- function(...){
      curVal <- get("counter", envir = env)
      assign("counter", curVal +1 ,envir=env)
      setTxtProgressBar(get("pb", envir=env), curVal +1)
      FUN(...)
    }
    res <- sapply(X, wrapper, ...)
    close(pb)
    res
  }
