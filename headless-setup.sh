#!/bin/bash

LOG=headless-setup.log

# Setup some colors for nice output.
RED() { echo -e -n "\033[8;91m$*"; }
BLUE() { echo -e -n "\033[8;36m$*"; }
GREEN() { echo -e -n "\033[8;32m$*"; }
RESET() { echo -e -n "\033[0m$*"; }
echo "################################################################" > $LOG
echo "#### Begin firestorm headless setup ############################" >> $LOG
echo "################################################################" >> $LOG
GREEN
echo "################################################################"
echo "Setting up the server for running headless firefox vi selenium."
echo "Logs will be written to $LOG"
echo "################################################################"
RESET
BLUE
echo "Updating apt sources."
RESET
sudo apt-get update >> $LOG 2>&1

BLUE
echo "Installing ruby and development tools."
RESET
sudo apt-get install -y ruby ruby-dev build-essential >> $LOG 2>&1

BLUE
echo "Installing firefox."
RESET
sudo apt-get install -y firefox >> $LOG 2>&1

BLUE
echo "Installing xfvb, fonts and other stuff to make selenium work."
RESET
sudo apt-get -y install xvfb gtk2-engines-pixbuf >> $LOG 2>&1
sudo apt-get -y install xfonts-cyrillic xfonts-100dpi xfonts-75dpi xfonts-base xfonts-scalable >> $LOG 2>&1

BLUE
echo "Installing imagemagick for screenshots.. not necessary, but cool."
RESET
# Optional but nifty: For capturing screenshots of Xvfb display:
sudo apt-get -y install imagemagick x11-apps >> $LOG 2>&1

BLUE
echo "Installing the seleium-webdriver gem"
RESET
sudo gem install 'selenium-webdriver' >> $LOG 2>&1

BLUE
echo "Installing geckodriver for driving firefox."
RESET
wget https://github.com/mozilla/geckodriver/releases/download/v0.16.0/geckodriver-v0.16.0-linux64.tar.gz >> $LOG 2>&1
tar -zxvf geckodriver-v0.16.0-linux64.tar.gz >> $LOG 2>&1
sudo mv geckodriver /usr/local/bin/ >> $LOG 2>&1

GREEN
echo "System set up to run headless firefox via selenium!"
RESET
