<!-- -->
# Installing the project files

## Getting the files

The files provided with this project can be downloaded from these two relevant
projects found on 'github':

   * [https://github.com/deatrich/doc-with-pandoc-markdown][thisproject]
   * [https://github.com/deatrich/console-syntax][console-project]

You can either use *git* to clone the projects, or pick up *zip* files of
the projects.

```console
// Make a directory where you can temporarily put the files
$ mkdir ~/temp
$ cd ~/temp

// If you use git:
$ git clone https://github.com/deatrich/doc-with-pandoc-markdown.git
$ git clone https://github.com/deatrich/console-syntax.git

// If you use zip:
// For the zip files, browse to the project web sites, click on 'Code' and then
//  click on 'Download ZIP'
// Then move each downloaded file named 'main.zip' to your temporary directory
//  and extract, or unzip, its contents.

// You will have a directory named 'doc-with-pandoc-markdown' and another
// named 'console-syntax'
```

## Generating your document working area 

The provided shell script named *generate-new-guide.sh* will generate
a new document area where it copies all of the needed files described in
this section, and it creates the top-level Markdown file.

Once you have obtained the files as described above, then you can use this
script to set up your work area:

```console
$ cd ~/temp/doc-with-pandoc-markdown

$ ./generate-new-guide.sh
USAGE:  generate-new-guide.sh -d SOME_DIR -t FILE_NAME
WHERE:  SOME_DIR     specifies a new, non-existent directory
WHERE:  FILE_NAME    specifies the name of the top document without '.md' ending
Example: ./generate-new-guide.sh -d ~/docs/how-to-guide -t How-to-guide

$ ./generate-new-guide.sh -d ~/docs/pet-project -t pet-project
'../console-syntax/console.xml' -> './console.xml'
'../console-syntax/vim.ftdetect' -> './vim.ftdetect'
'../console-syntax/vim.syntax' -> './vim.syntax'
'../console-syntax/vimrc.example' -> './vimrc.example'
Done.  Do not forget to modify 'metadata.md' and possibly 'Makefile.project'
Please visit /home/myname/docs/pet-project/

// When you are done with the temporary files then delete them if you wish:
$ cd
$ rm -rf ~/temp
```

To test the setup, the generated work area contains an extra Markdown file
(overview.md).  Once you start writing your own markdown files then add them
to the contents.txt file and remove overview.md from the list:

```console
$ cd ~/docs/pet-project/
$ ls
console.xml             editorfiles/      metadata.md     style.css
contents.txt            Makefile          overview.md     template.htm
custom-highlight.theme  Makefile.project  pet-project.md  template.latex
custom-reference.docx   md_templates/     scriptfiles/

$ cat contents.txt
metadata.md
overview.md

// run the 'make' command to generate your documents
$ make
pandoc -s metadata.md overview.md ... -V lastupdate="`date +'%d %B %Y'`" -o pet-project.html
pandoc -s metadata.md overview.md --toc ... -o pet-project.docx
pandoc -s metadata.md overview.md --toc ... --pdf-engine=xelatex -o pet-project.pdf
```

## Files provided with this project

Here is a list of the pertinent files provided with this project and
their purpose.

  * Shell scripts:

     * [generate-new-guide.sh](#i-script)
     * [generate-table.sh](#i-tabscript)

  * Build tools:
     * [Makefile and Makefile.project](#i-make)
     * [contents.txt](#i-filelist)

  * Markdown files:
     * [guide-template.md](#i-guide)
     * [chapter-template.md](#i-chapter)
     * [metadata.md](#i-metadata)
     * [metadata-docx.md](#i-metadata-docx)

  * Pandoc templates affecting document content and presentation:
     * [template.htm](#i-temphtm)
     * [template.latex](#i-temptex)
     * [custom-reference.docx](#i-docxref)

  * Style files:
     * [custom-highlight.theme](#i-theme)
     * [style.css](#i-css)

  * Editor files and syntax definition for console syntax highlighting:
     * [console.xml](#i-xml)
     * [vim.syntax and vim.ftdetect](#i-vimsyn)
     * [vimrc.example](#i-vimrc)

[console-project]: https://github.com/deatrich/console-syntax

### Shell scripts

#### *generate-new-guide.sh* {#i-script}

This is the shell script which generated a new document area for you.

#### *generate-table.sh* {#i-tabscript}

If you find yourself creating tables in Markdown then sometimes it
is useful to start with an empty table.  The included script will 
print out an empty table, using the specified number of rows and columns;
and the table width and the column height in characters.  You should copy
it into your PATH - normally this means you copy it into ~/bin/

```console
$ cp -p /path/to/generate-table.sh ~/bin/
$ chmod 755 ~/bin/generate-table.sh
// We create a table 1 row by 3 columns, 60 chars wide. Row height is 3 chars
$ /generate-table.sh -r 1 -c 3  -w 60 -rh 3 -header yes
+--------------------+--------------------+--------------------+
|                    |                    |                    |
+====================+====================+====================+
|                    |                    |                    |
|                    |                    |                    |
|                    |                    |                    |
+--------------------+--------------------+--------------------+
```

If you are using the Gvim editor, then you can map a control-key sequence
to insert a table into the document by altering your .vimrc file:

```console
$ grep generate-table ~/.vimrc
" call generate-table.sh when Control+Z is pressed:
map <C-z> <esc> !} generate-table.sh -r 4 -c 3  -w 70 -rh 3 -header yes<C-m><esc>
```

### Build tools

#### Control document handling: *Makefile* and *Makefile.project* {#i-make}

To avoid entering in repetitive and complex commands it is useful
to have a [makefile][make] which runs the commands on your behalf.

Take a careful look at these files.  The generator script edits 
Makefile.project and sets the correct name for the project's top file. Other
variables that the makefile includes are the PDF, Office and the HTML viewers.
Change them if you prefer other viewers.

The rules in this file are mentioned if you ask for help:

```console
$ make help
make all          -- update all file types
make test         -- modify then run a test target
make html         -- update the html file
make pdf          -- update the pdf file
make docx         -- update the docx file
make showhtml     -- show the html file
make showpdf      -- show the pdf file
make showdocx     -- show the docx file
make copies       -- push html and pdf copies to generated area
make publish      -- push html and pdf copies to publishing area
make clean        -- clean up generated files

// because the very first rule is 'make all' then when you type
// 'make' it will make all generated files, for example:
$ make
pandoc -s metadata.md ... -c style.css --toc ... -o my-guide.html
pandoc -s metadata.md ... --pdf-engine=xelatex -o my-guide.pdf
pandoc -s metadata.md ... --reference-doc=custom-reference.docx -o my-guide.docx

// you can clean up the generated files at any time:
$ make clean
rm -i *.html *.pdf
rm: remove regular file 'my-guide.html'? y
rm: remove regular file 'my-guide.pdf'? y
rm: remove regular file 'my-guide.docx'? y
```
[make]: https://en.wikipedia.org/wiki/Make_(software)

#### Ordered list of Markdown files: *contents.txt* {#i-filelist}

When you start a documentation project it might end up quite large, with many
chapters or sections in it.  It is annoying to edit one big file.  Instead
it is more manageable if you create, for example, one file per chapter.

The purpose of *contents.txt* is to simply list the chapters or sections
by filename.  They must be listed in the order you expect to find them
in your final document.  Note that *metadata.md* must be the first file.

The 'Makefile' will get the list of Markdown files from this file, and
pass the list to the pandoc program.

### Markdown files

There are two Markdown files which you can copy to other filenames.
They are found in the *md_templates* sub-directory.

#### Template for the top-level document: *guide-template.md* {#i-guide}

This file's sole purpose is the act as the place holder for your named 
top-level document.  In the example above you specified that the document's
name would be *pet-project*.  The script which set up your work area simply
copied *guide-template.md* to *pet-project.md*.  Do not bother editing
this file, since it is just used by the Makefile as the target name when
generating output files.

#### Template for a new chapter or section: *chapter-template.md* {#i-chapter}

When creating new Markdown files which are part of your project you can
copy *chapter-template.md* to your new file instead of starting from scratch.
This file has skeleton Markdown lines in it.

#### Metadata needed by pandoc: *metadata.md* {#i-metadata}

The 'metadata' file is used by pandoc to fill in some variables used
when generating documents.  Most but not all of the metadata are used when
generating PDF output.  Some variables like 'lastupdate' are auto-generated,
so you do not need to change that value.

A note at the top of the file reminds you to change the *title*, *author*
and *date* (date is the initial creation date).

### Files which affect document content and presentation

Pandoc provides template files which control metadata placement and content
ordering for most output formats.  You can get the default template by
asking pandoc for it on the command-line:

```console
// The latex template is used whenever PDF output is generated.
// There is no template for docx, but there is a reference data document.
$ pandoc -D latex > template.latex.default

$ pandoc -D html > template.html.default

$ pandoc --print-default-data-file reference.docx > reference.docx
```

I made a few changes for HTML and for PDF to add a 'Last update' field and
I removed the class for the 'date' value.  As well, for PDF I modified
the latex template to get the table of contents to appear in the bookmarks
of a PDF viewer.

#### *template.htm* {#i-temphtm}

```console
$ cp -p template.html.default template.htm
$ nano template.htm
$ diff template.html.default template.htm 
41,42c41
< <p class="author">$author$</p>
< $endfor$
---
> <p class="author">$author$
44c43,46
< <p class="date">$date$</p>
---
>   <br />Created: $date$
> $endif$
> $if(lastupdate)$
>   <br />Last update: $lastupdate$
45a48,49
> </p>
> $endfor$
```

#### *template.latex* {#i-temptex}

```console
$ cp -p template.latex.default template.latex
$ nano template.latex
$ diff template.latex.default template.latex
390c390,394
< \date{$date$}
---
> \date{Created: $date$
> $if(lastupdate)$
>   \normalsize{    Last update: \today}
> $endif$}
> 
432a437
>   \pdfbookmark[0]{\contentsname}{toc}
440a446
```

#### *custom-reference.docx* {#i-docxref}

You can always generate your own reference.docx file using pandoc rather
than using the file included with this project:

```console
$ pandoc --print-default-data-file reference.docx > custom-reference.docx
```

Then you can use your word processor and modify the document styles.  Note
that only modifications that impact the document style are used; any other
kind of modification will be ignored by Pandoc.

The provided 'custom-reference.docx' file was modified directly; here are the
modifications made:

```console
// Start by unzipping the file so that you can access 'styles.xml'
$ mkdir ~/styles
$ cd ~/styles
$ cp /path/to/custom-reference.docx .
$ unzip custom-reference.docx
$ rm custom-reference.docx
$ ls
'[Content_Types].xml'   docProps/   _rels/   word/

$ ls word/
comments.xml  fontTable.xml  numbering.xml  settings.xml  theme/
document.xml  footnotes.xml  _rels/         styles.xml    webSettings.xml

// Edit the styles.xml file:
$ gvim word/styles.xml

// In case you modified the reference docx file with your word processor
// then you might need to first reformat the styles file so that you are able
// to edit it:
$ xmllint --format styles.xml > styles.xml.new
$ mv styles.xml.new styles.xml

// When you are finished then you zip the file back up again.  Be sure to
// create the zip file outside of the your work directory.  In this example
// we used ~/styles/
$ pwd
/home/myname/styles/
$ zip -r ../custom-reference-new.docx *
```
Here are the XML changes made to the supplied 'custom-reference.docx' file:

   1. Make fenced code blocks use a better font as well as a smaller font size:

```xml
  <!-- Locate the styleId 'VerbatimChar' -->
  <!-- We change Consolas font to 'Courier New' and set the size to 18 -->
  <w:style w:type="character" w:customStyle="1" w:styleId="VerbatimChar">
    <w:name w:val="Verbatim Char" />
    <w:basedOn w:val="BodyTextChar" />
    <w:rPr>
      <w:rFonts w:ascii="Courier New" w:hAnsi="Courier New" />
      <w:sz w:val="18" />
    </w:rPr>
  </w:style>
```

   2. Set the default paragraph alignment to *justified*:

```xml
  <!-- Locate the styleId 'BodyText' -->
  <!-- Set the default alignment to be justified, which is named 'both' -->
  <w:style w:type="paragraph" w:styleId="BodyText">
    <w:name w:val="Body Text" />
    <w:basedOn w:val="Normal" />
    <w:link w:val="BodyTextChar" />
    <w:pPr>
      <w:spacing w:before="180" w:after="180" />
      <w:jc w:val="both"/>
    </w:pPr>
    <w:qFormat />
  </w:style>

```

   3. Insert a page break before each 'Heading1':

```xml
  <!-- Locate the styleId 'Heading1' and add a pageBreakBefore -->
  <w:style w:type="paragraph" w:styleId="Heading1">
    <w:name w:val="Heading 1" />
    <w:basedOn w:val="Normal" />
    <w:next w:val="BodyText" />
    <w:uiPriority w:val="9" />
    <w:qFormat />
    <w:pPr>
      <w:pageBreakBefore/>
      <w:keepNext />
      <w:keepLines />
      <w:spacing w:before="480" w:after="0" />
```

<!-- , and contains the following modifications. -->

### Files which control style

#### *style.css* {#i-css}

Only for HTML (and EPUB) output you can provide your own CSS[^css] files. 
You can add as many style sheets as you want simply by adding multiple
*-c* options:

   *-c thisfile.css -c SOME_URL -c anotherfile.css*

Remember that later stylesheets can override previous stylesheet items when
the same element's style is defined; therefore order is important.

The included *makefile* uses the following css style file order.  I rather like
[this latex-like css style][latex-css] file.  You can obviously update the
Makefile and use other style files which you prefer.

```console
$ pandoc ... -c https://latex.now.sh/style.css -c style.css ...
```

[^css]: Cascading Style Sheet

[latex-css]: https://github.com/vincentdoerig/latex-css

### Files which control syntax highlighting

Pandoc allows you to add syntax highlighting to enhance and differentiate
the syntax in computer languages, scripting or other relevant digital output.
Highlighted text immediately clarifies the different functionality in the
target text.

You can get a list of the languages which Pandoc can present with syntax
highlighting:

```console
// There are 134 'languages' which can be highlighted:
$ pandoc --list-highlight-languages | wc -l
134
$ pandoc --list-highlight-languages | tail
yaml
yacc
zsh
dot
noweb
rest
sci
sed
xorg
xslt
```

And there are 8 different styles.  To see the effect of these styles see
[Garrick's examples][syntax-highlight-styles].

```console
$ pandoc --list-highlight-styles
pygments
tango
espresso
zenburn
kate
monochrome
breezedark
haddock
```

[syntax-highlight-styles]: https://www.garrickadenbuie.com/blog/pandoc-syntax-highlighting-examples/

But you can also add your own syntax highlighting rules and styles, which
is what I have done.  I introduced a new syntax highlighting mode for
command-line sessions for Markdown documents which is named **console**.

Then *pandoc* consumes these 2 files and generates the new highlighting in 
target documents:

```console
$ pandoc ... --syntax-definition=console.xml --highlight-style=custom-highlight.theme ...
```

#### *console.xml* {#i-xml}

This file describes how some console text strings are recognized, and assigns a 
pre-defined style to them.

#### *custom-highlight.theme* {#i-theme}

Then this theme file provides the pre-defined text styles specified by
the *console.xml* file.

### Editor files for *vim*/*gvim*

While it is nice to have customized syntax highlighting in your final
document, it is also extremely helpful to have your text editor know
about the customized syntax highlighting and present similar highlighting.

I have created a syntax configuration file for [vim and gvim][vim], my 
editors of choice.  At version 8.2 the editor recognizes over 600 
computer languages, scripts and console input/output.

#### Set syntax for 'console' I/O:  *vim.syntax* and *vim.ftdetect* {#i-vimsyn}

Install these files into *~/.vim/:

```console
$ mkdir -p ~/.vim/ftdetect  ~/.vim/syntax

$ cp -p /path/to/vim.ftdetect ~/.vim/ftdetect/console.vim
$ cp -p /path/to/vim.syntax ~/.vim/syntax/console.vim
```

This simple syntax definition file works because it piggybacks on the
existing *Markdown* syntax highlighting file that vim uses:

```console
// 
$ head /usr/share/vim/vim82/syntax/markdown.vim 
" Vim syntax file
" Language:     Markdown
" Maintainer:   Tim Pope <vimNOSPAM@tpope.org>
" Filenames:    *.markdown
" Last Change:  2020 Jan 14
...
```

#### Example **~/.vimrc** configuration file: *vimrc.example* {#i-vimrc}

The *vimrc.example* is a minimal startup file that should be renamed or
added to your current vim configuration file which is named *~/.vimrc*

For the *console.vim* file to work in a vim editor when editing
Markdown files you need to add it to the array of Markdown fenced languages;
that is:

```console
$ cat ~/.vimrc
...
let g:markdown_fenced_languages = ['console', 'sh', 'php', 'mysql', 'css']
```

[vim]: https://en.wikipedia.org/wiki/Vim_(text_editor)

