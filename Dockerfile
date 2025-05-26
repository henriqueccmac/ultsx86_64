# Dockerfile

# Use Ubuntu 24.04 LTS as the base image
FROM ubuntu:24.04

# Set environment variables for non-interactive apt installations
ENV DEBIAN_FRONTEND=noninteractive

# Update package lists and install necessary tools
# - gdb: The GNU Debugger
# - gcc: The GNU C Compiler (also pulls in g++)
# - binutils: Essential utilities for working with binary files (objdump, strings, readelf, etc.)
# - nasm: The Netwide Assembler
# - vim-common: Contains 'xxd' for hex dumps (useful for reverse engineering)
# - procps: Contains 'ps', 'top', etc. (useful for process monitoring)
# - build-essential: Metapackage for essential tools for compiling C/C++ programs
# - curl: For downloading files
# - wget: For downloading files
# - git: Version control
RUN apt update && \
    apt install -y \
    gdb \
    gcc \
    binutils \
    nasm \
    vim-common \
    procps \
    build-essential \
    curl \
    wget \
    git && \
    rm -rf /var/lib/apt/lists/*

# Set the default command when the container starts (opens a bash shell)
CMD ["bash"]

