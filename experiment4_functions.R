# BDA Experiment 4: Functions with arguments and without arguments in R
# HOW TO RUN ON UBUNTU:
# 1. Install R if needed: sudo apt update && sudo apt install -y r-base
# 2. Open a terminal in the folder containing this file.
# 3. Run: Rscript experiment4_functions.R
# INPUT: No keyboard input is required. The function calls are included below.
# EXPECTED OUTPUT:
# Hello! This function has no arguments.
# Hello, Asha. Your practical is BDA.
# Sum of 10 and 20 = 30

# Function WITHOUT arguments
say_hello <- function() {
  cat("Hello! This function has no arguments.\n")
}

# Function WITH arguments
introduce <- function(name, subject) {
  cat(sprintf("Hello, %s. Your practical is %s.\n", name, subject))
}

# Another example with arguments and a return value
add_numbers <- function(a, b) {
  result <- a + b
  return(result)
}

# Call the functions
say_hello()
introduce("Asha", "BDA")
cat("Sum of 10 and 20 =", add_numbers(10, 20), "\n")
