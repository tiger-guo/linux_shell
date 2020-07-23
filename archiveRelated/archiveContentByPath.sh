#!/bin/bash
#
# archiveContentByPath - Every hour create an archive
#####################################################################
#
# Set Configuration File(this save file list that is you want to archive)
#
CONFIG_FILE=../data/archiveTest
#
# Set The Project Name that archived content belongs to 
#
PROJECT=testProject
#
# Set Base Archive Destination Lation
#
BASEDEST=/archive/$PROJECT
#
# Gather Current Day, Month & Time
#
DAY=$(date +%d)
MONTH=$(date +%m)
TIME=$(date +%k%M)
#
# Create Archive Destination Directory
#
mkdir -p $BASEDEST/$MONTH/$DAY
#
# Build Archive Destination File Name
#
DESTINATION=$BASEDEST/$MONTH/$DAY/archive$TIME.tar.gz
#
################## My Script ########################################
#
# Check Backup Config file exists
#
if [ ! -f $CONFIG_FILE ]
then 
    echo "$CONFIG_FILE does not exist."
fi
#
# Build the names of all the files to backup
#
FILE_ON=1               # Start on Line 1 of Config File
exec < $CONFIG_FILE         
#
read FILE_NAME
#
while [ $? -eq 0 ]
do
    # Make sure the file or directory exists.
    if [ -f $FILE_NAME -o -d $FILE_NAME ]
    then
        FILE_LIST="$FILE_LIST $FILE_NAME"
    else
        echo "$FILE_NAME,does not exist"
        echo "It is listed on line $FILE_ON of the config file."
    fi
    FILE_ON=$[$FILE_ON + 1]
    read FILE_NAME
done
#
#####################################################################
#
# Backup the files and Compress Archive
#
echo "Start archive..."
#
tar -czf $DESTINATION $FILE_LIST 2> /dev/null
#
echo "Archive completed"
echo "Resulting archive file is: $DESTINATION"
#
exit

