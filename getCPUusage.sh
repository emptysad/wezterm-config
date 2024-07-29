#!/bin/bash
# This script monitors CPU and memory usage

# Get the current usage of CPU and memory
cpuUsage=$(top -bn1 | awk '/Cpu/ { print 100-$8}')
# Print the usage
echo -n "$cpuUsage"
