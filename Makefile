#***************************************************************************
# $Id$
#
# Purpose: makefile for doc. --> generate html and pdf files from an md file
#
#***************************************************************************

#***************************************************************************
.SUFFIXES : .md .html .pdf .docx
#.SILENT :

#***************************************************************************
## get object file names from source file names

## Change 'PROJECT' to the name of the target document you are generating:
PROJECT		= pandoc-markdown-guide
FILELIST	= contents.txt
GENDIR		= "Generated/"

## Change the publication path for your generated files (assuming a local area)
PUBDIR		= "/path/to/$(PROJECT)/latest-version/"

MDFILE		= $(PROJECT).md
MDFILES		= $(shell cat ${FILELIST})
DOCXOBJECT	= $(MDFILE:.md=.docx)
HTMLOBJECT	= $(MDFILE:.md=.html)
PDFOBJECT	= $(MDFILE:.md=.pdf)
DOCXVIEWER	= lowriter
PDFVIEWER	= evince
HTMLVIEWER	= firefox

#***************************************************************************
PRINTOPT	= 
PANDOC_OPTS	= --toc --toc-depth=3 --syntax-definition=console.xml \
		  --highlight-style=custom-highlight.theme

PANDOC_DOCX_OPTS = --reference-doc=custom-reference.docx \
		  -V lastupdate="`date +'%d %B %Y'`"

PANDOC_HTML_OPTS = -c https://latex.now.sh/style.css -c style.css \
		   --template template.htm -V lastupdate="`date +'%d %B %Y'`"

PANDOC_PDF_OPTS	= --template=template.latex -V geometry:margin=2cm \
		  --pdf-engine=xelatex

#***************************************************************************
## DEFAULT GOAL

## Remove any target from the 'all' rule to avoid generating it
all:	$(HTMLOBJECT) $(PDFOBJECT) $(DOCXOBJECT)

test:
	@echo "Top file: $(MDFILE)"
	@echo "Markdown files: $(MDFILES)"

#***************************************************************************
## DEPENDENCIES

$(HTMLOBJECT): $(MDFILES) template.htm console.xml custom-highlight.theme \
			 contents.txt style.css

$(PDFOBJECT): $(MDFILES) template.latex console.xml custom-highlight.theme \
			 contents.txt

$(DOCXOBJECT): $(MDFILES) console.xml custom-highlight.theme \
			 contents.txt

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

copies: $(PDFOBJECT) $(HTMLOBJECT)
	cp -up $(PDFOBJECT) $(GENDIR)$(PDFOBJECT) 
	cp -up $(HTMLOBJECT) $(GENDIR)$(HTMLOBJECT) 

publish: $(PDFOBJECT) $(HTMLOBJECT)
	@if test -d $(PUBDIR) ; then \
	  cp -iup $(PDFOBJECT) $(PUBDIR)$(PDFOBJECT); \
	  cp -iup $(HTMLOBJECT) $(PUBDIR)$(HTMLOBJECT); \
	  cp -iup $(DOCXOBJECT) $(PUBDIR)$(DOCXOBJECT); \
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
	-rm -i *.html *.pdf $(PROJECT).docx

