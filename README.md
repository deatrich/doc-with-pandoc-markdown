# Getting Started With Pandoc Markdown

While writing a guide about creating a [Linux Home Server][home-server] using
Pandoc Markdown I spent some time understanding issues and finding solutions.
For future markdown-based guides I want to reuse the setup files I created.
Thus I created this repository with all the setup files needed to easily 
begin writing guides, and to generate HTML, DOCX and PDF output files.

This guide was necessarily written using the Markdown markup language.  As the
flavour of Markdown used is the Pandoc flavour, then some features in
the document (like definition lists) may not render correctly in the
Github flavour.  Nevertheless, you can still 
[browse Markdown files in GitHub][mygithub.com].

Recent Pandoc-generated HTML, DOCX and PDF files are available
on my github.io site at:

  [https://deatrich.github.io/doc-with-pandoc-markdown/][mygithub.io]

This is a work in progress:

## Preliminary task list for main document
- [x] Copy and modify initial support files from *linux-home-server* project
- [x] Complete an 'overview' chapter 
- [x] Document the initial client software installation
- [x] Document support tools installation and configuration
- [x] Describe all support files
- [x] Moved *console* fenced code and editor setup and issues to \
 https://github.com/deatrich/console-syntax
- [x] Add additional topics like spell-checking
- [x] Write a chapter on using Pandoc with Markdown examples
- [x] Add this project to https://deatrich.github.io/
- [ ] Add *odt* output to the project
- [x] Add some scripts to create lists of commands, etc^[egs]
- [ ] Add some scripts to create lists of external links found in a document

[home-server]: https://github.com/deatrich/linux-home-server/
[mygithub.com]: https://github.com/deatrich/doc-with-pandoc-markdown/
[mygithub.io]: https://deatrich.github.io/doc-with-pandoc-markdown/

[^egs]: Example: use awk to count number of console segments and the list of commands, list of sudo commands, etc.
