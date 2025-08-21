# Flight-prediction

Flight Delay Analysis

Dataset: flights\_200.csv

This dataset includes information on flight durations, days of the week, weather conditions, and whether or not a flight was delayed.

 1. Data Preparation

* Checked for missing values: `sum(is.na(flights))` returned 0 (no missing values).
* Converted important variables to factors (categories):

  
  flights$Delayed <- as.factor(flights$Delayed)
  flights$Day_of_Week <- as.factor(flights$Day_of_Week)
  flights$Weather_Conditions <- as.factor(flights$Weather_Conditions)
  

2. Logistic Regression Model

**Goal**: Predict whether a flight will be delayed using `Flight_Duration`, `Day_of_Week`, and `Weather_Conditions`.

flights_model <- glm(Delayed ~ Flight_Duration + Day_of_Week + Weather_Conditions,
                     data = flights, family = binomial)
summary(flights_model

* Evaluated the model using confusion matrix and accuracy:

  predicted_probs <- predict(flights_model, type = "response")
  predicted_classes <- ifelse(predicted_probs > 0.5, 1, 0)
  accuracy <- mean(predicted_classes == flights$Delayed)  # ~0.625
 

* Plotted ROC curve and calculated AUC:

  roc_obj <- roc(flights$Delayed, predicted_probs)
  plot(roc_obj)
  auc(roc_obj)  # AUC ~ 0.72
  

 3. Random Forest Model

**Goal**: Improve prediction accuracy using a random forest classifier.

rf_model <- randomForest(Delayed ~ Flight_Duration + Day_of_Week + Weather_Conditions,
                         data = flights, ntree = 100, importance = TRUE)


* Accuracy: **0.875**
* AUC: **0.993**
* Plotted feature importance:

 
  importance_df <- data.frame(Feature = rownames(importance(rf_model)),
                              Importance = importance(rf_model)[, "MeanDecreaseGini"])
  ggplot(importance_df, aes(x = reorder(Feature, Importance), y = Importance)) +
    geom_bar(stat = "identity") + coord_flip()
 

 4. Encoding Categorical Variables

To prepare for machine learning models:

* Used `as.factor()` for in-model handling.
* Used `model.matrix()` to one-hot encode categorical variables:

 
  encoded_data <- model.matrix(~ Weather_Conditions + Airline - 1, data = flights)
 

 5. K-Means Clustering

**Goal**: Find natural clusters in the data using `Flight_Duration` and `Day_of_Week`.

* Converted `Day_of_Week` to numeric and scaled both features.

* Applied K-Means with 3 clusters:

 
  kmeans_result <- kmeans(scaled_data, centers = 3, nstart = 25)
  flights$Cluster <- as.factor(kmeans_result$cluster)
  

* Visualized clusters with ggplot2.

  Conclusion
1): using logistic regression my results do not strongly confirm that Day_of_Week or Weather_Conditions significantly affect flight delays.
     Only Flight_Duration was statistically significant (p = 0.0187).
     Day and weather may still matter in reality, but this dataset and model didn’t find strong enough evidence.

2): Day\_of\_Week** and **Weather\_Conditions** both contribute to predicting delays (more so in Random Forest).
   Random Forest** gave the best predictive performance.
* **K-Means** revealed groupings based on flight duration and timing.

