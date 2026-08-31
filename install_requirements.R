

# install_packages.R
packages <- c(
  "tidyverse",
  "knitr",
  "rmarkdown",
  "ggplot2",
  "dplyr",
  # add all your packages here
  "your_specific_packages"
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


