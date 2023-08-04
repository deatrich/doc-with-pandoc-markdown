<!-- -->
# Files Provided With This Project

The files provided with this project can be downloaded from my github area
found at [https://github.com/deatrich/doc-with-pandoc-markdown][myproject].

You can either use *git* to clone the project, or pick up a *zip* file of
the project.

```shell
// Make a directory where you can temporarily put the files
$ mkdir ~/temp
$ cd ~/temp

// If you use git:
$ git clone https://github.com/deatrich/doc-with-pandoc-markdown.git

// Or if you use wget to pick up the zip file:
$ wget -nd \
 https://github.com/deatrich/doc-with-pandoc-markdown/archive/refs/heads/main.zip
$ unzip main.zip

// Or you can also browse to the project web site, click on 'Code' and then
//  click on 'Download ZIP'
//  then move the downloaded file named 'main.zip' to your temporary directory
//  and unzip it.

// You will have a directory named 'doc-with-pandoc-markdown'
$ cd doc-with-pandoc-markdown
```

Let's look at the pertinent files provided with this project and their purpose.

  * [generate-new-guide.sh](#i-script)
  * [Makefile](#i-make)
  * [guide-template.md](#i-guide)
  * [chapter-template.md](#i-chapter)
  * [metadata.md](#i-metadata)
  * [contents.txt](#i-filelist)
  * [custom-highlight.theme](#i-theme)
  * [style.css](#i-css)
  * [template.htm](#i-temphtm)
  * [template.latex](#i-temptex)
  * [shell.xml](#i-xml)
  * [shell.vim](#i-vimsyn)
  * [.vimrc.example](#i-vimrc)


[myproject]: https://github.com/deatrich/doc-with-pandoc-markdown

## Shell script: *generate-new-guide.sh* {#i-script}

This shell script will generate a new document area which includes all
the files described in this section, as well as a handful of new files.

Once you have obtained the files as described above, then you can use this
script to set up your work area:

```shell
$ pwd
/home/myname/temp/doc-with-pandoc-markdown-main

$ ./generate-new-guide.sh
USAGE:  generate-new-guide.sh -d SOME_DIR -p FILE_NAME
WHERE:  SOME_DIR     specifies a new, non-existent directory
WHERE:  FILE_NAME    specifies the name of the top document without '.md' ending
Example: ./generate-new-guide.sh -d ~/docs/how-to-guide -p How-to-guide

$ ./generate-new-guide.sh -d ~/docs/pet-project -p pet-project
Done.  Do not forget to modify 'metadata.md'
Please visit /home/myname/docs/pet-project/

// When you are done with the temporary files then delete them:
$ cd
$ rm -rf ~/temp
```

## Useful Tool for Generating Output: *Makefile* {#i-make}

To avoid entering in repetitive and complex commands it is useful
to have a [makefile][make] that runs the commands on your behalf.

Take a careful look at this file.  The generator script edits 
it and sets the correct name for the project's top file. Other
variables that the makefile sets are the pdf and the html viewers.
You should change them if you prefer other viewers.

The rules in this file are mentioned if you ask for help:

```shell
$ make help
make all          -- update all file types
make test         -- modify then run a test target
make html         -- update the html file
make pdf          -- update the pdf file
make showhtml     -- show the html file
make showpdf      -- show the pdf file
make copies       -- push html and pdf copies to generated area
make publish      -- push html and pdf copies to publishing area
make clean        -- clean up generated files

// because the very first rule is 'make all' then when you type
// 'make' it will make all generated files, for example:
$ make
pandoc -s metadata.md ... -c style.css --toc ... -o pandoc-markdown-guide.html
pandoc -s metadata.md ... --pdf-engine=xelatex -o pandoc-markdown-guide.pdf

// you can clean up the generated files at any time:
$ make clean
rm -i *.html *.pdf
rm: remove regular file 'pandoc-markdown-guide.html'? y
rm: remove regular file 'pandoc-markdown-guide.pdf'? y
```

[make]: https://en.wikipedia.org/wiki/Make_(software)

## Markdown files

There are two markdown files which you can copy to other filenames:

### Template for the top-level document: *guide-template.md* {#i-guide}

This file's sole purpose is the act as the place holder for your named 
document.  In the example above you specified that the document's name
would be *pet-project*.  The script which set up your work area simply
copied *guide-template.md* to *pet-project.md*.  Do not bother editing
this file, since it is just used by the Makefile as the target name when
generating output files.

### Template for a new chapter or section: *chapter-template.md* {#i-chapter}

When creating new markdown files which are part of your project you can
copy *chapter-template.md* to your new file.  This file has skeleton
markdown lines in it.

### Metadata needed by Pandoc: *metadata.md* {#i-metadata}

The 'metadata' file is used by *pandoc* to fill in some variables used
when generating documents.  Most but not all of the metadata are used when
generating pdf output.  Some variables like 'lastupdate' are auto-generated,
so you do not need to change that value.

A note at the top of the file reminds you to change the *title*, *author*
and *date* (date is the initial creation date).

## Ordered List of Files for Pandoc: *contents.txt* {#i-filelist}

When you start a documentation project it might end of large, with many
chapters or sections in it.  It is annoying to edit one big file.  Instead
it is more manageable if you create one file per chapter for example.

The purpose of *contents.txt* is to simply list the chapters or sections
by filename.  They must be listed in the order you expect to find them
in your document.  Note that *metadata.md* must be the first file.

The 'Makefile' will get the list of markdown files from this file, and
pass the list to the *pandoc* program.

##

### *custom-highlight.theme* {#i-theme}

### *style.css* {#i-css}

### *template.htm* {#i-temphtm}
### *template.latex* {#i-temptex}

### *shell.xml* {#i-xml}

## Editor files for *vim*/*gvim*

### Highlighting Syntax for 'shell' Output:  *shell.vim* {#i-vimsyn}

### Example **~/.vimrc** Configuration File: *.vimrc.example* {#i-vimrc}


<!--
```shell
```
 -->
