#!/bin/bash
Red=$'\e[1;31m'
Green=$'\e[1;32m'
Blue=$'\e[1;34m'
Reset=$'\e[0m' 

read -p "Enter Your Marks: " Marks

if [[ $Marks -ge 80 ]]
then
    echo "${Green}You Are Pass With 1st class${Reset}"
elif [[ $Marks -ge 60 ]]
then
    echo "${Blue}You Are Pass with 2nd Class${Reset}"
elif [[ $Marks -ge 30 ]]
then
    echo "${Red}You Are Pass With 3rd Class${Reset}"
else
    echo "${Red}SORRY YOU ARE FAIL${Reset}"
fi
