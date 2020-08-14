#!/usr/bin/bash

echo "basic"
for i in {1..6}; do curl --location --request GET "http://blueorgreen.marygabry.name/color" --header "type=none"; echo; done

echo "premium"
for i in {1..6}; do curl --location --request GET "http://blueorgreen.marygabry.name/color" --header "type=premium"; echo; done
