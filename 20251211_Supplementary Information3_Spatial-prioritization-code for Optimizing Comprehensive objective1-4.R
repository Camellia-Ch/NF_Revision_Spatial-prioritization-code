# Supplementary Information3_Spatial prioritization code of Optimizing Comprehensive objective1-4 (GHG EMISSION, WATER USE, LAND USE, AND PESTICIDE USE)

# Step 1
library(raster)
setwd('G:/20251211_Supplementary Information3_Spatial-prioritization-code_Original data')
list.files()
files1 = list.files(pattern = ".tif$")
length(files1)


layer1 <- raster("ComprehensiveObjective1-4_GHGemissionGlobalTotalBenefit_CamelliaReplacementinScenario1.tif")
layer2 <- raster("ComprehensiveObjective1-4_WateruseGlobalTotalBenefit_CamelliaReplacementinScenario1.tif")
layer3 <- raster("ComprehensiveObjective1-4_LanduseGlobalTotalBenefit_CamelliaReplacementinScenario1.tif")
layer4 <- raster("ComprehensiveObjective1-4_PesticideuseGlobalTotalBenefit_CamelliaReplacementinScenario1.tif")



normalized_layer1 <- (layer1 - mean(layer1[], na.rm=TRUE)) / sd(layer1[], na.rm=TRUE)
normalized_layer2 <- (layer2 - mean(layer2[], na.rm=TRUE)) / sd(layer2[], na.rm=TRUE)
normalized_layer3 <- (layer3 - mean(layer3[], na.rm=TRUE)) / sd(layer3[], na.rm=TRUE)
normalized_layer4 <- (layer4 - mean(layer4[], na.rm=TRUE)) / sd(layer4[], na.rm=TRUE)


r <- (normalized_layer1 + normalized_layer2 + normalized_layer3 + normalized_layer4)/4


writeRaster(r, "ComprehensiveObjective1-4_normalizedGlobalTotalBenefit_CamelliaReplacementinScenario1.tif", format="GTiff", overwrite=TRUE)

flatten <- function(raster) {
  values(raster)
}

ncell <- ncell(r)
max_value <- maxValue(r)
min_value <- minValue(r)
num_greater_than_min <- cellStats(r > min_value, sum, na.rm = TRUE)

n_step_size = ceiling(num_greater_than_min/100)

number_iterations = ceiling(num_greater_than_min / n_step_size)
print(paste("number_iterations：", number_iterations))


for(i in 1:number_iterations){
  
  r_flat <- flatten(r)
  sorted_indices <- order(r_flat, decreasing = TRUE)
  
  top_indices <- sorted_indices[1:(i*n_step_size)]
  
  r_new <- raster(nrows = nrow(r), ncols = ncol(r), crs = crs(r))
  values(r_new) <- NA
  values(r_new)[top_indices] <- values(r)[top_indices]
  value <- cellStats(r_new, stat = 'sum')
  extent(r_new) <- extent(r)

output_filename <- paste0("topPercentage", i, "_scenario1_comprehensiveobjective1to4_CamelliaReplacingPrioritization.tif")
output_path <- file.path('G:/20251211_Supplementary Information3_Spatial-prioritization-code_Output results/Result_Scenario1_Optimizing objective1-4 simultaneously_prioritization/', output_filename)
writeRaster(r_new, filename = output_path, format = "GTiff", overwrite = TRUE)
}




# Step 2
library(raster)
setwd('G:/20251211_Supplementary Information3_Spatial-prioritization-code_Output results/Result_Scenario1_Optimizing objective1-4 simultaneously_prioritization')
list.files()
files1 = list.files(pattern = ".tif$")
length(files1)
file_list = list.files(pattern = "\\.tif$", full.names = TRUE)


sum_raster <- raster(file_list[1])
values(sum_raster) <- 0


for (file in file_list) {
  
  raster_data <- raster(file)
  values(raster_data) <- ifelse(!is.na(values(raster_data)), 1, 0)
  sum_raster <- sum_raster + raster_data
}

vals <- values(sum_raster)
reversed_vals <- ifelse(
  vals == 0, 0,  
  ifelse(
    vals >= 1 & vals <= 100,  
    101 - vals,  
    vals  
  )
)


r_reversed <- raster(sum_raster)
values(r_reversed) <- reversed_vals


writeRaster(r_reversed, 
            "TopPercentage1to100_scenario1_objective1-4_CamelliaReplacingPrioritization.tif", 
            format = "GTiff", overwrite = TRUE)

