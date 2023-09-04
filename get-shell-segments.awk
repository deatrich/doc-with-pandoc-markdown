#!/usr/bin/awk -f

###############################################################################
# PURPOSE:      Print out commands found inside Markdown 'console' sessions.
#
# AUTHOR:       DCD
# DATE:         September 2023
#
# RETURNS:      0  - OK
#               1  - FAIL
#
# EXAMPLE:      ./get-shell-segments.awk SOME_FILE.md
#
# NOTE:         
###############################################################################

BEGIN {
  count = 0;
  insegment = 0;
  commmands = 0;
  sudos = 0;
}

{
  ## if we are inside a console then set 'insegment' to true
  if( $0 ~ /^```console$/ ) {
    if( ! insegment ) {
      count = count +1;
      insegment = 1;
    }
  }
  else {
    if( $0 ~ /^```$/ ) {
      ## then we are no longer in a console segment; set the var to false
      insegment = 0;
    }
    else {
      if( insegment ) {
        ## look for the '$ ' or the '# ' prompt at the beginning of a line
        if( $0 ~ /^[\$#][ ]/ ) {
          ## in case the first command is 'sudo' then count and remove it:
          if( $0 ~ /^[\$#] sudo / ) {
            sudos = sudos + 1;
            sub( /sudo /, "", $0 );
          }
          commands = commands + 1;

          ## Here we watch for environment variables in front of commands
          ## For example:  TZ='America/Vancouver' date
          if( $2 ~ /=/ ) {

            ## too few words so we throw this command out
            if( NF <= 2 ) {
              commands = commands - 1;
            }
            else {
              ## we pick the 3rd word
              printf( "%s\n", $3 );
            }
          }
          else {
            ## this was some strange output I had at one time to be ignored:
            if( $2 ~ /<TAB>/ ) {
              commands = commands - 1;
            }
            else {
              printf( "%s\n", $2 );
            }
          }
        }
      }
    }
  }
}

#END {
#  printf( "Number of shell segments is %i\n", count );
#  printf( "Number of commands is %i\n", commands );
#  printf( "Number of sudo commands is %i\n", sudos );
#}

