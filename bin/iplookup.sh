#!/bin/bash

IP=$1
TABLE=$2
ACCESS_KEY=$(cat ./.access_key)
#JSON=$(curl -sS http://api.db-ip.com/v2/free/$IP)
JSON=$(curl -sS http://api.ipstack.com/${IP}?access_key=$ACCESS_KEY)

continent_code=$(echo $JSON | jq .continent_code -r)
continent_name=$(echo $JSON | jq .continent_name -r)
country_code=$(echo $JSON | jq .country_code -r)
country_name=$(echo $JSON | jq .country_name -r)
region_code=$(echo $JSON | jq .region_code -r)
region_name=$(echo $JSON | jq .region_name -r | sed "s#'#\\\'#g")
city=$(echo $JSON | jq .city -r)

zip=$(echo $JSON | jq .zip -r)

latitude=$(echo $JSON | jq .latitude -r)
longitude=$(echo $JSON | jq .longitude -r)

geoname_id=$(echo $JSON | jq .location.geoname_id -r)



echo "\
REPLACE INTO $TABLE 
    (ip, continent_code, continent_name, country_code, country_name, region_code, region_name, city, zip, latitude, longitude, geoname_id) 
VALUES 
    ('$IP', '$continent_code', '$continent_name', '$country_code', '$country_name', '$region_code', '$region_name', '$city', '$zip', '$latitude', '$longitude', '$geoname_id');"
