library(ggplot2) # Load ggplot2
vgames<-read.csv("./dataset-from-help/vgsales.csv", header=TRUE, sep=",") # Load vgsales.csv
head(vgames) # Print first 5 rows of vgames
subgames<-subset(vgames, Platform==c("Wii","PS4","X360")) # Subset vgames to only include Wii, PS4, and X360
ggplot(subgames) # Plot subgames using ggplot
ggplot(subgames) + geom_point(mapping = aes(x = Critic_Score, y = Global_Sales)) # Add geom_point to ggplot
gg <- ggplot(subgames) # Create ggplot object
gg <- gg + geom_point(mapping = aes(x = Critic_Score, y = Global_Sales, color = Platform)) # add geometric objects to ggplot
print(gg) # Print ggplot object

#
newGames <- subset(vgames, Year >= 2017) # Subset vgames to only include games released after 2017
newGames$Platform <- as.factor(newGames$Platform) #categorize the data(platform) into factors
levels(newGames$Platform) #view the categories of platforms
summary(newGames$Platform) #view number of games per platform in newGames

#subset the newGames further to only a few select platforms
newGames <- subset(newGames, Platform %in% c("PS4", "PSV", "NS", "PC", "XOne")) # Subset newGames to only include Wii, PS4, and X360
summary(newGames$Platform) #view number of games per platform in newGames
newGames$Company <- ifelse(newGames$Platform %in% c("PS4", "PSV"), "Sony", ifelse(newGames$Platform %in% c("PC", "XOne"), "Microsoft", "Nintendo")) # categorize the data(company) into factors,
head(newGames[,c(1:5, 16,17)]) # Print first 5 rows of newGames

#view data in bar chart
cg <- ggplot(newGames)
cg <- cg + geom_bar(mapping = aes(x = Company, fill = Platform)) #bar chart sort by Company and Platform, y is number of games sold
cg <- cg + labs(title = "Number of games sold")
print(cg)
