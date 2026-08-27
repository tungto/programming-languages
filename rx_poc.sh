## ! /bin/bash     
# city=Casablanca
# curl -s wttr.in/?T --output weather_report

#!/bin/bash

# This checks if the number of arguments is correct
# If the number of arguments is incorrect ( $# != 2) print error message and exit
if [[ $# != 2 ]]
then
  echo "backup.sh target_directory_name destination_directory_name"
  exit
fi

# This checks if argument 1 and argument 2 are valid directory paths
if [[ ! -d $1 ]] || [[ ! -d $2 ]]
then
  echo "Invalid directory path provided"
  exit
fi

# [TASK 1]
targetDirectory="$1"
destinationDirectory="$2"

# [TASK 2]
echo "this is target directory, $targetDirectory"
echo "destinationDirectory, $destinationDirectory"

currentTS=`date +%s`

echo "current timestamp is $currentTS"