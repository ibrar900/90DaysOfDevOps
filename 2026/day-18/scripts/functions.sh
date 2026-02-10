# A function greet that takes a name as an argument and prints Hello, <name>!
# A function add that takes two numbers as arguments and prints their sum
# A function sub that takes two numbers as arguments and prints their difference
# A function mul that takes two numbers as arguments and prints their product
# A function div that takes two numbers as arguments and prints their division

#!/bin/bash

# A function greet that takes a name as an argument and prints Hello, <name>!
greet() {
    echo "Hello, $1!"
}

# A function add that takes two numbers as arguments and prints their sum
add() {
    echo "$1 + $2 = $(( $1 + $2 ))"
}

# A function sub that takes two numbers as arguments and prints their difference
sub() {
    echo "$1 - $2 = $(( $1 - $2 ))"
}

# A function mul that takes two numbers as arguments and prints their product
mul() {
    echo "$1 * $2 = $(( $1 * $2 ))"
}

# A function div that takes two numbers as arguments and prints their division
div() {
    echo "$1 / $2 = $(( $1 / $2 ))"
}

# Call the functions
greet "ibrar"
add 10 20
sub 10 20
mul 10 20
div 10 20