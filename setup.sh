#!/bin/bash

# Install necessary dependencies
sudo apt-get update
sudo apt-get install -y wget unzip xvfb libxi6 libgconf-2-4 libnss3 libxss1 libappindicator1 libindicator7

# Install Google Chrome (from an updated URL if necessary)
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt-get install -y ./google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb

# Install ChromeDriver based on the installed Chrome version
CHROME_VERSION=$(google-chrome --version | grep -oP '\d+\.\d+\.\d+')
DRIVER_VERSION=$(curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE_$CHROME_VERSION)
wget -N https://chromedriver.storage.googleapis.com/$DRIVER_VERSION/chromedriver_linux64.zip
unzip chromedriver_linux64.zip -d /usr/local/bin/
rm chromedriver_linux64.zip

# Set permissions
sudo chmod +x /usr/local/bin/chromedriver

# Set environment variables for Chrome and Chromedriver
export CHROME_BIN=/usr/bin/google-chrome
export CHROME_DRIVER=/usr/local/bin/chromedriver

# Print versions to verify
google-chrome --version
chromedriver --version
