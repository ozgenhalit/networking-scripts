#!/bin/bash

# disk_usage_alert.sh
# Checks disk usage and alerts if any partition exceeds a threshold.

THRESHOLD=80

echo "Checking disk usage..."

while IFS= read -r line; do
    usage=$(echo "$line" | awk '{print $5}' | tr -d '%')
    mount_point=$(echo "$line" | awk '{print $6}')

    if [ "$usage" -ge "$THRESHOLD" ]; then
        echo -e "\033[0;31m[ALERT] $mount_point is at ${usage}% usage!\033[0m"
    else
        echo -e "\033[0;32m[OK] $mount_point is at ${usage}% usage.\033[0m"
    fi
done <<< "$(df -h | grep -vE '^Filesystem|tmpfs|cdrom')"