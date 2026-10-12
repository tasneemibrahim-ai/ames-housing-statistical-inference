area <- ames$Gr.Liv.Area
summary(area)
hist(area)

price <- ames$SalePrice
summary(price)
hist(price)

#garageCapacity <- ames$Garage.Capacity
#summary(garageCapacity)
#hist(garageCapacity)

garageTYpe <- ames$Garage.Type
summary(garageTYpe)

garageArea <- ames$Garage.Area
summary(garageArea)
hist(garageArea)


sample_and_mean <- function(n, num_samples) {
  sample_means <- replicate(num_samples, mean(sample(features$SalePrice, size = n)))
  return(sample_means)
}

sample_means_n20 <- sample_and_mean(n = 20, num_samples = 1000)
# T-dist

sample_means_n70 <- sample_and_mean(n = 70, num_samples = 1000)
#normal dist

sample_means_n100 <- sample_and_mean(n = 100, num_samples = 1000)
#normal dist


par(mfrow = c(1, 3))
hist(sample_means_n20, main = "n = 20", xlab = "Sample Mean", col = "lightblue", border = "black")
hist(sample_means_n70, main = "n = 70", xlab = "Sample Mean", col = "lightgreen", border = "black")
hist(sample_means_n100, main = "n = 100", xlab = "Sample Mean", col = "lightcoral", border = "black")
par(mfrow = c(1, 1))


calculate_ci <- function(x) {
  result <- t.test(x, conf.level = 0.95)
  return(c(lower = result$conf.int[1], upper = result$conf.int[2]))
}

sample_and_ci <- function(n, num_samples) {
  sample_means <- replicate(num_samples, mean(sample(features$SalePrice, size = n)))
  ci_by_group <- apply(sample_means, 2, calculate_ci)
  return(ci_by_group)
}

ci_n20 <- sample_and_ci(n = 20, num_samples = 1000)
ci_n70 <- sample_and_ci(n = 70, num_samples = 1000)
ci_n100 <- sample_and_ci(n = 100, num_samples = 1000)

out_of_interval_n20 <- sum(ci_n20[1,] > mean(features$SalePrice) | ci_n20[2,] < mean(features$SalePrice))
out_of_interval_n70 <- sum(ci_n70[1,] > mean(features$SalePrice) | ci_n70[2,] < mean(features$SalePrice))
out_of_interval_n100 <- sum(ci_n100[1,] > mean(features$SalePrice) | ci_n100[2,] < mean(features$SalePrice))


cat("Number of groups (n = 20) with population mean outside the interval:", out_of_interval_n20, "\n")
cat("Number of groups (n = 70) with population mean outside the interval:", out_of_interval_n70, "\n")
cat("Number of groups (n = 100) with population mean outside the interval:", out_of_interval_n100, "\n")


set.seed(123)
two_cars_garage_sample <- filter(features, Garage.Cars == 2) %>% sample_n(25)
one_car_garage_sample <- filter(features, Garage.Cars == 1) %>% sample_n(25)


t_test_result <- t.test(two_cars_garage_sample$SalePrice, one_car_garage_sample$SalePrice)
print(t_test_result)

