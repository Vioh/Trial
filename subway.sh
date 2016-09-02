#!/bin/bash
## Subway script that prints out departure time of the trains ##
#=============================================================================#
# The main idea is to manipulate the HTML file retrieved by CURL cammand.
# - Step 1 is to get the line with all the info/data. This is done with
#	the GREP command where the keyword is "Retning".
# - Step 2 is to divide the trains into EAST and WEST direction. Since each
# 	direction is "tagged" with the word "Retning", this can easily be done
#	with the parameter expansion with the pattern based on "Retning".
# - Step 3 is to print out information from each and every train. Since each
#	train is "tagged" with the word "id", it is best to use the for-loop here.
#=============================================================================#


# Function 'error' receives a string arg, specifying what error it is.
function error {
	echo "ERROR: $1"
	echo "USAGE: $0 <--E|W> <Station:Blindern|Hasle|Forskningsparken>"
	exit
}
[[ $# -gt 2 ]] && error "Too many arguments!"
station="FORSKNINGSPARKEN" #-- default station

# Main loop for checking arguments. 
for arg in $@; do 
	if [[ "${arg^^}" == "--E" || "${arg^^}" == "--W" ]]; then
		flag=${arg^^}
	elif [[ "$arg" == "--*" ]]; then
		error "Invalid flag!"
	else 
		station=${arg^^}
	fi
done

# Setting HTML link (ruter.no) for the station.
case "$station" in
	"FORSKNINGSPARKEN") link="https://ruter.no/reiseplanlegger/Stoppested/(3010370)Forskningsparken%20%5bT-bane%5d%20(Oslo)/Avganger/";;
	"BLINDERN") link="https://ruter.no/reiseplanlegger/Stoppested/(3010360)Blindern%20%5bT-bane%5d%20(Oslo)/Avganger/";;
	"HASLE") link="https://ruter.no/reiseplanlegger/Stoppested/(3011410)Hasle%20%5bT-bane%5d%20(Oslo)/Avganger/";;
	*) error "Unsupported Station!";;
esac

# Step 1 & 2: Retrieve required data.
data=$(curl -s $link | grep -m 1 "Retning")
case "$flag" in 
	"--E") data=${data%Retning*};; #-- Get data for East
	"--W") data=${data##*Retning};; #-- Get data for West
esac

# Step 3: Main loop to print out all the info. 
n=$(echo $data | grep -o "id" | wc -l) #-- Count how many trains there are
echo "Update time: $(date +%T)"
echo "Trains leaving from $station:"
for((i = 0; i < n; i++)); do
	data="${data#*id\":}"
	trainID="${data%%,*}"

	data="${data#*destination\"}"
	dest="${data%%,*}"; dest=$(echo $data | cut -d "\"" -f2)

	data="${data#*departureTime\"}"
	t1="${data%%,*}"; t1=$(echo $data | cut -d "\"" -f2)

	data="${data#*departureTime\"}"
	t2="${data%%,*}"; t2=$(echo $data | cut -d "\"" -f2)
	
	echo "($trainID) $dest --> ($t1, $t2)"
done
