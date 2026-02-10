# A function to print hostname and OS info
# A function to print uptime
# A function to print disk usage (top 5 by size)
# A function to print memory usage
# A function to print top 5 CPU-consuming processes
# A main function that calls all of the above with section headers
# Use set -euo pipefail at the top

#!/bin/bash

set -euo pipefail

hostname_info() {
    echo "Hostname: $(hostname)"
    echo "OS: $(cat /etc/os-release | grep PRETTY_NAME | cut -d= -f2 | tr -d '"')"
}

uptime_info() {
    echo "Uptime: $(uptime -p)"
}
    
disk_info() {
    echo "Disk Usage:"
    df -h | head -n 6
}
    
memory_info() {
    echo "Memory Usage:"
    free -h | head -n 6
}
    
process_info() {
    echo "Top 5 CPU-Consuming Processes:"
    top -bn1 | head -n 6
}
    
main() {
    hostname_info
    echo "\n"
    uptime_info
    echo "\n"
    disk_info
    echo "\n"
    memory_info
    echo "\n"
    process_info
}
    
main    
    
