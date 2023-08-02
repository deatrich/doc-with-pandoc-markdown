<!-- -->
# Overview

Documenting with the [Markdown language][md] is wonderfully simple and clean.
When combined with the capabilities of the [Pandoc][pandoc] command set then
many options exist for generating elegant documents from a markdown document.

The tools provided with this guide provide generated *html* and *pdf* output.
[Other formats][pandoc-formats] are possible; including:

   * docx (Microsoft Word)
   * rtf (Rich Text Format)
   * odt (OpenOffice writer)

These tools focus of writing complex computer techical documentation, but 
they can easily be adapted to other purposes, like writing presentation
slides, or scientific latex documents.  By modifying style and template
parameters you can adapt the tools to your needs.


Note about:  assumes Linux, in particular, Ubuntu

[md]: https://www.markdownguide.org/getting-started/
[pandoc]: https://pandoc.org/
[pandoc-formats]: https://pandoc.org/MANUAL.html#options

## Here is a sub-section

Now we go into details.

There might be some example command-line usage with accompanying console output.
This is an example of such output:

```console
// This is a comment
$ some-command
Some Output
...

// Commands issued by normal users have a prompt that starts with a '$' sign,
// and they are coloured green:
$ whoami
myname
$ sudo /bin/bash
[sudo] password for myname: 

// Now the user becomes root, so the prompt ('#') and the colour ('red') change:
# whoami
root
```

### Here is a sub-sub-section

Hello World!

## Here is another sub-section

etc.

If you discover issues with instructions in this document, or have other
comments or suggestions then you can contact me on
[my github project page][mygithub].

[mygithub]: https://github.com/deatrich/

<!--
```console
```
 -->
