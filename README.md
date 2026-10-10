# 🏠 Statistical Inference on the Ames Housing Dataset

> A university final project exploring **Exploratory Data Analysis**, the **Central Limit Theorem**, **Confidence Intervals**, and **Hypothesis Testing** using the Ames, Iowa housing market data — all implemented in **R**.

---

## 📋 Table of Contents

- [Overview](#overview)
- [Key Concepts & Objectives](#key-concepts--objectives)
- [Dataset](#dataset)
- [Project Structure](#project-structure)
- [Analysis Breakdown](#analysis-breakdown)
  - [1. Exploratory Data Analysis (EDA)](#1-exploratory-data-analysis-eda)
  - [2. Sampling Distributions & the Central Limit Theorem](#2-sampling-distributions--the-central-limit-theorem)
  - [3. Confidence Intervals](#3-confidence-intervals)
  - [4. Hypothesis Testing (Two-Sample t-Test)](#4-hypothesis-testing-two-sample-t-test)
- [Sample Outputs](#sample-outputs)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Running the Analysis](#running-the-analysis)
- [Technologies Used](#technologies-used)
- [Report](#report)
- [License](#license)

---

## Overview

This project applies core **statistical inference** techniques to real-world housing data from **Ames, Iowa**. Starting from exploratory visualisations of sale prices, living area, and garage features, the analysis progresses through sampling distributions, confidence-interval estimation, and a formal hypothesis test — demonstrating how these foundational concepts connect in practice.

---

## Key Concepts & Objectives

| Concept | Objective |
|---|---|
| **Exploratory Data Analysis** | Summarise and visualise key housing features (price, area, garage type & area) |
| **Central Limit Theorem (CLT)** | Show that the sampling distribution of the mean approaches normality as *n* increases |
| **Confidence Intervals** | Construct 95 % CIs for different sample sizes and count how often the population mean falls outside |
| **Hypothesis Testing** | Perform a two-sample *t*-test comparing sale prices of 1-car vs. 2-car garage homes |

---

## Dataset

| Detail | Value |
|---|---|
| **Name** | Ames Housing Dataset |
| **Location** | Ames, Iowa, USA |
| **Key Variables Used** | `SalePrice`, `Gr.Liv.Area`, `Garage.Type`, `Garage.Area`, `Garage.Cars` |
| **Source** | Commonly available via the `AmesHousing` R package or Kaggle |

The dataset contains detailed information on residential property sales and is widely used in statistics and machine-learning education.

---

## Project Structure

```
ames-housing-statistical-inference/
├── R.R                  # Main R script with all analyses
├── Final project.pdf    # Full written project report
└── README.md            # This file
```

---

## Analysis Breakdown

### 1. Exploratory Data Analysis (EDA)

Summary statistics and histograms are generated for:

- **Above-Grade Living Area** (`Gr.Liv.Area`) — distribution of house sizes
- **Sale Price** (`SalePrice`) — distribution of property values
- **Garage Type** (`Garage.Type`) — frequency of garage categories
- **Garage Area** (`Garage.Area`) — distribution of garage sizes

```r
area <- ames$Gr.Liv.Area
summary(area)
hist(area)

price <- ames$SalePrice
summary(price)
hist(price)
```

### 2. Sampling Distributions & the Central Limit Theorem

To illustrate the **CLT**, 1 000 random samples are drawn at three different sample sizes (*n* = 20, 70, 100). The resulting distributions of sample means are plotted side-by-side:

| Sample Size | Expected Shape |
|---|---|
| *n* = 20 | Approximated by a *t*-distribution |
| *n* = 70 | Approximately normal |
| *n* = 100 | Approximately normal |

```r
par(mfrow = c(1, 3))
hist(sample_means_n20,  main = "n = 20",  col = "lightblue")
hist(sample_means_n70,  main = "n = 70",  col = "lightgreen")
hist(sample_means_n100, main = "n = 100", col = "lightcoral")
par(mfrow = c(1, 1))
```

### 3. Confidence Intervals

For each sample size, **95 % confidence intervals** are computed across 1 000 replications. The analysis counts how many intervals *fail* to capture the true population mean — expected to be roughly **5 %** of the time.

```r
calculate_ci <- function(x) {
  result <- t.test(x, conf.level = 0.95)
  return(c(lower = result$conf.int[1], upper = result$conf.int[2]))
}
```

### 4. Hypothesis Testing (Two-Sample t-Test)

A **Welch two-sample *t*-test** compares the mean sale prices of:

- 🚗 Homes with a **1-car garage** (random sample of 25)
- 🚗🚗 Homes with a **2-car garage** (random sample of 25)

```r
set.seed(123)
two_cars  <- filter(features, Garage.Cars == 2) %>% sample_n(25)
one_car   <- filter(features, Garage.Cars == 1) %>% sample_n(25)

t.test(two_cars$SalePrice, one_car$SalePrice)
```

This tests whether garage capacity is significantly associated with sale price.

---

## Sample Outputs

> 🖼️ *Add your own screenshots here to showcase the analysis visuals.*

| Output | Screenshot |
|---|---|
| Living Area Histogram | <!-- ![Living Area Histogram](screenshots/living_area_hist.png) --> *Add screenshot* |
| Sale Price Histogram | <!-- ![Sale Price Histogram](screenshots/sale_price_hist.png) --> *Add screenshot* |
| CLT — Sampling Distributions (n = 20, 70, 100) | <!-- ![CLT Plot](screenshots/clt_sampling_distributions.png) --> *Add screenshot* |
| t-Test Results | <!-- ![t-Test Output](screenshots/t_test_results.png) --> *Add screenshot* |

> **Tip:** Save plots from RStudio using **Export → Save as Image** and place them in a `screenshots/` folder. Then uncomment the image links above.

---

## Getting Started

### Prerequisites

- **R** (≥ 4.0) — [Download R](https://cran.r-project.org/)
- **RStudio** (recommended) — [Download RStudio](https://posit.co/download/rstudio-desktop/)
- Required R packages:

```r
install.packages(c("dplyr", "AmesHousing"))   # if not already installed
```

### Running the Analysis

1. **Clone the repository:**
   ```bash
   git clone https://github.com/<your-username>/ames-housing-statistical-inference.git
   cd ames-housing-statistical-inference
   ```

2. **Open `R.R`** in RStudio (or your preferred R IDE).

3. **Load the dataset** (ensure the `ames` / `features` data frames are available — e.g., via the `AmesHousing` package):
   ```r
   library(AmesHousing)
   ames <- make_ames()
   features <- ames
   ```

4. **Run the script** — execute the code sequentially or source the entire file:
   ```r
   source("R.R")
   ```

---

## Technologies Used

| Tool | Purpose |
|---|---|
| **R** | Statistical computing and analysis |
| **Base R Graphics** | Histograms and multi-panel plots |
| **dplyr** | Data filtering and sampling |
| **t.test()** | Confidence intervals and hypothesis testing |

---

## Report

The full written analysis, interpretations, and conclusions are documented in [**Final project.pdf**](Final%20project.pdf).

---

## License

This project was developed as a university coursework assignment. Feel free to reference or adapt the code for educational purposes.

---

## Author

Tasneem Ibrahim

## Author

 Tasneem Ibrahim

