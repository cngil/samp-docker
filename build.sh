#!/bin/bash

# Get the current directory
current_dir=$(pwd)
echo "Current directory: $current_dir"

# Change to the bin directory
build_dir="$current_dir/build"
echo "Entering directory: $build_dir"
cd "$build_dir" || exit

# Loop through all directories in the bin directory
for folder in */; do
  # Remove the trailing slash from the folder name
  folder_name=$(basename "$folder")

  # Change into the directory
  echo "Entering directory: $build_dir/$folder_name"
  cd "$build_dir/$folder_name" || continue

  # Run the docker build command
  echo "Building Docker image for folder: $folder_name"
  docker build -t "cngil/samp:$folder_name" .

  # Go back to the bin directory
  echo "Returning to directory: $build_dir"
  cd "$build_dir" || exit
done

echo "Docker build process completed for all folders."