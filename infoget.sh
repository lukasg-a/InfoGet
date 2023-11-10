#!/bin/bash

green="\e[0;32m\033[1m"
end="\033[0m\e[0m"
red="\e[0;31m\033[1m"
blue="\e[0;34m\033[1m"
yellow="\e[0;33m\033[1m"
purple="\e[0;35m\033[1m"
turquoise="\e[0;36m\033[1m"
gray="\e[0;37m\033[1m"

echo -e "\t ___        __        ____      _   "
echo -e "\t|_ _|_ __  / _| ___  / ___| ___| |_ "
echo -e "\t | || '_ || |_ | _ || |  _ / _ | __|"
echo -e "\t | || | | |  _| (_) | |_| |  __/ |_ "
echo -e "\t|___|_| |_|_|  |___/ |____||___||__|"
echo -e "\t\t${green}By abund4nt${end}"

function helpPanel(){
    echo -e "\n${green}[+]${end} ${gray}Help panel:${end}"
    echo -e "\t${green}-u${end} ${gray}Enter the url${end}"
    echo -e "\t${green}-f${end} ${gray}Filter by extension${end}"
    echo -e "\t\t${red}Example: infoget -u google.cl -f txt${end}"
}

function fuzzRoutes(){
    url="$1"
    echo -e "\n${green}[+]${end} ${gray}Starting passive scanning:${end}\n"
    response=$(curl -s -X GET "https://web.archive.org/cdx/search/cdx?url=*.${url}/*&output=json&fl=original&collapse=urlkey")
    
    if [ -n "$extension" ]; then
        echo "$response" | grep "${extension}" | tr -d '[",]'
    else
        echo "$response" | tr -d '[",]'
    fi
    
    echo -e "\n${green}[+]${end} ${gray}Scanning ${url} completed.${end}\n"
}

declare -i parameter_counter=0

while getopts "u:f:h" arg; do
    case $arg in
        u) url="$OPTARG"; let parameter_counter+=1;;
        f) extension="$OPTARG"; let parameter_counter+=1;;
        h) ;;
    esac
done

if [ $parameter_counter -eq 0 ] ; then
    helpPanel
else
    fuzzRoutes "$url"
fi


