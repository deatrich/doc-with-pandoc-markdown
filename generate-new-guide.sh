#!/bin/bash
###############################################################################
# PURPOSE:	Given a non-existent directory and a document/guide name
#		 then this script will create the directory and copy and modify
#		 files needed to start creating a new markdown-based document.
#
# AUTHOR:	DCD
# LAST MOD:	$Author$ : $Date$
# DATE:		July 2023
#
# RETURNS:	0  - OK
#		1  - FAIL
#
# EXAMPLE:	./generate-new-guide.sh -d ~/doc/my-project -f my-guide.md
#
# CHANGES:	$Log$
# NOTE:		This script won't work if you have spaces in your directory
#		or your filename.
###############################################################################
#set -v		# debugging tools
#set -x

unalias -a
PATH="/bin:/usr/bin"

cmd=$(basename $0)
dbg=""
usagestr="
USAGE:\t$cmd -d SOME_DIR -n FILE_NAME
WHERE:\tSOME_DIR\tspecifies a new, non-existent directory
WHERE:\tFILE_NAME\tspecifies the name of a document ending in '.md'
Example: ./$cmd -d ~/docs/how-to-guide -n How-to-guide.md"

function err_exit( ) {
  echo -e "$cmd: $1"
  exit 1
}

## function that prints out a usage string and exits abnormally
usage() {
  err_exit "$usagestr"
}

dir=""
file=""
while [ $1 ] ; do
  case $1 in
    -h) usage ;; 
    -d) shift; dir="$1" ;; 
    -f) shift; file="$1" ;; 
     *) usage;;
  esac
  shift
done

if [ "$dir" = "" -o "$file" = "" ] ; then
  usage
fi

echo "$file" | grep -q '.md$'
if [ $? -ne 0 ] ; then
  err_exit "File name '$file' must end in '.md'"
fi

if [ -d "$dir" ] ; then
  err_exit "Directory '$dir' already exists"
fi

if [ ! -f Makefile ] ; then
  err_exit "You need to be in the original project directory for this to work"
fi

files="chapter-template.md custom-highlight.theme guide-template.md Makefile"
files=$files" metadata.md shell.xml style.css template.htm template.latex"

#modfiles="Makefile"

for f in $files ; do
  if [ ! -f $f ]; then
    err_exit "Missing file '$f'"
  fi
done

echo dir is $dir and file is $file
## now we can make the directory, and copy files into place
mkdir "$dir"
if [ $? -ne 0 ] ; then
  err_exit "mkdir '$dir' failed"
fi

for f in $files ; do
  cp -p "$f" "$dir"/
done

## alter Makefile by changing value of 'TARG'
sed -i "s/pandoc-markdown-guide.md/$file/" "$dir"/Makefile
if [ $? -ne 0 ] ; then
  err_exit "Change to Makefile failed"
fi

## truncate contents.txt
echo "metadata.md" >  "$dir"/contents.txt
if [ $? -ne 0 ] ; then
  err_exit "Change to contents.txt failed"
fi

## copy guide-template.md to $file
cp -p $dir/guide-template.md $dir/$file
if [ $? -ne 0 ] ; then
  err_exit "Failed to copy guide-template.md to $dir/$file"
fi

echo "Done.  Do not forget to modify 'metadata.md'"
echo "Please visit $dir/"

