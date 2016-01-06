PREFIX  = research
TEXFILE = $(PREFIX).tex
PDFFILE = $(PREFIX).pdf
TMPFILE = .makedolatex.log

OPTIONS = -file-line-error -halt-on-error -interaction nonstopmode
#OPTIONS = -interaction nonstopmode

BLACK="\033[30m"
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BLUE="\033[34m"
PINK="\033[35m"
CYAN="\033[36m"
WHITE="\033[37m"
NORMAL="\033[0;39m"

ALLTEXFILES := $(shell ls *.tex)
BIBFILES := $(shell ls *.bib)
#FIGFILES := $(shell ls figs/* | sed 's/ /\\ /g')


all:	$(PREFIX).pdf clean


$(PREFIX).pdf: $(PREFIX).tex $(ALLTEXFILES) $(BIBFILES)
	@$(MAKE) dopdflatex;
	@$(MAKE) dobibtex;
	@$(MAKE) dopdflatex;
	@$(MAKE) dopdflatex;
	@echo;

.PHONY: dobibtex
dobibtex:
	@if ( grep bibdata\{ *.aux > /dev/null ); then \
		if ( grep citation\{ *.aux > /dev/null ); then \
			if ( bibtex $(PREFIX) > $(TMPFILE) ); then \
			 	printf $(GREEN); echo "(bibtex) OK"; \
			else \
				printf $(RED); echo "(bibtex) ERROR"; \
				cat $(TMPFILE); \
			fi; \
		fi; \
	fi;
	@printf $(NORMAL)

.PHONY: dopdflatex
dopdflatex:
	@if ( pdflatex --shell-escape $(OPTIONS) $(TEXFILE) > $(TMPFILE) ); then \
    printf $(YELLOW); \
	  grep Warning $(TMPFILE); \
		printf $(GREEN); echo "(pdflatex) OK"; \
  else \
	 	printf $(RED); \
		grep -A 6 "Error" $(TMPFILE); \
    echo "(...) last 20 lines of pdflatex output:";  \
	  tail -n 20 $(TMPFILE); \
    echo "(pdflatex) ERROR"; \
    echo; \
	fi;
	@printf $(NORMAL)

.PHONY: clean
clean:
	@if [ -f $(PREFIX).aux ]; then\
		rm $(PREFIX).aux;\
	fi
	@if [ -f $(PREFIX).log ]; then\
		rm $(PREFIX).log;\
	fi
	@if [ -f $(PREFIX).blg ]; then\
		rm $(PREFIX).blg;\
	fi
	@if [ -f $(PREFIX).bbl ]; then\
		rm $(PREFIX).bbl;\
	fi
	@if [ -f $(PREFIX).out ]; then\
		rm $(PREFIX).out;\
	fi
	@if [ -f $(PREFIX).tex.bak ]; then\
		rm $(PREFIX).tex.bak;\
	fi
	@if [ -f $(PREFIX).toc ]; then\
		rm $(PREFIX).toc;\
	fi
	@if [ -f $(PREFIX).nav ]; then\
		rm $(PREFIX).nav;\
	fi
	@if [ -f $(PREFIX).snm ]; then\
		rm $(PREFIX).snm;\
	fi
	@if [ -f $(PREFIX).bcf ]; then\
		rm $(PREFIX).bcf;\
	fi
	@if [ -f $(PREFIX).run.xml ]; then\
		rm $(PREFIX).run.xml;\
	fi
	@if [ -f $(PREFIX)-blx.bib ]; then\
		rm $(PREFIX)-blx.bib;\
	fi

.PHONY: spell
spell:
	aspell --lang=en --mode=tex check $(PREFIX).tex
