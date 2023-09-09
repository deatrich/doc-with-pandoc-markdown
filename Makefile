#***************************************************************************
#
# Purpose: makefile for generating Pandoc documentation from Markdown
# 
#***************************************************************************

#***************************************************************************
# It is important to include this file containing important definitions:
include Makefile.project

.SUFFIXES : .md .html .pdf .docx

#***************************************************************************

FILELIST	= contents.txt

MDFILE		= $(PROJECT).md
MDFILES		= $(shell cat ${FILELIST})

COMMONFILES	= console.xml custom-highlight.theme contents.txt $(IMAGES)

## get object file names from source file names
DOCXOBJECT	= $(MDFILE:.md=.docx)
HTMLOBJECT	= $(MDFILE:.md=.html)
PDFOBJECT	= $(MDFILE:.md=.pdf)

## Remove any object(s) from 'TARGETS' to avoid generating them
TARGETS		= $(HTMLOBJECT) $(DOCXOBJECT) $(PDFOBJECT)

#***************************************************************************
PANDOC_OPTS	= --toc --toc-depth=3 --syntax-definition=console.xml \
		  --highlight-style=custom-highlight.theme

PANDOC_DOCX_OPTS = --reference-doc=custom-reference.docx \
		   -V lastupdate="`date +'%d %B %Y'`"

PANDOC_HTML_OPTS = -c https://latex.now.sh/style.css \
		   -c https://deatrich.github.io/style.css \
		   --template template.htm -V lastupdate="`date +'%d %B %Y'`"

PANDOC_PDF_OPTS	= --template=template.latex -V geometry:margin=2cm \
		  --pdf-engine=xelatex

#***************************************************************************
## DEFAULT GOAL

## Remove any target from the 'all' rule to avoid generating it
all:	$(TARGETS)

test:
	@echo "Top file: $(MDFILE)"
	@echo "Markdown files: $(MDFILES)"

#***************************************************************************
## DEPENDENCIES

$(HTMLOBJECT): $(MDFILES) template.htm $(COMMONFILES)

$(PDFOBJECT): $(MDFILES) template.latex $(COMMONFILES)

$(DOCXOBJECT): $(MDFILES) $(COMMONFILES)

#***************************************************************************
## GENERAL RULES

html: $(HTMLOBJECT)

pdf: $(PDFOBJECT)

docx: $(DOCXOBJECT)

showhtml: $(HTMLOBJECT)
	$(HTMLVIEWER) $(HTMLOBJECT)

showpdf: $(PDFOBJECT)
	$(PDFVIEWER) $(PDFOBJECT)

showdocx: $(DOCXOBJECT)
	$(DOCXVIEWER) $(DOCXOBJECT)

copies: $(TARGETS)
	@if test -d $(GENDIR) ; then \
	  for i in $(TARGETS) $(IMAGES) ; do \
            if [ -f "$$i" ] ; then \
	      cp -vup "$$i" $(GENDIR) ; \
            fi; \
	  done; \
	else \
	  echo "Missing publishing directory: $(GENDIR)"; \
	fi

publish: $(TARGETS)
	@if test -d $(PUBDIR) ; then \
	  for i in $(TARGETS) $(IMAGES) ; do \
            if [ -f "$$i" ] ; then \
	      cp -viup "$$i" $(PUBDIR) ; \
            fi; \
	  done; \
	else \
	  echo "Missing publishing directory: $(PUBDIR)"; \
	fi

help:	
	@echo ""
	@echo "make all          -- update all file types"
	@echo "make test         -- modify then run a test target"
	@echo "make html         -- update the html file"
	@echo "make pdf          -- update the pdf file"
	@echo "make docx         -- update the docx file"
	@echo "make showhtml     -- show the html file"
	@echo "make showpdf      -- show the pdf file"
	@echo "make showdocx     -- show the docx file"
	@echo "make copies       -- push copies to generated area"
	@echo "make publish      -- push copies to publishing area"
	@echo "make clean        -- clean up generated files"

.md.html :
	pandoc -s $(MDFILES) $(PANDOC_OPTS) $(PANDOC_HTML_OPTS) -o $(HTMLOBJECT)

.md.pdf :
	pandoc -s $(MDFILES) $(PANDOC_OPTS) $(PANDOC_PDF_OPTS) -o $(PDFOBJECT)

.md.docx :
	pandoc -s $(MDFILES) $(PANDOC_OPTS) $(PANDOC_DOCX_OPTS) -o $(DOCXOBJECT)

## manually clean up generated files from time to time
clean:
	@for i in $(TARGETS) ; do \
           if [ -f "$$i" ] ; then \
	      rm -i "$$i" ; \
           fi; \
	done

