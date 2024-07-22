#!/bin/bash

# Get the directory of the script
script_dir=$(dirname "$(realpath "$0")")
echo "Script directory: $script_dir"

# Change to the build directory
build_dir="$script_dir/build"
echo "Entering directory: $build_dir"
cd "$build_dir" || { echo "Failed to change to directory: $build_dir"; exit 1; }

# Loop through all directories in the build directory
for folder in */; do
  # Remove the trailing slash from the folder name
  folder_name=$(basename "$folder")

  # Change into the directory
  echo "Entering directory: $build_dir/$folder_name"
  cd "$build_dir/$folder_name" || { echo "Failed to change to directory: $build_dir/$folder_name"; continue; }

  # Run the docker build command
  echo "Building Docker image for folder: $folder_name"
  if ! docker build -t "cngil/samp:$folder_name" .; then
    echo "Failed to build Docker image for folder: $folder_name"
  fi

  # Go back to the build directory
  echo "Returning to directory: $build_dir"
  cd "$build_dir" || { echo "Failed to return to directory: $build_dir"; exit 1; }
done

echo "Docker build process completed for all folders."
