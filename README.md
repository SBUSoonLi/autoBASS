# autoBASS
An automated backup and sync system

How to use:

1. open up terminal(ubuntu)

2. go to the correct directory

3. do ./archive.sh [source directory] [destination directory]

4. result.

5. do ./archive.sh -h if you need help or instructions


Extra notes:

Make sure the configuration file is converted to UNIX line endings, else the shellscript will not work
You can convert it by typing the following into the terminal:
sed -i 's/\r$//' archive.conf
# or if available:
dos2unix archive.conf
