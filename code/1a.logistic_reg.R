flights <- read.csv("C:/Users/GIMBIYA BENJAMIN/Desktop/flight_200/flights_200.csv")
print(flights)
str(flights)

summary(flights)

sum(is.na(flights))

flights$Delayed <- as.factor(flights$Delayed)

flights$Day_of_Week <- as.factor(flights$Day_of_Week)
flights$Weather_Conditions <- as.factor(flights$Weather_Conditions)

testflights_model <- glm(Delayed ~ Flight_Duration + Day_of_Week + Weather_Conditions, data = flights, family = binomial)
summary(flights_model)

predicted_probs <- predict(testflights_model, type = "response")

predicted_classes <- ifelse(predicted_probs > 0.5, 1, 0)

conf_matrix <- table(Predicted = predicted_classes, Actual = flights$Delayed)
print(conf_matrix)

accuracy <- mean(predicted_classes == flights$Delayed)
print(paste("Accuracy:", round(accuracy, 3)))

predicted_class_0.4 <- ifelse(predicted_probs > 0.4, 1, 0)
conf_matrix_0.4 <- table(Predicted = predicted_class_0.4, Actual = flights$Delayed)
conf_matrix_0.4
mean(predicted_class_0.4 == flights$Delayed)

library(pROC)


logit_probs <- predict(testflights_model, newdata = flights, type = "response")

roc_obj <- roc(flights$Delayed, logit_probs)
plot(roc_obj, col = "red", main = "ROC Curve - Logistic Regression")
auc_val <- auc(roc_obj)
cat("AUC:", auc_val, "\n")

library(ggplot2)

flights$Predicted_Prob <- predicted_probs

ggplot(flights, aes(x = Predicted_Prob, fill = Delayed)) +
  geom_histogram(position = "identity", bins = 30, alpha = 0.6) +
  labs(title = "Histogram of Predicted Probabilities by Delay Status",
       x = "Predicted Probability of Delay",
       y = "Count") +
  theme_minimal()



