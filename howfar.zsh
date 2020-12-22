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
            "033[01;35mTUJUAN ASAL  :033[01;33m " + .origin_addresses?[0] + "\n",
            "033[01;35mTUJUAN AKHIR :033[01;33m " + .destination_addresses?[0] + "\n",
            "033[01;35mJARAK        :033[01;33m " + .rows?[0].elements?[0].distance.text + "\n",
            "033[01;35mDURASI       :033[01;33m " + .rows?[0].elements?[0].duration.text' \
        | sed 's/\"//g' | sed 's/hours/jam/g' | sed 's/hour/jam/g' \
        | sed 's/mins/menit/g' | sed 's/min/menit/g' | sed 's/\033/\\033/g')
    GOOGLE_MAP_API="${GOOGLE_MAP_URL}directions/json?origin=${ORIGIN}&destination=${DESTINATION}&key=${GOOGLE_MAP_APIKEY}"
    echo "\n "
    echo $(curl -s "${GOOGLE_MAP_API}" \
        | jq '.routes?[0].legs?[0].steps?' \
        | jq '.[]? | ["# 033[01;35m" + .distance.text + "
            | 033[0;35m" + .duration.text + "
            | 033[0;30m" + .html_instructions]
            | @tsv' \
        | sed 's/<b*>//g' | sed 's/<\/b>//g' | sed 's/<div[^>]*>/\ /g' \
        | sed 's/<[^>]*>//g' | sed 's/\\t/\n/g' \
        | sed 's/&nbsp;//g' | sed 's/\"//g' | sed 's/\//\n\‚Äì\‚Äì\ /g' | sed 's/\\\\\\//g') \
        | sed 's/\#/\n/g' | sed 's/\‚Äì\‚Äì/\n\t\t\ \‚Äì\‚Äì/g' \
        | sed 's/([^>]*)//g' | sed 's/\033/\\033/g' \
        | sed 's/hours/jam/g' | sed 's/hour/jam/g' | sed 's/mins/menit/g' | sed 's/min/menit/g' \
        | sed 's/\|/\t/g' | sed '1s/^/\ JARAK\tDURASI\tARAHAN\n/' \
        | sed 's/Head\ /Jalan\ ke\ /g' \
        | sed 's/\ east\ /\ timur\ /g' | sed 's/\ west\ /\ barat\ /g' \
        | sed 's/\ north\ /\ utara\ /g' | sed 's/\ south\ /\ selatan\ /g' \
        | sed 's/Turn/Belok/g' | sed 's/left/kiri/g' \
        | sed 's/right/kanan/g' | sed 's/after/setelah/g' \
        | sed 's/Parts\ of\ this\ road\ may\ be\ closed\ at\ /Jalan\ mungkin\ ditutup\ /g' \
        | sed 's/\ certain\ times\ or\ days/\ dijam\-jam\ tertentu,/g' \
        | sed 's/Continue/Terus/g' | sed 's/may\ be/mungkin/g' \
        | sed 's/Signs/petunjuk/g' | sed 's/turns/belok/g' | sed 's/turn/belok/g' \
        | sed 's/Destination\ will\ be/tujuan\ ada\ /g' | sed 's/the//g' \
        | sed 's/to\ follow/ikuti/g' | sed 's/follow/ikuti/g' \
        | sed 's/Pass\ by/lewat/g' | sed 's/toward/ke\ arah/g' \
        | sed 's/straight/lurus/g' | sed 's/slightly/sedikit/g' \
        | sed 's/to\ stay/tetap/g' | sed 's/\ to\ /\ ke\ /g' \
        | sed 's/onto/ke/g' | sed 's/\ on\ /\ di\ /g' \
        | sed 's/\ at\ /\ di\ /g' | sed 's/fork/persimpangan/g' > /tmp/distance.tsv
    echo "$(tabs 12; cat /tmp/distance.tsv)"
}

checkjq
howfar
