#use ggplot2 library
library(ggplot2)

#import GradJObs20202021.csv to gradJobs variable
grad_jobs <- read.csv("./dataset-from-help/GradJObs20202021.csv", header = T, sep = ",")

#preparing the data to group estimated salary by job programme,
#to set the X variable as a factor
salary_comparison <- aggregate(grad_jobs$Estimated.Salary, by = list(grad_jobs$Programme), FUN = mean)

# change column names
colnames(salary_comparison) <- c("Programme", "Estimated_Salary")

#remove everything except IT, ACCOUNTING, MARKETING
select_programmes <- subset(salary_comparison, Programme %in% c("IT", "ACCOUNTING", "MARKETING"))

# sort by Estimated salary
salary_comparison <- salary_comparison[order(salary_comparison$Estimated_Salary), ]

# to retain the order in the plot
select_programmes$Programme <- factor(select_programmes$Programme, levels = select_programmes$Programme)

#plotting the graph
ggplot(select_programmes, aes(x = Programme, y = Estimated_Salary)) +
geom_bar(stat = "identity", width = 0.5, fill = "tomato2") +
labs(title = "Estimated Salary by Programme",
    x = "Programme",
    y = "Estimated Salary") +
theme(axis.text.x = element_text(angle = 90, hjust = 1))
