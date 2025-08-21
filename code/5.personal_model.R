
library(randomForest)

flights$Delayed <- as.factor(flights$Delayed)
flights$Day_of_Week <- as.factor(flights$Day_of_Week)
flights$Weather_Conditions <- as.factor(flights$Weather_Conditions)


rf_model <- randomForest(Delayed ~ Flight_Duration + Day_of_Week + Weather_Conditions, data = flights, ntree = 500)


sample_data <- data.frame(
  Flight_Duration = 120,
  Day_of_Week = factor(3, levels = levels(flights$Day_of_Week)),
  Weather_Conditions = factor("Fog", levels = levels(flights$Weather_Conditions))
)

predicted_delay <- predict(rf_model, newdata = sample_data, type = "response")
print(paste("Predicted Delay:", predicted_delay))

predicted_prob <- predict(rf_model, newdata = sample_data, type = "prob")
print("Predicted Probability for Each Class:")
print(predicted_prob)
