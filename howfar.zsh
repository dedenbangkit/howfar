#!/bin/zsh

function checkjq() {
    if ! [ -x "$(command -v jq)" ]; then
        echo 'Error: Install jq dulu bro.' >&2
        exit 1
    fi
}

# SEARCH LOCATION BY INPUT
function howfar() {
    KEYWORD=""
    ORIGIN=""
    DESTINATION=""
    DELIM="-"
    GOOGLE_MAP_URL="https://maps.googleapis.com/maps/api/"
    GOOGLE_MAP_API="${GOOGLE_MAP_URL}distancematrix/json?units=metric"
    if [[ $# -eq 0 ]] then
        echo "Dari?"
        read ORIGIN
        echo "Ke?"
        read DESTINATION
    fi
    if [[ $1 != "" ]] then KEYWORD=$(echo $* | sed 's/to/\-/g'); fi
    if [[ $KEYWORD = *"$DELIM"* ]]; then
        MOMD=$(echo $KEYWORD | sed 's/\ -\ /\-/g')
        echo $MOMD | IFS='-' read -r ORIGIN DESTINATION
    else
        echo "Pake delimiter '-' bro!"
        echo "Ok, yang bener dari mana?"
        read ORIGIN
        echo "ke?"
        read DESTINATION
    fi
    ORIGIN=$(echo $ORIGIN | sed 's/\ /+/g')
    DESTINATION=$(echo $DESTINATION | sed 's/\ /+/g')
    echo $(curl -s "${GOOGLE_MAP_API}&origins=${ORIGIN}&destinations=${DESTINATION}&key=${GOOGLE_MAP_APIKEY}" \
        | jq '"\n",
            "033[01;35mORIGIN       :033[01;33m " + .origin_addresses?[0] + "\n",
            "033[01;35mDESTINATION  :033[01;33m " + .destination_addresses?[0] + "\n",
            "033[01;35mDISTANCE     :033[01;33m " + .rows?[0].elements?[0].distance.text + "\n",
            "033[01;35mDURATION :033[01;33m " + .rows?[0].elements?[0].duration.text' \
        | sed 's/\"//g' | sed 's/\033/\\033/g')
    GOOGLE_MAP_API="${GOOGLE_MAP_URL}directions/json?origin=${ORIGIN}&destination=${DESTINATION}&key=${GOOGLE_MAP_APIKEY}"
    echo "\n "
    echo $(curl -s "${GOOGLE_MAP_API}" \
        | jq '.routes?[0].legs?[0].steps?' \
        | jq '.[]? | ["# 033[01;35m" + .distance.text + " | 033[0;35m" + .duration.text + " | 033[0;30m" + .html_instructions] | @tsv' \
        | sed 's/<b*>//g' | sed 's/<\/b>//g' | sed 's/<div[^>]*>/\ /g' \
        | sed 's/<[^>]*>//g' | sed 's/\\t/\n/g' \
        | sed 's/&nbsp;//g' | sed 's/\"//g' | sed 's/\//\n\–\–\ /g' | sed 's/\\\\\\//g') \
        | sed 's/\|/\t/g' | sed '1s/^/\ DISTANCE\tDURATION\tINSTRUCTIONS\n/' \
        | sed 's/\#/\n/g' | sed 's/\–\–/\n\t\t\ \–\–/g' \
        | sed 's/([^>]*)//g' | sed 's/\033/\\033/g' > /tmp/distance.tsv
    echo "$(tabs 12; cat /tmp/distance.tsv)"
}
