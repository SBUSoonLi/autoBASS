# Script for MVP 
# cd /mnt/c/Users/poopi/OneDrive\ -\ Nanyang\ Technological\ University/Semester\ 3.1\ Exchange/CSE\ 337\ Scripting\ Language/Assignment\ 1

TIMESTAMP=$(date +"%Y%m%d_%H%M%S") #Check the time
echo "INFO: $TIMESTAMP archive script started" >> archive.log

givehelp() {
    echo "Usage: $0 "
    echo "Edit the source and directory files in the configuration file!"
    echo "Options:"
    echo "  -h, --help       Display help message"
    echo "  -d, --dry-run   Perform a dry run (no actual archive will be created)"
}


DRYRUN=0
if [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
    givehelp
    exit 0
fi

if [ "$1" == "-d" ] || [ "$1" == "--dry-run" ]; then
    DRYRUN=1
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


#check if .bassignore.txt exists and if it contains stuff to exclude
EXCLUDE_OPT=""
if [ -f ".bassignore.txt" ]; then
    EXCLUDE_OPT="--exclude-from=.bassignore.txt"
    echo "INFO: using exclude file .bassignore.txt" >> archive.log
fi


BACKUP_FOLDER="$TARGETDIRECTORY/backup_$TIMESTAMP.tar.gz" #Create a backup folder name

if [ "$DRYRUN" -eq 1 ]; then
    # list files that the script would archive, without actually archiving
    # -c = create, -v = verbose (lists files), -f /dev/null writes to nowhere
    tar -cvf /dev/null $EXCLUDE_OPT -C "$SOURCEDIRECTORY" . || {
        echo "Error: tar failed during dry-run listing." >&2
        exit 1
    }
    echo "DRY RUN complete. No files were written."
    exit 0
fi

echo "INFO: $TIMESTAMP Backing up from '$SOURCEDIRECTORY' to '$TARGETDIRECTORY'." >> archive.log
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