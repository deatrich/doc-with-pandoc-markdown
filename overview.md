<!-- -->
# Overview

Documenting with the [Markdown language][md] is wonderfully simple and clean.
When combined with the capabilities of the [Pandoc][pandoc] command set then
many options exist for generating elegant documents from a Markdown document.

Though [many output formats][pandoc-formats] are possible with Pandoc, the
tools provided with this guide generate *html*, *pdf* and *docx* output.

There are some issues with 'docx' documents (!! I need to check some of these
points with MS Word once I borrow a laptop from the family):

   * A *table of contents* is not generated for Libreoffice/Openoffice.
     You must open the document in your word processor and ask it to 
     generate a table of contents.

   * If you wish to modify the default document style then you can either
     modify the style of the reference docx file using your word processor,
     or you can unpack the reference document, modify the *styles.xml* file,
     and the repack the document.  I describe [how to unpack the reference
     file](#i-docxref) further in this document.

   * Images are not elegantly scaled in the docx presentation.  Therefore
     you need to adjust images to fit the required placement.

   * You will need to enable a footer in the page style and add the page
     number for page numbering.

These tools focus on writing computer technical documentation; however 
they can easily be adapted for other purposes, like writing presentation
slides, or scientific latex documents.  By modifying style and template
parameters you can adapt the tools to your needs.

The platform used for this project is Ubuntu LTS 22.04 on a Raspberry Pi, as
documented at: \
 [https://github.com/deatrich/linux-home-server][linservproj]

The version of Pandoc used is 2.9.  Any other Linux distribution or
UNIX-based system with a recent installation of *Pandoc* should work as well.

If you discover issues with instructions in this document, or have other
comments or suggestions then you can contact me via my email address shown on
[my github project repository page][mygithub], or you can file specific
issues under the 'Issues' tab [on the project page][thisproject].

[md]: https://www.markdownguide.org/getting-started/
[pandoc]: https://pandoc.org/
[pandoc-formats]: https://pandoc.org/MANUAL.html#options
[linservproj]: https://deatrich.github.io/linux-home-server/latest-version/linux-server.html#doc
[mygithub]: https://github.com/deatrich/
[thisproject]: https://github.com/deatrich/doc-with-pandoc-markdown

## About this Document

In this guide command-line sessions appear in a pale-yellow box, using a 
customized *.console* syntax highlighting convention described in my
[*console syntax highlighting* project][console-syntax].

Simplified command-line prompts have syntax highlighting.
As well, explanatory comments starting with two slashes are italicized
and are coloured blue:

```console
// Usually your prompt would be more complex, something like this:
//    myname@ubuntu:~/.vim/syntax$
// or like this:
//    [desktop /tmp]$ 
// But I simplify its appearance when illustrating command-line sessions.
// Normal Users' command-line prompt, coloured 'green':
$ some-command

// The root superuser's prompt, simplifed also, and coloured 'red':
# some-other-command
```

A few other command-line programs with a shell-like interface 
-- *mysql*, *mariadb* and *virsh* -- also have syntax highlighting:

```console
// mariadb session:
$ mysql -u root -p
Enter password: 
Welcome to the MariaDB monitor.  Commands end with ; or \g.
...

MariaDB> select concat(user, '@', host) from mysql.global_priv;
+-------------------------+
| concat(user, '@', host) |
+-------------------------+
| ro@192.168.1.%          |
| rw@192.168.1.%          |
| mariadb.sys@localhost   |
| mysql@localhost         |
| root@localhost          |
+-------------------------+
5 rows in set (0.001 sec)
MariaDB> exit;
Bye

// virsh session:
$ sudo virsh
Welcome to virsh, the virtualization interactive terminal.

Type:  'help' for help with commands
       'quit' to quit

virsh # list --all
 Id   Name          State
------------------------------
 -    rocky8        shut off
 -    rocky8.2      shut off
 -    ubuntu22.04   shut off

virsh # exit
```

Sometimes command output is long and/or uninteresting in the context
of this guide.  I might show such segments with a ellipsis (**...**)

Sometimes a double-exclamation (**!!**) mark might appear somewhere -- this
is only a reminder for myself to fix an issue at that point in the
documentation.  These reminders will eventually disappear.

You can of course use syntax highlighting for various languages in Pandoc's
Markdown.  Here is an example of a bash script:

```sh
#!/bin/bash -e

unalias -a
PATH=/usr/bin:/bin

## get the timestamp from the file argument and apply it
update_file_timestamp() {
  file_time=$(git log -1 --pretty=format:%ai "$1")
  touch -d "$file_time" "$1"
}

OLD_IFS=$IFS
IFS=$'\n'

for file in `git ls-files`
do
  if [ -f "$file" ] ; then  ## check for file existence
    update_file_timestamp "$file"
  fi
done

IFS=$OLD_IFS

git update-index --refresh
```

[console-syntax]: https://deatrich.github.io/console-syntax/

## Guide outline

In this guide I cover the following topics.  It should be enough to get
you started writing documentation in Markdown.

We start by setting up your workspace.  We install Pandoc, as well as my
favourite editor (or your favourite editor) and a few PDF viewers.  Other
viewers like Firefox and LibreOffice are typically already installed.

Though spell checking is primitive, we take a look at *aspell*, and I also show
how to install the spell-checking Lua filter and how to use it.

Then we pull the files from this project and from the 'console syntax' project
on *github.com* and install them into your home directory.  We also test
the installation by running 'make' on the initial generated project.

I give a quick overview of the purpose of the provided tools and files.

The final section of this guide is an outline of Markdown elements so that
you have a quick start on common Markdown elements.

## Where to find this guide

HTML, DOCX and PDF versions of this guide can be found at:

HTML:
: [https://deatrich.github.io/doc-with-pandoc-markdown/current/doc-with-pandoc-markdown.html][html]

PDF:
: [https://deatrich.github.io/doc-with-pandoc-markdown/current/doc-with-pandoc-markdown.pdf][pdf]

DOCX:
: [https://deatrich.github.io/doc-with-pandoc-markdown/current/doc-with-pandoc-markdown.docx][docx]

[html]: https://deatrich.github.io/doc-with-pandoc-markdown/current/doc-with-pandoc-markdown.html
[pdf]: https://deatrich.github.io/doc-with-pandoc-markdown/current/doc-with-pandoc-markdown.pdf
[docx]: https://deatrich.github.io/doc-with-pandoc-markdown/current/doc-with-pandoc-markdown.docx
\

