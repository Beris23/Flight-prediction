
flights$Day_of_Week <- as.factor(flights$Day_of_Week)
flights$Day_of_Week_Num <- as.numeric(flights$Day_of_Week)

cluster_data <- flights[, c("Flight_Duration", "Day_of_Week_Num")]

scaled_data <- scale(cluster_data)

set.seed(123)  
kmeans_result <- kmeans(scaled_data, centers = 3, nstart = 25)

flights$Cluster <- as.factor(kmeans_result$cluster)

library(ggplot2)

ggplot(flights, aes(x = Flight_Duration, y = Day_of_Week_Num, color = Cluster)) +
  geom_point(size = 2) +
  labs(title = "K-Means Clustering (Flight Duration vs Day of Week)",
       x = "Flight Duration",
       y = "Day of Week (Numeric)") +
  theme_minimal()
