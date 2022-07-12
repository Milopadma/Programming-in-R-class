# load the library
# use install.packages("ggplot2") if it is not found
library(ggplot2)
library(dplyr)

# Read the file - please set your working directory first
bikes <- read.csv('./dataset-from-help/bikesharing.csv', header = TRUE, sep = ',')

# convert the dteday column to a Date data type
# since we know it is stored as mm/dd/yyyy
bikes$dteday <- as.Date(bikes$dteday, "%m/%d/%Y")

# convert categories to factors
bikes$season <- as.factor(bikes$season)
bikes$weekdayname <- as.factor(bikes$weekdayname)
bikes$weather <- as.factor(bikes$weather)
bikes$holiday <- as.factor(bikes$holiday)
bikes$workday <- as.factor(bikes$workday)
bikes$usertype <-as.factor(bikes$usertype)

# order the categories for the weekdays and seasons
levels(bikes$weekdayname) =c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday")
levels(bikes$season)=c("spring", "summer", "autumn", "winter")


# view summary of the data
summary(bikes)

# Group the bikes data by day
dailyData <- group_by(bikes,dteday)

# Count the daily rentals
dailyRentals <- summarise(dailyData, totalRentals = sum(numrentals))
dailyRentals

# plot the daily total rentals using a line chart
# add a descriptive title 
gg<-ggplot(dailyRentals)
gg <- gg+ geom_line(mapping = aes(x = dteday,y= totalRentals))
gg<- gg + labs(title="Total daily rentals show increase in 2012",
            x=NULL, y="Total Daily Rentals")
gg <- gg + geom_smooth(mapping = aes(x = dteday,y= totalRentals))
gg

# summarise by customer user type
customerData <- group_by(bikes, dteday, usertype)
customerRentals <- summarise(customerData, totalRentals = sum(numrentals))
customerRentals

# plot again
gg <- ggplot(customerRentals)
gg <- gg + geom_line(mapping = aes(x=dteday, y= totalRentals, color=usertype))
gg <- gg+ labs(title = "Total daily rentals show increase in 2012", 
               subtitle="Increase due to registered users",
               x=NULL, y=NULL)
gg

# plot area chart
gg <- ggplot(customerRentals)
gg <- gg + geom_area(mapping = aes(x=dteday, y= totalRentals, fill=usertype),
                     position = position_stack(reverse=TRUE))
gg <- gg+ labs(title = "Total daily rentals show increase in 2012", 
               subtitle="Increase due to registered users",
               x=NULL, y=NULL, fill="User Type")
gg

# create summary by year and month
monthlyData <- group_by(bikes, yr, mnth, usertype)
monthlyRentals <- summarize(monthlyData, totalRentals = sum(numrentals))

#plot by month and year
gg <- ggplot(monthlyRentals)
gg <- gg + geom_bar(mapping=aes(x=mnth, y=totalRentals, fill=usertype ), 
                    stat="identity") 
gg <- gg + labs(title="Total Rentals by Month", 
                x= "Month", y= NULL, 
                fill="User Type")
gg <- gg + scale_x_discrete(limits=c(1:12),
          label=c("J","F","M","A","M","J","J","A","S","O","N","D"))
gg <- gg + scale_y_continuous(label = scales::comma)
gg <- gg + theme(legend.position="top")
gg <- gg + facet_grid(yr~.)
gg

# plot side by side
gg <- ggplot(monthlyRentals)
gg <- gg + geom_bar(mapping=aes(x=mnth, y=totalRentals, 
                                fill=usertype ), 
                    stat="identity", position="dodge") 
gg <- gg + labs(title="Total Rentals by Month", x= "Month", y= NULL, fill="User Type")
gg <- gg + scale_x_discrete(limits=c(1:12),
                            label=c("J","F","M","A","M","J","J","A","S","O","N","D"))
gg <- gg + scale_y_continuous(label = scales::comma)
gg <- gg + facet_grid(yr~.)
gg <- gg + theme(legend.position="top")
gg

# plot as 100% stacked
gg <- ggplot(monthlyRentals)
gg <- gg + geom_bar(mapping=aes(x=mnth, y=totalRentals, 
                                fill=usertype ), 
                    stat="identity", position="fill") 
gg <- gg + labs(title="Proportion of Rentals by Month", x= "Month", y= NULL, fill="User Type")
gg <- gg + scale_x_discrete(limits=c(1:12),
                            label=c("J","F","M","A","M","J","J","A","S","O","N","D"))
gg <- gg + scale_y_continuous(breaks=seq(0,1,0.2),label = scales::percent)
gg <- gg + facet_grid(yr~.)
gg <- gg + theme(legend.position="top")
gg




weeklyData <- group_by(bikes,weekdayname, hr)
weeklyRentals <- summarise(weeklyData, averageNumRentals=mean(numrentals) )

# Heat map using geom_tile
gg <- ggplot(weeklyRentals)
gg <- gg+ geom_tile(mapping=aes(x=hr, y=weekdayname , fill=averageNumRentals))
gg <- gg + scale_fill_gradient(low="light gray",high="dark blue")
gg <- gg + scale_x_continuous(breaks=seq(0,23,by=1))
gg <- gg + theme_bw()
gg <- gg + labs(title="Mean Rental by Week Day Hour", x = "hour", y=NULL, fill="Average")
gg


# density plot by weather
gg <- ggplot(bikes)
gg <- gg + geom_point(mapping=aes(x=temp, y=windspeed, color=season, size=numrentals), alpha=0.5)
gg <- gg + facet_grid(weather ~ usertype)
gg

# plot weather by season, number of rentals and user type
gg <- ggplot(bikes, mapping=aes(x=temp, y=windspeed, 
                                color=season, size=numrentals))
gg <- gg + geom_point(alpha=0.5, position="jitter")
gg <- gg + facet_grid(rows=vars(weather), cols=vars(usertype))
gg <- gg + labs(title="Casual users low on rainy days")
gg <- gg + theme(legend.position="top")
gg

