
flights <- read.csv("C:/Users/GIMBIYA BENJAMIN/Desktop/flight_200/flights_200.csv")


flights$Weather_Conditions <- as.factor(flights$Weather_Conditions)
flights$Airline <- as.factor(flights$Airline)

encoded_data <- model.matrix(~ Weather_Conditions + Airline - 1, data = flights)

encoded_df <- data.frame(encoded_data, Delayed = flights$Delayed)


head(encoded_df)