#!/bin/bash

if [ -z "$1" ]
then
        echo "Usage: ./basicrecon.sh <example.com>"
        exit 1
fi

sudo su

printf "\n---- NMAP -----\n\n" > results

echo "Running Nmap..."

sudo nmap -sC -sV -A -T4 $1

printf "\n----- FFUF -----\n\n" > results

echo "Running ffuf"

ffuf -c -w /home/kali/SecLists/Discovery/Web-Content/dirsearch.txt -u https://$1/FUZZ -o results

echo "Running Whatweb"

whatweb $1 -v >> results

cat results
