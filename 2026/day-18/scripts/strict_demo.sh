#!/bin/bash

set -euo pipefail # pipefail

echo "Check set -o pipefail" # pipefail
cat count.txt | grep "total" # pipefail
echo "After failing script running without set -o" # pipefail

echo -e "\n" # new line
echo "Undefined variable -u" # undefined variable
echo $a # undefined variable
echo "After using undefined variable script running without set -u" # undefined variable

echo -e "\n" # new line
echo "Failed command -e" # failed command
mkdir ../scripts
echo "After failing command script running without using -e" # failed command

