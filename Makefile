DOCTARGET = mendex
PDFTARGET = $(addsuffix .pdf,$(DOCTARGET))
DVITARGET = $(addsuffix .dvi,$(DOCTARGET))
KANJI = -kanji=utf8
#FONTMAP = -f ipaex.map -f ptex-ipaex.map
FONTMAP = -f haranoaji.map -f ptex-haranoaji.map -f otf-haranoaji.map
TEXMF = $(shell kpsewhich -var-value=TEXMFHOME)
ifdef PLATEX
	PLATEX=${foo}
else
	PLATEX=platex
endif

default: $(DVITARGET)
all: $(PDFTARGET)

.SUFFIXES: .tex .dvi .pdf
.tex.dvi:
	platex $(KANJI) $<
	platex $(KANJI) $<
	platex $(KANJI) $<
	rm -f *.aux *.log *.toc *out
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
