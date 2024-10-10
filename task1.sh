#!/bin/bash

# Find the PID of the process running infinite.sh
pid=$(ps aux | grep '[i]nfinite.sh' | awk '{print $2}')

# Check if the PID is found
if [ -z "$pid" ]; then
  echo "No infinite.sh process found."
else
  # Kill the process
  kill -9 $pid
  echo "Process infinite.sh with PID $pid has been killed."
fi

