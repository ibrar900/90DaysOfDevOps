# A function that uses local keyword for variables
# Show that local variables don't leak outside the function
# Compare with a function that uses regular variables

#!/bin/bash

local_demo() {
    local x=10
    echo "x inside function: $x"
}

local_demo

echo "x outside function: $x"


