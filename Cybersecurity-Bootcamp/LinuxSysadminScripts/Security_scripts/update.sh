#!/bin/bash


# Ensure apt has all available updates
apt update -y
# Upgrade all installed packages
apt upgrade -y
# Install new packages, and uninstall any old packages that must be moved to
# install them
apt full-upgrade -y
# Remove unused packages and their associated configuration files
apt autoremove --purge -y
# Perform with a single line of code
apt update -y && apt upgrade -y && apt full-upgrade -y && apt autoremove --purge -y

