DOCTARGET = mendex
PDFTARGET = $(addsuffix .pdf,$(DOCTARGET))
DVITARGET = $(addsuffix .dvi,$(DOCTARGET))
KANJI = -kanji=utf8
FONTMAP = -f ipaex.map -f ptex-ipaex.map
TEXMF = $(shell kpsewhich -var-value=TEXMFHOME)

default: $(DVITARGET)
all: $(PDFTARGET)

.SUFFIXES: .tex .dvi .pdf
.tex.dvi:
	platex $(KANJI) $<
	platex $(KANJI) $<
	platex $(KANJI) $<
	rm -f *.aux *.log *.toc
.dvi.pdf:
	dvipdfmx $(FONTMAP) $<

.PHONY: install clean
install:
	mkdir -p ${TEXMF}/doc/support/mendex
	cp ./LICENSE ${TEXMF}/doc/support/mendex/
	cp ./README* ${TEXMF}/doc/support/mendex/
	cp ./Makefile ${TEXMF}/doc/support/mendex/
	cp ./*.tex ${TEXMF}/doc/support/mendex/
	cp ./*.pdf ${TEXMF}/doc/support/mendex/
clean:
	rm -f $(DVITARGET) $(PDFTARGET)
