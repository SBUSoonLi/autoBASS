# autoBASS
An automated backup and sync system

Project Description:
The shell script helps to copy and compress files from one directory to another. It includes help functions
for users who are not familiar with the script. It also features a configuration file, for users who
prefers a persistent source and destination folder. The shell script also includes exclusions for users to
exclude particular file types or certain folders. There is also a dry run functionality for users to view what changes
would be made before the shell script is executed. 


How to use:

1. open up terminal(ubuntu)

2. go to the correct directory
(e.g. cd /mnt/c/Repo/autoBASS)

3. Edit archive.conf to change source and destination folder to your liking

4. Edit .bassignore.txt to exclude certain files if you wish

5. Enter ./archive.sh in terminal

6. result.

7. do ./archive.sh -h if you need help or instructions or ./archive.sh -d for dry run


Extra notes:

Make sure the configuration file is converted to UNIX line endings, else the shellscript will not work
You can convert it by typing the following into the terminal:
sed -i 's/\r$//' archive.conf
# or if available:
dos2unix archive.conf


