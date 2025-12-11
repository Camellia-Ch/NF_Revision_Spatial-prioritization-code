# NF_Revision_Spatial-prioritization-code

Diversified global vegetable oil production through Camellia oleifera can mitigate climate change and achieve socio-environmental co-benefits 

Supplementary Information - Code to compute Spatial prioritization of Camellia crop-replacing

Phase 1: Constraint-Driven Feasible Solution Space Delineation. This phase corresponds to the mathematical optimization model described in the "Crop-replacing constraints" section of the paper. All key constraints—the yield safeguard constraint, country-specific replacement ratio caps (Table S24), the global total replacement area cap (23.5%), and the net environmental/economic benefit constraints—are implemented during the data preprocessing stage in Arcgis 10.6. Specifically, through country- and grid-level calculations and filtering, we pre-exclude any areas that do not satisfy these constraints from the candidate set, generating a raster dataset that represents the "feasible solution space." These constraints are "internalized" through geodata processing prior to the optimization-solving step.

Phase 2: Multi-Objective Priority Ranking. In this phase, we perform multi-criteria decision analysis on the "feasible solution space" raster dataset. For the comprehensive objective, we employ a linear weighting method (equal weights in this study's example) to aggregate the five standardized benefit indicators into a single composite score. The core ranking algorithm is not an online solver involving decision variables and constraint equations in the traditional sense, but rather performs a global full ranking of all grid cells based on this composite score. The provided code (e.g., the flatten function and iterative ranking process, please see the "Spatial-prioritization-code") is the implementation of this algorithm, efficiently identifying the priority sequence from the top 1% to 100%.


Note 1: Original data = files1 = list.files(pattern = ".tif$") 

Note 2: Priorities refer to the highest (level: 1) to lowest (level: 100) valuable areas for Camellia replacement to achieve benefits.

Note 3: software's license for use is RStudio (https://posit.co/download/rstudio-desktop/).
