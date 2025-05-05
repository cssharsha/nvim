#!/bin/bash

# This script sets up the JUPYTER_PATH environment variable for Molten NVim
# Usage: source <(~/.config/nvim/molten_jupyter_path.sh)

# Get the path to the Jupyter kernels
JUPYTER_KERNELS_PATH=$(jupyter kernelspec list | grep -oP "(?<=\s)/[^\s]+(?=/kernel.json)")

# Export the JUPYTER_PATH environment variable
echo "export JUPYTER_PATH=\"$JUPYTER_KERNELS_PATH\""
