#!/bin/bash
clear

PS3="Enter a number: "

echo "Checking for dependencies..."
echo "Checking for stow..."
if ! command -v stow &> /dev/null; then
    echo "Stow not found! Please install it and try again."
    exit 1
fi
echo "Checking for git..."
if ! command -v git &> /dev/null; then
    echo "Git not found! Please install it and try again."
    exit 1
fi
echo "Checking for submodules..."
if [ ! "$(ls -A zsh/powerlevel10k)" ]; then
    echo; echo "The submodules in this repo need to be initialized before you can proceed."
    echo "Initialize the submodules?"
    select choice in "Yes" "No (Quit)"; do
        if [ "$choice" == "Yes" ]; then
            echo "Updating submodules..."; echo
            git submodule update --init --recursive
            break
        elif [ "$choice" == "No (Quit)" ]; then
            echo "Quitting..."
            exit 1
        else
            echo "Invalid selection."; echo
        fi
    done
fi
clear

echo "Obi Shawn Kenobi's"; echo "WSL dotfiles"
echo "https://github.com/shawnkhoffman"
echo "================================="
echo $(basename "$0")
echo "This script will initialize the dotfiles repo."; echo

echo "Repo initialized!"; echo

echo "Would you like to proceed with installing dotfiles?"
select choice in "Yes, start the installer." "No, I will start it manually. (Quit)"; do
    if [ "$choice" == "Yes, start the installer." ]; then
        echo "Running installer.sh..."
        ./installer.sh
        break
    elif [ "$choice" == "No, I will start it manually. (Quit)" ]; then
        echo; echo "OK. When you're ready, run installer.sh in the root of this repo!"
        echo "Quitting..."
        exit 1
    else
        echo "Invalid selection."; echo
    fi
done