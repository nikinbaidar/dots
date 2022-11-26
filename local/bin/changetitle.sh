#! /bin/bash
# Function Definitions:

function changeTrackTitle() {
    echo -n "Enter the track title or press enter to skip:"
    read title

    if ! [ -z ${title} ] ; then
        mid3v2 --song "${title}" "${1}"
    else
        title="$(basename -s .mp3 ${file})"
        mid3v2 --song "${title}" "${1}"
        title=0
    fi
}

function changeTrackNumber() {
    echo -n "Enter the track number or press enter to skip:"
    read track_num

    if ! [ -z ${track_num} ] ; then
        mid3v2 --track "${track_num}" "${1}"
    fi
}

function changeArtistandAlbum() {

    function sort_array() {
        local -n arr=${1}
        length=${#arr[@]}

        for (( i=0 ; i < ${length} ; i++ ))
        do
            for (( j=i+1 ; j < ${length} ; j++  ))
            do
                if [ ${arr[$i]} -gt ${arr[j]} ]
                then
                    temp=${arr[$i]}
                    arr[$i]=${arr[$j]}
                    arr[$j]=${temp}
                fi
            done
        done
    }

    function popElements() {
        for (( k = 0 ; k < ${#indexes_to_pop[@]} ; k++ ))
        do
            length=${#tracks[@]}
            popIndex=$(( ${indexes_to_pop[$k]} - ${k} ))
            unset tracks[${popIndex}]
            # After deleting an element shift all elements from the empty spot,
            # once place to the left, skip if the last element was deleted.
            if (( ${popIndex}+1 != ${length} )) ; then
                for (( j=${popIndex} + 1; j < ${length} ; j++ ))
                do
                    tracks[$popIndex]=${tracks[$j]}
                    (( popIndex++ ))
                done
                unset tracks[-1]
            fi
        done

        unset indexes_to_pop
    }

    function acquireNames() {
        declare -g album
        declare -g artist

        echo -n "Enter the album name (Default: Greatest Hits):"
        read album

        if [ -z ${album} ] ;then
            album="Greatest Hits"
        else
            declare -g year
            echo -n "Enter the year in which '${album}' was released:"
            read year
        fi

        echo -n "Enter the artist name or Press enter to skip:"
        read artist
        if [ -z ${artist} ] ; then
            unset artist
        fi

    }

    length=${#tracks[@]}
    printf "\e[01;37m:: There are ${length} files under selection:\e[00;37m\n"

    # Display all files under selection:
    for (( i = 0 ; i < ${length} ; i++ ))
    do
        echo "   ${i}) ${tracks[$i]}"
    done
    printf "\n\e[01;37m:: Select Files:\e[00;37m\n"

    echo -e "\t1) Enter the indexes of tracks for which you wish to set the " \
    "album and artist names for. Separate each index with a single white " \
    "space 2) Press 'a' to select all tracks 3) Press 'v' to individually " \
    "set artist and album names.\n"

    echo -n "Enter your choice (default v): ==>"; read indexes

    if [[ -z ${indexes} || ${indexes} = v ]]
    then
        for item in "${tracks[@]}"
        do
            printf "\nCurrent Selection is: \e[00;31m${item}\e[00;37m\n"
            acquireNames

            [[ ! -z ${artist} ]] && mid3v2 --artist "${artist}" "${item}"
            [[ ! -z ${year} ]] && mid3v2 --year "${year}" "${item}"
            mid3v2 --album "${album}" "${item}"
        done

        IFS=${IFS_OLD}
        exit 111;
    else
        acquireNames
    fi

    if [ ${indexes} = a ]
    then
        for item in "${tracks[@]}"
        do
            [[ ! -z ${artist} ]] && mid3v2 --artist "${artist}" "${item}"
            [[ ! -z ${year} ]] && mid3v2 --year "${year}" "${item}"
            mid3v2 --album "${album}" "${item}"
        done

        IFS="${IFS_OLD}"
        exit 111;
    fi

    declare -a indexes_to_pop

    count=0
    IFS=$' '

    for i in ${indexes}
    do
        [[ ! -z ${artist} ]] && mid3v2 --artist "${artist}" "${tracks[i]}"
        [[ ! -z ${year} ]] && mid3v2 --year "${year}" "${tracks[i]}"
        mid3v2 --album "${album}" "${tracks[i]}"

        indexes_to_pop[${count}]=$i
        (( count++ ))
    done

    # Sort the array "indexes_to_pop" in ascending order
    sort_array indexes_to_pop

    IFS=$'\n'

    popElements
}

# Main
cd ~/music

# Varibale Declarations:
declare filename
declare indexes
declare -i track_count
declare -i count

declare -g title
declare -g track_num
declare -g artist
declare -g album

declare -a tracks
declare -a indexes_to_pop

# Initializations:
track_count=0
IFS_OLD=${IFS}
IFS=$'\n'

for file in $(find ./*.mp3 -cmin -"$1")
# for file in $(find ./*.mp3 -iname "slipknot*")
do
    fileName=$(basename "${file}")
    printf "Current Selection is: \e[00;31m${fileName}\e[00;37m\n"
    mid3v2 --delete-frames="TPE1,TSSE,TXXX,COMM" "${file}"
    mid3v2 --list-raw ${file}

    changeTrackTitle "${file}"
    changeTrackNumber "${file}"

    if [[ ${title} = 0 || "${title}" = "$(basename -s .mp3 ${file})"  ]]
    then
        echo -e "Skipping renaming...\n"
        tracks[track_count]=$(basename "${file}")
    else
        mv --interactive "${file}" "${title}".mp3 # prompt before overwriting
        tracks[track_count]="${title}.mp3"
        echo
    fi

    (( track_count++ ))
done

# Setting artist and album names:
while [ ${#tracks[@]} -gt 0 ]
do
    changeArtistandAlbum
done

IFS=${IFS_OLD}
