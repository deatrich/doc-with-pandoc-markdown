<!-- Pandoc meta-data, mostly used when generating PDF

     Solution for starting a new page for major sections of PDF output
     in metadata (documentclass, header-includes) is decscribed at:
     https://superuser.com/a/1436367

     Be sure to change 'title', 'author' and 'date' below:
-->
---
title: Getting Started With Pandoc Markdown
toc-title: Table of Contents
author: Denice Deatrich
lastupdate: 31 July 2023
date: July 2023
colorlinks: true
linkcolor: Magenta
urlcolor: ForestGreen
toccolor: Magenta
documentclass: report
header-includes:
- \renewcommand{\chaptername}{}
- \renewcommand{\thechapter}{}
## force figure placement to follow the text flow
## see: https://stackoverflow.com/questions/49482221/pandoc-markdown-to-pdf-image-position
- \usepackage{float}
- \makeatletter
- \def\fps@figure{H} 
- \makeatother
---

