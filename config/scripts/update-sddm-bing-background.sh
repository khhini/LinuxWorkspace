#!/bin/bash

# Define the market (e.g., en-US for US, en-WW for worldwide)
MKT="en-US"
# Path to store the downloaded image
SAVE_DIR="/usr/share/sddm/themes/breeze/" # Adjust 'breeze' to your theme name
IMAGE_NAME="bing_daily.jpg" # Name for your background image

# Get the Bing image URL from the XML API
IMAGE_URL=$(curl -s "https://www.bing.com/HPImageArchive.aspx?format=xml&idx=0&n=1&mkt=$MKT" | xmllint --xpath "string(//image/urlBase)" -)
FULL_IMAGE_URL="https://www.bing.com${IMAGE_URL}_1920x1080.jpg" # Adjust resolution as needed

# Download the image
sudo curl -s -o "$SAVE_DIR$IMAGE_NAME" "$FULL_IMAGE_URL"

# Ensure correct permissions for SDDM
sudo chmod 644 "$SAVE_DIR$IMAGE_NAME"
