name <- 2
name2 <- 5

fruits <- c("apple", "banana", "orange")

productof2 <- function(x, y) {
  return(x * y)
}


# run function
productof2(name, name2)

testing <- function() {
  line2 <- c(2, 4, 6, 9, 10)
  line1 <- c(1, 2, 5, 7, 9)
  plot(line1, type = "l", main = "graph1", col = "blue", xlab = "x", ylab = "y")
  lines(line2, col = "red", type = "l", lwd = 2)
}
testing()
