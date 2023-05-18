#!/bin/zsh

if [[ "$OSTYPE" != "darwin"* ]]; then
  echo "No macOS detected!"
  exit 1
fi

start() {
  clear

  echo "========================================================="
  echo " _____            _               ______                 "
  echo "|  __ \          | |             |  ____|                "
  echo "| |  | | ___  ___| | __ _ _ __   | |__   _ ____   __     "
  echo "| |  | |/ _ \/ __| |/ _` | '_ \  |  __| | '_ \ \ / /     "
  echo "| |__| |  __/ (__| | (_| | | | | | |____| | | \ V /      "
  echo "|_____/ \___|\___|_|\__,_|_| |_| |______|_| |_|\_/       "
  echo "                                                         "
  echo "========================================================="
  echo "        !! ATTENTION !!"
  echo "YOU ARE SETTING UP: Declan Environment (macOS)"
  echo "==========================================================="
  echo ""
  echo -n "* The setup will begin in 3 seconds... "

  sleep 3

  echo -n "Times up! Here we start!"
  echo ""

  cd $HOME
}