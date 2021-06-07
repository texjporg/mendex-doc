DOCTARGET = mendex
PDFTARGET = $(addsuffix .pdf,$(DOCTARGET))
DVITARGET = $(addsuffix .dvi,$(DOCTARGET))
KANJI = -kanji=utf8
#FONTMAP = -f ipaex.map -f ptex-ipaex.map
FONTMAP = -f haranoaji.map -f ptex-haranoaji.map -f otf-haranoaji.map
TEXMF = $(shell kpsewhich -var-value=TEXMFHOME)
LTX = platex $(KANJI)
DPX = dvipdfmx $(FONTMAP)
MDX = mendex -U

default: $(DVITARGET)
all: $(PDFTARGET)

.SUFFIXES: .tex .dvi .pdf
.tex.dvi:
	$(LTX) $<
	$(MDX) mendex-sub
	mv mendex-sub.ind mendex-sub-0.ind
	$(MDX) -s jpbase mendex-sub
	mv mendex-sub.ind mendex-sub-1.ind
	$(MDX) -g -s jpbase mendex-sub
	mv mendex-sub.ind mendex-sub-2.ind
	$(LTX) $<
	$(LTX) $<
	rm -f *.aux *.log *.toc *out *.idx *.ind *.ilg *-sub-*.ist
.dvi.pdf:
	$(DPX) $<

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
