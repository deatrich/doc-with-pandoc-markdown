<!-- -->
# List of Common Linux Commands {#chapter-5}

Because Markdown text is predictable and relatively simple it is possible
to use text processing command-line tools to generate other data that might
be included in the final Markdown document.

Here we reap a list of command-line tools from *console* sessions and present
them in a descriptive list.  Each command is linked back to the chapter in
which it was found.  If a command can be found in more than one chapter then
only the first chapter is linked.  This requires a little discipline in
chapter naming.

If you do not want the chapter links then alter *generate-commands-index.sh*
and set 'links' to **no**.

The two included shell scripts used to generate this list are:

get-shell-segments.awk
:   This small awk program looks for commands inside 'console' fenced code
    for a single Markdown file and prints out each command on a new line.
    
generate-commands-index.sh

:   This bash script finds chapter links if wanted.

    It calls the above awk script for all markdown files in *contents.txt*.

    It then does a unique sort on the list and tries to remove duplicates.

    Finally for each command it checks if they are in the *commands.md* file;
    if not it echoes out the command in definition list format.

It is up to you to add the commands to 'commands.md' yourself, as well as 
a definition for the command.

