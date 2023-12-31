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
# EXAMPLE:	./generate-new-guide.sh -d ~/doc/my-project -t my-guide
#
# CHANGES:	$Log$
# NOTE:		This script won't work if you have spaces in your directory
#		or your top file/project name.
###############################################################################
#set -v		# debugging tools
#set -x

unalias -a
PATH="/bin:/usr/bin"

cmd=$(basename $0)
dbg=""
usagestr="
USAGE:\t$cmd -d SOME_DIR -t FILE_NAME
WHERE:\tSOME_DIR\tspecifies a new, non-existent directory
WHERE:\tFILE_NAME\tspecifies the name of the top document without '.md' ending
Example: ./$cmd -d ~/docs/how-to-guide -t How-to-guide"

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
    -t) shift; file="$1" ;; 
     *) usage;;
  esac
  shift
done

if [ "$dir" = "" -o "$file" = "" ] ; then
  usage
fi

echo "$file" | grep -q '.md$'
if [ $? -eq 0 ] ; then
  err_exit "Top filename '$file' must not end in '.md'"
fi

if [ -d "$dir" ] ; then
  err_exit "Directory '$dir' already exists"
fi

if [ ! -f Makefile ] ; then
  err_exit "You need to be in the original project directory for this to work"
fi

## Check to see if ../console-syntax/ directory is there; and then copy 
##  the needed console.xml and editor files

c="../console-syntax"
if [ ! -d $c ] ; then
  err_exit "'$c' directory is missing.  Please clone or copy it"
else
  \cp -vp $c"/console.xml" $c"/vim.ftdetect" $c"/vim.syntax" $c"/vimrc.example" .
  if [ $? -ne 0 ] ; then
    err_exit "copy of xml and editor files in '$c' failed"
  fi
fi

files="custom-highlight.theme metadata.md Makefile"
files=$files" console.xml style.css template.htm template.latex"
files=$files" Makefile.project custom-reference.docx overview.md"

editorfiles="vim.syntax vim.ftdetect vimrc.example"

md_templates="guide-template.md chapter-template.md"

scriptfiles="generate-table.sh"

#modfiles="Makefile"

for f in $files ; do
  if [ ! -f $f ]; then
    err_exit "Missing file '$f'"
  fi
done

## now we can make the directory, and copy files into place
mkdir -p "$dir"
if [ $? -ne 0 ] ; then
  err_exit "mkdir '$dir' failed"
fi

mkdir -p "$dir/editorfiles"
if [ $? -ne 0 ] ; then
  err_exit "mkdir '$dir/editorfiles' failed"
fi

mkdir -p "$dir/scriptfiles"
if [ $? -ne 0 ] ; then
  err_exit "mkdir '$dir/scriptfiles' failed"
fi

mkdir -p "$dir/md_templates"
if [ $? -ne 0 ] ; then
  err_exit "mkdir '$dir/md_templates' failed"
fi

for f in $files ; do
  cp -p "$f" "$dir"/
  if [ $? -ne 0 ] ; then
    err_exit "copy of '$f' to $dir/ failed"
  fi
done

for f in $editorfiles ; do
  cp -p "$f" "$dir/editorfiles"/
  if [ $? -ne 0 ] ; then
    err_exit "copy of '$f' to $dir/editorfiles/ failed"
  fi
done

for f in $scriptfiles ; do
  cp -p "$f" "$dir/scriptfiles"/
  if [ $? -ne 0 ] ; then
    err_exit "copy of '$f' to $dir/scriptfiles/ failed"
  fi
done

for f in $md_templates ; do
  cp -p "$f" "$dir/md_templates"/
  if [ $? -ne 0 ] ; then
    err_exit "copy of '$f' to $dir/md_templates/ failed"
  fi
done

## alter Makefile.project by changing value of 'PROJECT'
sed -i "s/doc-with-pandoc-markdown/$file/" "$dir"/Makefile.project
if [ $? -ne 0 ] ; then
  err_exit "Change to Makefile.project failed"
fi

## truncate contents.txt
echo "metadata.md" >  "$dir"/contents.txt
echo "overview.md" >>  "$dir"/contents.txt
if [ $? -ne 0 ] ; then
  err_exit "Change to contents.txt failed"
fi

## copy guide-template.md to top file
destfile=$file".md"
cp -p $dir/md_templates/guide-template.md $dir/$destfile
if [ $? -ne 0 ] ; then
  err_exit "Failed to copy md_templates/guide-template.md to $dir/$destfile"
fi

echo "Done.  Do not forget to modify 'metadata.md' and possibly 'Makefile.project'"
echo "Please visit $dir/"

