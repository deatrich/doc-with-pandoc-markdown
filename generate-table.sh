#!/bin/bash
###############################################################################
# PURPOSE:	Print out an empty table using the specified number of
#		rows and columns fitting into the specified table width
#		in characters, with the specified height of each column.
#		The table is suitable for use in a markdown file.
#
# AUTHOR:	DCD
# DATE:		Aug 2023
#
# RETURNS:	0  - OK
#		1  - something bad happened .. see the script output
#
###############################################################################
#set -v		# debugging tools
#set -x

unalias -a
PATH="/bin:/usr/bin"

cmd=`basename $0`
usagestr="
USAGE:\t$cmd -w WIDTH -rh ROWHEIGHT -r ROWS -c COLUMNS -header [yes|no]
WHERE:\tWIDTH\tis the table width in number of characters wide
WHERE:\tROWHEIGHT\tis the number of characters high for each row
WHERE:\tROWS\tis the number of table rows
WHERE:\tCOLUMNS\tis the number of table columns
Example: ./$cmd -r 4 -c 3  -w 70 -rh 3 -header yes"

function err_exit( ) {
  echo -e "$cmd: $1"
  exit 1
}

## function that prints out a usage string and exits abnormally
function usage( ) {
  err_exit "$usagestr"
}

## default values; integer variables will only accept integer values,
## so any other string will set the variable to a value of 0
typeset -i width rows columns rheight cwidth
width=60
rheight=5
rows=2
columns=2

header="no"
tab=""

## print a header row separator
function printheader( ) {
  tab="$tab""|"
  for j in `seq 1 $columns` ; do
    for i in `seq 1 $cwidth` ; do
      tab="$tab"" "
    done
    tab="$tab""|"
  done
  tab="$tab""\n"

  tab="$tab""+"
  for j in `seq 1 $columns` ; do
    for i in `seq 1 $cwidth` ; do
      tab="$tab""="
    done
    tab="$tab""+"
  done
  tab="$tab""\n"
}

## print a border row
function printborder( ) {
  tab="$tab""+"
  for j in `seq 1 $columns` ; do
    for i in `seq 1 $cwidth` ; do
      tab="$tab""-"
    done
    tab="$tab""+"
  done
  tab="$tab""\n"
}

## print an empty row
function printemptyrow( ) {
  tab="$tab""|"
  for j in `seq 1 $columns` ; do
    for i in `seq 1 $cwidth` ; do
      tab="$tab"" "
    done
    tab="$tab""|"
  done
  tab="$tab""\n"
}

while [ $1 ] ; do
  case $1 in
    -h) usage ;; 
    -w) shift; width=$1 ;; 
    -r) shift; rows=$1 ;; 
    -c) shift; columns=$1 ;; 
    -rh) shift; rheight=$1 ;; 
    -header) shift; header=$1 ;;
     *) usage;;
  esac
  shift
done

## validate all input values

if [ "$header" != "yes" ] ; then
  header="no"
fi

if [ $rheight -lt 1 ] || [ $rheight -gt 10 ] ; then
  rheight=5
  echo "Row height (-rh) must be >= 1 and <= 10; setting it to $rheight"
fi
if [ $rows -lt 1 ] || [ $rows -gt 10 ] ; then
  rows=2
  echo "Number of rows (-r) must be >= 1 and <= 10; setting it to $rows"
  
fi
if [ $columns -lt 1 ] || [ $columns -gt 10 ] ; then
  columns=2
  echo "Number of columns (-c) must be >= 1 and <= 10; setting it to $columns"
fi
if [ $width -lt 5 ] || [ $width -gt 100 ] ; then
  width=70
  echo "Table width (-w) must be >= 5 and <= 100; setting it to $width"
fi
cwidth=$width/$columns
if [ $cwidth -lt 4 ] ; then
  err_exit "Column width is too small: $width chars wide with $columns columns"
fi

## print out an empty table
printborder
if [ $header = "yes" ] ; then
  printheader
fi
for m in `seq 1 $rows` ; do
  for k in `seq 1 $rheight` ; do
    printemptyrow
  done
  printborder
done
echo -e "$tab"

