<!-- -->
# Examples of Pandoc's Markdown usage

There are many resources about using Pandoc's Markdown flavour; here are
some detailed links to look at:

   * [The official Pandoc manual][the-pandoc-manual]
   * [Introduction to Pandoc][pandoc-intro]
   * [A tutorial on Markdown and Pandoc][tutorial]
   * [A cheat sheet for generic Markdown][cheat-sheet]
   * [A rundown on Markdown elements][md-elements]
   * [Pandoc Markdown][pandoc-md]

[the-pandoc-manual]: https://pandoc.org/MANUAL.html#pandocs-markdown
[pandoc-intro]: https://uoftcoders.github.io/studyGroup/lessons/misc/pandoc-intro/lesson/
[tutorial]: https://www.flutterbys.com.au/stats/tut/tut17.3.html
[cheat-sheet]: https://www.markdownguide.org/cheat-sheet/
[md-elements]: https://users.ssc.wisc.edu/~hemken/Stataworkshops/stmd/Markdown/markdownelements1.html
[pandoc-md]: https://garrettgman.github.io/rmarkdown/authoring_pandoc_markdown.html

In this chapter I want to show a summary of common Pandoc's Markdown elements.
Not all elements are shown here -- I picked the ones that I tend to use. The
web links above provide greater detail.

Most elements are easy to remember since Markdown is all about writing simple
text.

Except for the example *table* element, all other example elements are 
embedded in a table with the *element name* in the left column, the *markdown
code* in the centre column, and the *generated output* in the right column.

Markdown elements are sometimes explained the way HTML elements are - generally
speaking they are divided into two categories: [*block* elements and *inline*
elements][elements].

**Block elements** are further divided into *container* blocks and *leaf*
blocks.  Container block elements may contain other block elements as well
as *inline* elements.  Leaf elements may only include *inline* elements --
the exceptions in this group are code blocks and horizontal rules which
cannot contain anything.

Block elements typically span at least an entire line.  Block elements are
very sensitive to having some white space around them.  It is a good idea
to put an empty line before and after them.

**Inline elements** are rather solitary, and typically occur in less than
a line of text.  The main defining feature though is that an inline element
cannot contain other elements.

[elements]: https://cran.r-project.org/web/packages/gluedown/vignettes/literal-programming.html

## Leaf Block Elements

### Paragraph structures and Headings

Paragraphs are simply text sequences of lines separated by at least one
blank line.

Headings are the elements that provide a *table of contents* and give the
document a hierarchical structure.  I use the ATX-style headings, which 
use the pound sign -- **#** -- and consist of up to 6 levels of heading
markers, one for each pound sign.  The level with one pound sign is the
top level.

+-----------------------+-----------------------+------------------------+
| Element               | Markdown              | Output                 |
+=======================+=======================+========================+
| **Headings**          |```                    |                        |
|                       |#### Heading 4th level | #### Heading 4th level |
|                       |                       |                        |
|                       |##### Heading 5th level| ##### Heading 5th level|
|                       |```                    |                        |
+-----------------------+-----------------------+------------------------+

### Fenced code blocks

These code blocks are surrounded by a 'fence' in that they are surrounded
by a sequence of 3 or more backticks or tildes.  All text inside the fence
is rendered as-is, without interpretation by the Markdown processor.

Moreover, the code block can be marked by an attribute that labels the kind
of code inside the fence.  In this guide I use the *console* attribute, as 
discussed in !! to be linked.

+-----------------------+-----------------------+------------------------+
| Element               | Markdown              | Output                 |
+=======================+=======================+========================+
| **Code Blocks**       |`````                  |                        |
|                       |```console             |```console              |
|                       |// This is a comment   |// This is a comment    |
|                       |$ echo I am a user     |$ echo I am a user      |
|                       |# echo I am root       |# echo I am root        |
|                       |                       |                        |
|                       |```                    |```                     |
|                       |`````                  |                        |
+-----------------------+-----------------------+------------------------+


### Horizontal rule

Horizontal rules are also known as *theme breaks*.

+--------------------+-----------------------+-----------------------+
| Element            | Markdown              | Output                |
+:==================:+:======================+:======================+
|**Horizontal rule** | ```                   |                       |
|                    | ---                   | ---                   |
|                    | ```                   |                       |
+--------------------+-----------------------+-----------------------+

## Container Block Elements

### Block quotations

Quoting something is done with with the greater-than character -- **>** --
in front of each line (or in lazy mode, only the first line).

+-----------------------+-----------------------+------------------------+
| Element               | Markdown              | Output                 |
+=======================+=======================+========================+
| **Block quote**       |Here is a quote:       | Here is a quote:       |
|                       |                       |                        |
|                       |```                    |                        |
|                       |> *this is a quote*    |> *this is a quote*     |
|                       |```                    |                        |
+-----------------------+-----------------------+------------------------+
| **Block quote**       |This one is nested:    |This one is nested:     |
|                       |```                    |                        |
|                       |> this is a quote      |> this is a quote       |
|                       |>                      |>                       |
|                       |> > a deeper quote     |> > a deeper quote      |
|                       |```                    |                        |
+-----------------------+-----------------------+------------------------+

### Lists

Here are 3 kinds of lists; only the *definition list* is typically not
implemented in many flavours of Markdown:

+-----------------------+-----------------------+------------------------+
| Element               | Markdown              | Output                 |
+=======================+=======================+========================+
| **Bullet List**       |```                    |                        |
|                       |   * item x            |   * item x             |
|                       |   * item y            |   * item y             |
|                       |   * item z            |   * item z             |
|                       |```                    |                        |
+-----------------------+-----------------------+------------------------+
| **Ordered List**      |```                    |                        |
|                       |   #. item x           |   #. item x            |
|                       |   #. item y           |   #. item y            |
|                       |   #. item z           |   #. item z            |
|                       |```                    |                        |
+-----------------------+-----------------------+------------------------+
| **Definition List**   |```                    |                        |
|                       |Some Term:             |Some Term:              |
|                       |                       |                        |
|                       |:    Definition 1      |:    Definition 1       |
|                       |:    More information  |:    More information   |
|                       |:    And more info     |:    And more info      |
|                       |```                    |                        |
+-----------------------+-----------------------+------------------------+

### Tables

There are a few kinds of tables, but the kind I am using in this document
are *grid tables*.  Note that tables might confuse your editor if it is
trying to do syntax highlighting -- that has been my experience with gvim
at least.

Generally speaking tables are always a bit fussy to create in many document
types.  I wrote a [shell script to generate empty grid tables](#i-tabscript)
that makes it a bit easier to get started with a table.

Tables in Pandoc Markdown act as container block elements, in that they
may contain other elements.  The exception I have found is other tables;
you cannot yet embed a table inside another table.

Here is a modified table borrowed from the [Pandoc manual][pandoc-tables].
It also contains alignment hints.  Alignment (left, centre, right) in
Markdown is indicated by the *colon* character at the upper edge of the
first row in the table.  So in the following table the left column is
left-aligned, the center column is centred, and the right column is
right aligned:

+--------------+------------+-------------+
| Fruit        | In Stock   | Price       |
+:=============+:==========:+============:+
| *Bananas*    | Yes        | $1.34       |
+--------------+------------+-------------+
| **Oranges**  | No         | $2.10       |
+--------------+------------+-------------+

Table: This is a table caption.

In Markdown language it looks like the following:

```
+--------------+------------+-------------+
| Fruit        | In Stock   | Price       |
+:=============+:==========:+============:+
| *Bananas*    | Yes        | $1.34       |
+--------------+------------+-------------+
| **Oranges**  | No         | $2.10       |
+--------------+------------+-------------+

Table: This is a table caption.
```

[pandoc-tables]: https://pandoc.org/MANUAL.html#pandocs-markdown

### Footnotes and 'inline' notes

To generate a note or footnote, the caret character -- **^** -- is used:

+-----------------------+-----------------------+-----------------------+
| Element               | Markdown              | Output                |
+:=====================:+:======================+:======================+
| **Inline note**       | ```                   |                       |
| (no reference needed) | Inline Eg^[my **note**] | Inline Eg^[my **note**] |
|                       | ```                   |                       |
+-----------------------+-----------------------+-----------------------+
| **Footnote**          | ```                   |                       |
|(a reference is needed)| Footnote Eg[^note]    | Footnote Eg[^note]    |
|                       | ```                   |                       |
+-----------------------+-----------------------+-----------------------+
| (This is the          | ```                   |(Look for me further below)|
| footnote reference)   | [^note]: I am here..  |                       |
|                       | ```                   | [^note]: I am here..  |
+-----------------------+-----------------------+-----------------------+

<!--
Odd elements:
 YAML metadata blocks
-->

## Inline elements:

### Formatting elements:

These elements alter the appearance of enclosed words or phrases:

+-----------------------+-----------------------+--------------------+
| Element               | Markdown              | Output             |
+:=====================:+:======================+:===================+
| **Strikeout**         | ```                   |                    |
|                       | ~~Example~~           | ~~Example~~        |
|                       | ```                   |                    |
+-----------------------+-----------------------+--------------------+
|                       | ```                   |                    |
| **Emphasis**          | *Example*             | *Example*          |
| (italics)             | ```                   |                    |
+-----------------------+-----------------------+--------------------+
|                       | ```                   |                    |
| **Strong Emphasis**   | **Example**           | **Example**        |
| (bold)                | ```                   |                    |
+-----------------------+-----------------------+--------------------+
|                       | ```                   |                    |
| **Superscript**       | this^Example^         | this^Example^      |
|                       | ```                   |                    |
+-----------------------+-----------------------+--------------------+
|                       | ```                   |                    |
| **Subscript**         | this~Example~         | this~Example~      |
|                       | ```                   |                    |
+-----------------------+-----------------------+--------------------+
|                       | ```                   |                    |
| **Underline**         | [Example]{.underline} | [Example]{.underline}|
| (works in html output)| ```                   |                    |
+-----------------------+-----------------------+--------------------+
|                       | ```                   |                    |
| **Underline**         | \underline{Example}   | \underline{Example}|
| (works in pdf output) | ```                   |                    |
+-----------------------+-----------------------+--------------------+
|                       | ```                   |                    |
| **Small Caps**        | [Example]{.smallcaps} | [Example]{.smallcaps}|
|                       | ```                   |                    |
+-----------------------+-----------------------+--------------------+
|                       | ```                   |                    |
| **Inline Code**       | `# echo Eg`{.console} | `# echo Eg`{.console}|
|                       | ```                   |                    |
+-----------------------+-----------------------+--------------------+


### Links:

There are two kinds of links:

Links to external resources
:    I like to mark a link with a label and list the marked link
     at the end of the section or at the end of the document.

Links to internal document information 
:    Typically you want to link to a heading somewhere in the document.
     You can add a *label* to a heading so that you can link to it elsewhere.
     Pandoc automatically generates label names for headings in order to
     link a table of contents at the beginning of the document.

+----------+----------------------------+---------------------------+
| Element  | Markdown                   | Output                    |
+:========:+:===========================+:==========================+
|**External| ```                        |                           |
| Links**  | Try out [this link][tiny]  | Try out [this link][tiny] |
| with a   |                            |                           |
| label    |                            |                           |
|          | [tiny]: https://t.ly/      | [tiny]: https://t.ly/     |
|          | ```                        |                           |
+----------+----------------------------+---------------------------+
|**Internal| ```                        |                           |
| Links**  | Look at [topic X](#top-x)  | Look at [topic X](#top-x) |
|          |                            |                           |
|          | (later in the document)    |                           |
|          |                            |                           |
|          | #### Topic X {#top-x}      | #### Topic X {#top-x}     |
|          |                            |                           |
|          | ```                        |                           |
+----------+----------------------------+---------------------------+

### Images

+----------+----------------------------+-------------------------------+
| Element  | Markdown                   | Output                        |
+:========:+:===========================+:==============================+
|**Image** | ```                        |                               |
|          |                            |                               |
|          |![Pi](image.png){width=25ex}| ![Pi](image.png){width=25ex}  |
|          |                            |                               |
|          | ```                        |                               |
+----------+----------------------------+-------------------------------+

