name <- c("alex", "mark", "adi", "richard")
student_id <- c("s014", "s031", "s011", "s342")
programme <- c("Business", "Business", "Psychology", "Pharmacy")
cgpa <- c(2.50, 3.00, 3.50, 3.00)
students <- data.frame(name, student_id, programme, cgpa)
# each vector above becomes a column in the table 
students

## reading from a .csv file
redwine <- read.csv("./dataset-from-help/winequality-red.csv", header = T, sep = ";")

#show the head and first 6 lines of the data
head(redwine)

#show the tail and last 6 lines of the data
tail(redwine, n = 6)

#show the summarized version fo the data set
summary(redwine)

#only show data from citric acid column
redwine[, "citric.acid"]
redwine$citric.acid

#only show data from second row fo data
redwine[2,]

#only show data from rows 2, 4 and 10
redwine[c(2, 4, 10),]

#subset a data set using subset() and applying it to a variable
hasNitricAcid <- subset(redwine, citric.acid != 0 & quality > 4)
hasNitricAcid

#subsetting a data set by selecting rows and columns
someWine <- subset(redwine, citric.acid != 0 & quality > 4, c("chlorides", "pH"))

#str() is used to see the structure of the data set
str(someWine)

#plot only the fixed.acidity column from the redwine 
## data set to a graph
plot(redwine$fixed.acidity)

#show fixed.acidity column from the redwine data set to a histogram
hist(redwine$fixed.acidity, main = "Histogram of fixed acidity", breaks = 20, xlab = "Fixed acidity", ylab = "Frequency", col = "red")
