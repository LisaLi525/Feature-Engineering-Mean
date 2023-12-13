# This script assumes that the data has already been pre-processed and is ready for feature engineering

# Function to calculate the aggregated mean values for feature weighting
calculate_aggregated_mean <- function(data) {
    # Group by a specific feature (adjust according to your data structure)
    grouped_data <- data %>% 
        group_by(COMPONENT_NAME_ADJ) %>% 
        summarize_if(is.numeric, mean)

    # Calculate the number of distinct passengers for each component
    passenger_count <- data %>% 
        group_by(COMPONENT_NAME_ADJ) %>% 
        summarize(PASS = n_distinct(PASSENGER_ID))

    # Combine the mean values and passenger counts
    aggregated_mean <- cbind(passenger_count, grouped_data)

    # Optionally remove the grouping column if no longer needed
    aggregated_mean$COMPONENT_NAME_ADJ <- NULL

    # Reorder columns if needed
    aggregated_mean <- aggregated_mean[, c(2, 1, 3:ncol(aggregated_mean))]

    return(aggregated_mean)
}

# Example Usage:
# Assuming 'data' is your pre-processed dataset
aggregated_mean_data <- calculate_aggregated_mean(data)

# Saving the output
write.csv(aggregated_mean_data, "path/to/aggregated_mean_data.csv", row.names = FALSE)
