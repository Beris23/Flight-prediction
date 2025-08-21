library(randomForest)
flights$Delayed <- as.factor(flights$Delayed)
flights$Day_of_Week <- as.factor(flights$Day_of_Week)
flights$Weather_Conditions <- as.factor(flights$Weather_Conditions)

set.seed(123) 
rf_model <- randomForest(Delayed ~ Flight_Duration + Day_of_Week + Weather_Conditions,
                         data = flights,
                         importance = TRUE,
                         ntree = 100)
print(rf_model)

importance(rf_model)
varImpPlot(rf_model)

rf_predictions <- predict(rf_model, flights)

conf_matrix_rf <- table(Predicted = rf_predictions, Actual = flights$Delayed)
print(conf_matrix_rf)

accuracy_rf <- mean(rf_predictions == flights$Delayed)
print(paste("Random Forest Accuracy:", round(accuracy_rf, 3)))

library(pROC)
rf_probs <- predict(rf_model, flights, type = "prob")[, 2]
roc_rf <- roc(flights$Delayed, rf_probs)
plot(roc_rf, col = "blue", main = "ROC Curve - Random Forest")
auc(roc_rf)

library(randomForest)
library(ggplot2)


importance_df <- as.data.frame(importance(rf_model))


importance_df$Feature <- rownames(importance_df)


colnames(importance_df)[1] <- "Importance"

ggplot(importance_df, aes(x = reorder(Feature, Importance), y = Importance)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  coord_flip() +
  labs(title = "Feature Importance - Random Forest",
       x = "Features",
       y = "Importance (Mean Decrease in Gini)") +
  theme_minimal()



