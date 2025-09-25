#!/bin/bash

givehelp() {
    echo "Usage: $0 [source_directory] [target_directory]"
    echo "Options:"
    echo "  -h, --help       Display help message"
}

if [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
    givehelp
    exit 0
fi

if [[ $# -eq 0 ]]; then
    givehelp
    exit 1
fi



SOURCEDIRECTORY=$1
TARGETDIRECTORY=$2

echo "Source Directory: $SOURCEDIRECTORY"
echo "Target Directory: $TARGETDIRECTORY"

if [ ! -d "$SOURCEDIRECTORY" ]; then
    echo "Error: Source directory does not exist."
    exit 1
fi

if [ ! -d "$TARGETDIRECTORY" ]; then
    echo "Error: Target directory does not exist."
    exit 1
fi

TIMESTAMP=$(date +"%Y%m%d_%H%M%S") #Check the time
BACKUP_FOLDER="$TARGETDIRECTORY/backup_$TIMESTAMP" #Create a backup folder name
mkdir -p "$BACKUP_FOLDER" #Create the backup folder
cp -r "$SOURCEDIRECTORY" "$BACKUP_FOLDER" #Copy the source directory to the backup folder

echo "Backup of '$SOURCEDIRECTORY' completed successfully in '$BACKUP_FOLDER'."