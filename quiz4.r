# Download the "FreshGradJobsDec2020.csv" into your working directory

# Read the data set into a data frame called jobs

jobs<-read.csv("./dataset-from-help/FreshGradJobsDec2020.csv", header = TRUE, sep =',' )
str(jobs)
summary(jobs)
jobs$Specialization <- as.factor(jobs$Specialization)
str(jobs)


#only keep legal and journalism jobs
lawjobs <- subset(jobs, Specialization %in% c("Legal", "Journalism"))

hist(lawjobs$Estimated.Salary, main="Legal and Journalism Jobs", xlab="Esimated Salary")