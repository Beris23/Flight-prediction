
flights$Day_of_Week <- as.factor(flights$Day_of_Week)
flights$Day_of_Week_Num <- as.numeric(flights$Day_of_Week)

cluster_data <- flights[, c("Flight_Duration", "Day_of_Week_Num")]

scaled_data <- scale(cluster_data)

wss <- numeric(10)

for (k in 1:10) {
  set.seed(123) 
  kmeans_model <- kmeans(scaled_data, centers = k, nstart = 25)
  wss[k] <- kmeans_model$tot.withinss
}


plot(1:10, wss, type = "b", pch = 19, col = "blue",
     xlab = "Number of Clusters (k)",
     ylab = "Within-Cluster Sum of Squares (WSS)",
     main = "Elbow Method to Determine Optimal Clusters",
     xaxt = "n")


axis(1, at = 1:10)


grid()
abline(h = min(wss) + (max(wss) - min(wss)) / 10, col = "red", lty = 2)

