# Script for MVP 
# cd /mnt/c/Users/poopi/OneDrive\ -\ Nanyang\ Technological\ University/Semester\ 3.1\ Exchange/CSE\ 337\ Scripting\ Language/Assignment\ 1

TIMESTAMP=$(date +"%Y%m%d_%H%M%S") #Check the time
echo "INFO: $TIMESTAMP archive script started" >> archive.log
echo "INFO: $TIMESTAMP archive script started"

givehelp() {
    echo "Usage: $0 "
    echo "Edit the source and directory files in the configuration file!"
    echo "Options:"
    echo "  -h, --help       Display help message"
}

if [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
    givehelp
    exit 0
fi

#echo "debug code 0"



#echo "debug code 1"

SOURCEDIRECTORY=$(grep "^source_directory=" archive.conf | cut -d= -f2)
TARGETDIRECTORY=$(grep "^target_directory=" archive.conf | cut -d= -f2)

echo "Source Directory: $SOURCEDIRECTORY"
echo "Target Directory: $TARGETDIRECTORY"









#echo "debug code 2"

if [ ! -d "$SOURCEDIRECTORY" ]; then
    echo "Error: $TIMESTAMP Source directory does not exist or could not be created. Exiting" >> archive.log
    exit 1
fi

#echo "debug code 3"

if [ ! -d "$TARGETDIRECTORY" ]; then
    echo "Error: $TIMESTAMP Target directory does not exist or could not be created. Exiting" >> archive.log
    exit 1
fi

#echo "debug code 4"



echo "INFO: $TIMESTAMP Backing up from '$SOURCEDIRECTORY' to '$TARGETDIRECTORY'." >> archive.log

BACKUP_FOLDER="$TARGETDIRECTORY/backup_$TIMESTAMP.tar.gz" #Create a backup folder name
mkdir -p "$BACKUP_FOLDER" #Create the backup folder
cp -r "$SOURCEDIRECTORY" "$BACKUP_FOLDER" #Copy the source directory to the backup folder


# Compress the backup folder into a .tar.gz file
tar -czvf "$BACKUP_FOLDER.tar.gz" -C "$BACKUP_FOLDER" .

# Check the exit status of the tar command
if [ $? -ne 0 ]; then
    echo "Error: $TIMESTAMP BACKUP FAILED DURING COMPRESSION." >> archive.log
    exit 1
fi

#remove the uncompressed backup folder
rm -rf "$BACKUP_FOLDER"


echo "INFO: $TIMESTAMP Backup of '$SOURCEDIRECTORY' completed successfully in '$BACKUP_FOLDER'." >> archive.log
exit 0