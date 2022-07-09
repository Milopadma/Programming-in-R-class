#use ggplot2 library
library(ggplot2)

#import GradJObs20202021.csv to gradJobs variable
grad_jobs <- read.csv("./dataset-from-help/GradJObs20202021.csv", header = T, sep = ",")
#subset Programe column to gradJobsJobType variable
# gradJobsProgramme <- gradJobs$Programme
#show non-duplicates in gradJobsJobType and sort them alphabetically
# unique(gradJobsProgramme)

#set the rows ACCOUNTING, ECONOMICS, FINANCE, MARKETING, IT as x axis and the salary.range as y axis using ggplot2








#preparing the data to group estimated salary by job programme,
#to set the X variable as a factor
#aggregation
salary_comparison <- aggregate(grad_jobs$Estimated.Salary, by = list(grad_jobs$Programme), FUN = mean)
# change column names
colnames(salary_comparison) <- c("Programme", "Estimated_Salary")
# sort by Estimated salary
salary_comparison <- salary_comparison[order(salary_comparison$Estimated_Salary), ]
# to retain the order in the plot
salary_comparison$Programme <- factor(salary_comparison$Programme, levels = salary_comparison$Programme)

#plotting the graph
ggplot(salary_comparison, aes(x = Programme, y = Estimated_Salary)) +
geom_bar(stat = "identity", width = 0.5, fill = "tomato3") +
labs(title = "Estimated Salary by Programme",
    x = "Programme",
    y = "Estimated Salary") +
theme(axis.text.x = element_text(angle = 90, hjust = 1))