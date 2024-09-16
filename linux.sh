#!/bin/bash

if [[! command -v xdotool &> /dev/null ]];then
	echo "xdotool not installed ..."
	echo "Installing "
	sudo apt install xdotool
fi

declare -A morse=(
    [A]=".-" [B]="-..." [C]="-.-." [D]="-.." [E]="."
    [F]="..-." [G]="--." [H]="...." [I]=".." [J]=".---"
    [K]="-.-" [L]=".-.." [M]="--" [N]="-." [O]="---"
    [P]=".--." [Q]="--.-" [R]=".-." [S]="..." [T]="-"
    [U]="..-" [V]="...-" [W]=".--" [X]="-..-" [Y]="-.--"
    [Z]="--.." [1]=".----" [2]="..---" [3]="...--"
    [4]="....-" [5]="....." [6]="-...." [7]="--..."
    [8]="---.." [9]="----." [0]="-----" [ ]="/"
)

morsecode=""

encode_morse() {
    local input=$1
    input=${input^^}  # Convert to uppercase
    morse_code=""
    for (( i=0; i<${#input}; i++ )); do
        char=${input:$i:1}
        morse_code+="${morse[$char]} "
    done
}


# Function to simulate key presses for Morse code
simulate_morse() {
    local key="Caps_Lock"  # Use Caps Lock to simulate key presses

    for (( i=0; i<${#morse_code}; i++ )); do
        char=${morse_code:$i:1}
        case $char in
            ".")
                xdotool key $key
                sleep 0.5
                xdotool key $key
                sleep 0.5
                ;;
            "-")
                xdotool key $key
                sleep 1
                xdotool key $key
                sleep 1
                ;;
            " ")
                sleep 2
                ;;
            "/")
                sleep 4
                ;;
        esac
        sleep 0.5
    done
}

# Main script
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <text_to_convert>"
    exit 1
fi

text="$1"
encode_morse "$text"
echo $morse_code
simulate_morse
