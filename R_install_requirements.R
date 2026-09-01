

# install_packages.R
packages <- c(
  "tidyverse",
  "igraph",
  "stringr",
  "data.table",
  "forcats",
  "RColorBrewer",
  "readxl",
  "patchwork",
  "dplyr",
  "ggplot2",
  "ggtext",
  "gggenes",
  "tidytree",
  "ggnewscale",
  "ggfittext"
)



# Install packages if not already installed
install_if_missing <- function(pkg) {
  if (!require(pkg, character.only = TRUE)) {
    install.packages(pkg)
  }
}

invisible(lapply(packages, install_if_missing))

if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("ggtree")
BiocManager::install("ggtreeExtra")

# Optional: Print installed versions
message("Installed packages:")
print(sessionInfo())


