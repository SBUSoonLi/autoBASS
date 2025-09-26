# Script for MVP 
# cd /mnt/c/Users/poopi/OneDrive\ -\ Nanyang\ Technological\ University/Semester\ 3.1\ Exchange/CSE\ 337\ Scripting\ Language/Assignment\ 1


TIMESTAMP=$(date +"%Y%m%d_%H%M%S") #Check the time
echo "INFO: $TIMESTAMP archive script started" >> archive.log

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
    echo "Error: $TIMESTAMP Source directory does not exist or could not be created. Exiting" >> archive.log
    exit 1
fi

if [ ! -d "$TARGETDIRECTORY" ]; then
    echo "Error: $TIMESTAMP Target directory does not exist or could not be created. Exiting" >> archive.log
    exit 1
fi



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