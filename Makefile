

TEX=xelatex -file-line-error -shell-escape -interaction=nonstopmode
TEX=xelatex -file-line-error -shell-escape -interaction=nonstopmode -synctex=1 -recorder
BIB=biber
SRC="gdsm_bibliography"
TGT=${SRC}__$$(date '+%Y-%m-%d')-000__DOIN

# $$(date '+%Y%m%d_%H%M%S')


help:
	@cat Makefile
	@echo "\n============================================================================="
	@echo "\nEXAMPLE USAGE:\n\tmake all"

clean:
	@echo "*** INFO: running \"clean\""
	@rm -fv ${SRC}.aux
	@rm -fv ${SRC}.fls
	@rm -fv ${SRC}.log
	@rm -fv ${SRC}.synctex.gz
	@rm -fv ${SRC}.bbl
	@rm -fv ${SRC}.bcf
	@rm -fv ${SRC}.blg
	@rm -fv ${SRC}.run.xml
	@rm -fv ${SRC}.out

move:
	@mv -v ${SRC}.pdf ${TGT}.pdf

detex:
	@detex ${SRC}.tex > ${TGT}.detex.txt

pdf2txt:
	@pdf2txt -o ${TGT}.pdf2txt.txt ${TGT}.pdf

xelatex0 xelatex1 xelatex2 xelatex3 xelatex4:
	@echo "*** INFO: running \"xelatex0\""
	$(TEX) "${SRC}.tex"

biber0 biber1:
	$(BIB) "${SRC}"

all: clean xelatex0 biber0 xelatex1 xelatex2 move pdf2txt

less: clean xelatex0 biber0 xelatex1 move pdf2txt

more: clean xelatex0 biber0 xelatex1 biber1 xelatex2 xelatex3 xelatex4 move pdf2txt

pandoc:
	pandoc -s "${SRC}.tex" -o "${SRC}.odt" --bibliography bibliography.bib
