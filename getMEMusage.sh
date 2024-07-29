#!/bin/bash
# This script monitors CPU and memory usage

# Get the current usage of CPU and memory
memUsage=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
# Print the usage
echo -n "$memUsage"
