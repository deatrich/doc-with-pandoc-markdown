<!-- -->
# Overview

Documenting with the [Markdown language][md] is wonderfully simple and clean.
When combined with the capabilities of the [Pandoc][pandoc] command set then
many options exist for generating elegant documents from a markdown document.

Though [many output formats][pandoc-formats] are possible with Pandoc, the
tools provided with this guide provide generated *html* and *pdf* output.
As well, *docx* output is provided with the tools.  However, control over
the formatting of the console session output is limited in the generated docx
guide.  If I find a way around it I will provide updates.

These tools focus on writing computer technical documentation, but 
they could easily be adapted for other purposes, like writing presentation
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
customized *.console* syntax highlighting convention as described in the 
next chapter.  Two kinds of simplified command-line prompts appear.
As well, explanatory comments starting with two slashes are coloured blue:

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

Recently I added a few more console commands which offer their own
command-line shell, like *mysql* and *virsh*:

```console
// mariadb session:
$ mysql -u root -p
Enter password: 
Welcome to the MariaDB monitor.  Commands end with ; or \g.
...

mysql> select concat(user, '@', host) from mysql.global_priv;
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
mysql> exit;
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

## Guide outline

In this guide I cover the following topics.  It should be enough to get
you started writing documentation in markdown.

We start by setting up your workspace.  We install Pandoc, as well as my
favourite editor and a few PDF viewers.  Other viewers like Firefox and
LibreOffice are typically already installed, but I point out some issues
you might encounter and how to fix them.

Though spell checking is primitive, I show how to install the needed
Lua filters and later I show how to use them.

Then we pull this project's files from *github.com* and install them into
your home directory.  I give a quick overview of the purpose of the provided
tools and files.

The final section of this guide is an outline of markdown elements.

<!-- !! I need to add a short get-started example -->

