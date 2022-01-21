#!/bin/bash

USER=$(git config --get remote.origin.url | grep -Po "(?<=git@github\.com:)(.*?)(?=/.+.git)")
BRANCH=$(git branch --show-current)
function convert_to_importurl {
    input_fname=$1
    output_fname="$(pwd)/output/${1//\.\.\/src\//}"

    echo $input_fname
    cat $input_fname | sed "s/!include \.*/!includeurl https:\/\/raw.githubusercontent.com\/$USER\/C4-PlantumlSkin\/$BRANCH\/build\/output/" > "$output_fname"
}

for file in $(find ../src -type f); do
    convert_to_importurl $file
done
