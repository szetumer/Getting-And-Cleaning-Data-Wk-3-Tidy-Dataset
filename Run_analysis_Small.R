#This is the script that you can run AFTER you run the run_analysis.R script to get a smaller dataset
#consisting of only the variables that are the mean and standard deviation of measured values.

originaldf <- read.table("All_Vars_Dataset.txt", sep = " ", header = TRUE)
mean_sd_indicies <- c(1:2,3:8, 43:48, 123:128)
smalldf <- originaldf[,mean_sd_indicies]
write.table(smalldf, "Mean_SD_Measured.txt", row.names = FALSE)