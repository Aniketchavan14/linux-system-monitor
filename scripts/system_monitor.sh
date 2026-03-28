#!/bin/bash

# =================================================================
# Project: System Health Monitor
# Author: Sonu
# Description: Monitors CPU, RAM, and Disk usage. Logs alerts if 
#              thresholds are exceeded.
# =================================================================

# --- Configuration ---
CPU_THRESHOLD=80
RAM_THRESHOLD=80
DISK_THRESHOLD=90
LOG_FILE="/var/log/system_monitor.log"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

# Ensure the log file exists and is writable
if [ ! -f "$LOG_FILE" ]; then
    touch "$LOG_FILE" 2>/dev/null || LOG_FILE="./system_monitor.log"
fi

echo "--- Health Check Started at $TIMESTAMP ---"

# 1. Check CPU Usage
# Uses 'top' to get idle percentage and subtracts from 100
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
CPU_INT=${CPU_USAGE%.*} # Convert to integer for comparison

if [ "$CPU_INT" -gt "$CPU_THRESHOLD" ]; then
    MESSAGE="[ALERT] High CPU Usage: $CPU_USAGE%"
    echo "$TIMESTAMP $MESSAGE" >> "$LOG_FILE"
    echo "$MESSAGE"
else
    echo "CPU Usage: $CPU_USAGE% (OK)"
fi

# 2. Check RAM Usage
# Uses 'free' to calculate percentage of used memory
RAM_USAGE=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
RAM_INT=${RAM_USAGE%.*}

if [ "$RAM_INT" -gt "$RAM_THRESHOLD" ]; then
    MESSAGE="[ALERT] High RAM Usage: $RAM_INT%"
    echo "$TIMESTAMP $MESSAGE" >> "$LOG_FILE"
    echo "$MESSAGE"
else
    echo "RAM Usage: $RAM_INT% (OK)"
fi

# 3. Check Disk Usage (Root Partition)
DISK_USAGE=$(df / | grep / | awk '{ print $5 }' | sed 's/%//g')

if [ "$DISK_USAGE" -gt "$DISK_THRESHOLD" ]; then
    MESSAGE="[ALERT] High Disk Usage: $DISK_USAGE%"
    echo "$TIMESTAMP $MESSAGE" >> "$LOG_FILE"
    echo "$MESSAGE"
else
    echo "Disk Usage: $DISK_USAGE% (OK)"
fi

echo "--- Health Check Completed ---"
echo ""
