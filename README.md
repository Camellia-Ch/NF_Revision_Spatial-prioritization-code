# NF_Revision_Spatial-prioritization-code

Diversified global vegetable oil production through Camellia oleifera can mitigate climate change and achieve socio-environmental co-benefits 

Supplementary Information - Code to compute Spatial prioritization of Camellia crop-replacing

Phase 2: Multi-objective priority ranking. In this phase, we perform multi-criteria decision analysis on the "feasible solution space" raster dataset. For the comprehensive objective, we employ a linear weighting method (equal weights in this study's example) to aggregate the five standardized benefit indicators ((1) maximize GHG emission reductions, (2) maximize water use reductions, (3) maximize land use reductions, (4) maximize pesticide use reductions, and (5) maximize farmer income increasing) into a single composite score. The core ranking algorithm is not an online solver involving decision variables and constraint equations in the traditional sense, but rather performs a global full ranking of all grid cells based on this composite score. 


Note 1: Original data = files1 = list.files(pattern = ".tif$") 

Note 2: Priorities refer to the highest (level: 1) to lowest (level: 100) valuable areas for Camellia replacement to achieve benefits.

Note 3: software's license for use is RStudio (https://posit.co/download/rstudio-desktop/).
