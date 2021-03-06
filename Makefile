CSV2 = test/csv2
CANVASFILES = $(shell find data -name \*.canvas -size +0)
DOCFILES =\
	docs/colourNamesList.png\
	$(SHAPES:%=docs/%.svg) \
	docs/usage.md

EXAMPLES =\
	examples/layout.svg\
	examples/trig.svg\
	examples/trig-2plots.svg\
	examples/trig-points.svg\
	examples/trig-bar.svg\
	examples/trig-80-120.svg
JSFILES = $(CANVASFILES:data/%.canvas=generated/%.js)
OPTFILES = $(wildcard data/*.opts)
PDFOPTFILES = $(shell egrep -lv -- '--(css|nohover|svg)' data/*.opts)
PDFFILES = $(PDFOPTFILES:data/%.opts=generated/%.pdf)
PNGOPTFILES = $(shell egrep -lv -- '--(css|nohover|svg)' data/*.opts)
PNGFILES = $(PNGOPTFILES:data/%.opts=generated/%.png)
PNGOPTFILES = $(shell egrep -lv -- '--(css|nohover|svg)' data/*.opts)
PNGFILES = $(PNGOPTFILES:data/%.opts=generated/%.png)
SHAPES = $(shell $(CSV2) list shapes)
SVGFILES = $(OPTFILES:data/%.opts=generated/%.svg)
TXTFILES = $(OPTFILES:data/%.opts=generated/%.txt)

JSINDEXMAKE = scripts/jsIndexMake.sh
PDFINDEXMAKE = scripts/pdfIndexMake.sh
PNGINDEXMAKE = scripts/pngIndexMake.sh
SVGINDEXMAKE = scripts/svgIndexMake.sh

.PHONY:	all build clean docs error.expected examples canvas png pdf svg release

all:	generated/.made \
	generated/svgindex.html \
	generated/pngindex.html \
	generated/jsindex.html	\
	generated/pdfindex.html

clean:
	- rm -rfv generated
	- rm -fv out.*

build:
	xcodebuild -scheme csv2 build

release:
	xcodebuild -scheme "Release csv2" build

canvas: generated/jsindex.html

png: generated/pngindex.html

pdf:	generated/pdfindex.html

svg: generated/svgindex.html

docs: $(DOCFILES)

examples: $(EXAMPLES)

generated/.made:
	-mkdir $(@D)
	@ touch $@

generated/svgindex.html: EXTRAS = generated/logo.svg out.svg $(SVGINDEXMAKE) $(EXAMPLES)
generated/svgindex.html: $(SVGFILES) $(TXTFILES) $(EXTRAS)
	@ $(SVGINDEXMAKE) $@
	@ echo svgindex made

generated/jsindex.html: EXTRAS = generated/logo.svg out.js $(JSINDEXMAKE)
generated/jsindex.html: $(JSFILES) $(TXTFILES) $(EXTRAS)
	@ $(JSINDEXMAKE) $@
	@ echo jsindex made

generated/pdfindex.html: EXTRAS = out.pdf $(PDFINDEXMAKE)
generated/pdfindex.html: $(PDFFILES) $(TXTFILES) $(EXTRAS)
	@ $(PDFINDEXMAKE) $@
	@ echo pdfindex made

generated/pngindex.html: EXTRAS = generated/logo.svg out.png $(PNGINDEXMAKE)
generated/pngindex.html: $(PNGFILES) $(TXTFILES) $(EXTRAS)
	@ $(PNGINDEXMAKE) $@
	@ echo pngindex made

generated/%.js: OPTS = $(shell cat $(@F:%.js=data/%.opts))
generated/%.js: CANVAS = $(shell cat $(@F:%.js=data/%.canvas))
generated/%.js: data/%.csv data/%.json data/%.opts $(CSV2)
	-@ $(CSV2) canvas $(OPTS) --canvas $(CANVAS) \
		--tag $(@:%.js=%.canvastag) \
		$(@F:%.js=data/%.csv) $(@F:%.js=data/%.json) $@

generated/trig+trig-inc.svg: data/trig.inc

generated/%.svg: OPTS = $(shell cat $(@F:%.svg=data/%.opts))
generated/%.svg: data/%.csv data/%.json data/%.opts $(CSV2)
	-@ $(CSV2) svg $(OPTS) $(@F:%.svg=data/%.csv) $(@F:%.svg=data/%.json) $@

generated/%.pdf: OPTS = $(shell cat $(@F:%.pdf=data/%.opts))
generated/%.pdf: data/%.csv data/%.json data/%.opts $(CSV2)
	-@ $(CSV2) pdf $(OPTS) --tag $(@:%.pdf=%.pdftag) \
		$(@F:%.pdf=data/%.csv) $(@F:%.pdf=data/%.json) $@

generated/%.png: OPTS = $(shell cat $(@F:%.png=data/%.opts))
generated/%.png: data/%.csv data/%.json data/%.opts $(CSV2)
	-@ $(CSV2) png $(OPTS) $(@F:%.png=data/%.csv) $(@F:%.png=data/%.json) $@

generated/%.txt: data/%.txt data/br.inc data/%.opts
	@ cat $^ > $@

generated/trig+trig-inc.svg: data/trig.inc

generated/z+none-1.js: error.expected
generated/z+none-1.png: error.expected
generated/z+none-1.svg: error.expected

generated/logo.svg: data/logo.svg
	@ cp $< $@

error.expected:
	@ tput 1>&2 smso
	@ echo 1>&2 Error loading data expected!
	@ tput 1>&2 rmso

out.svg out.js out.png:
	touch $@

docs/%.svg: $(CSV2)
	-@ $(CSV2) svg show $(@F:%.svg=%) -cssid $(@F:%.svg=%) -colours green \
		-nocomment -- - - $@

docs/usage.md:	$(CSV2)
	-@ $(CSV2) help usage -md >& $@

examples/trig.svg: data/trig.csv examples/trig.json
	-@ $(CSV2) svg --nocomment --cssid=svg-ex1 data/trig.csv examples/trig.json $@

examples/trig-80-120.svg: data/trig.csv examples/trig.json $(CSV2)
	-@ $(CSV2) svg --nocomment --cssid=svg-ex2 --xmin=80 --xmax=120 data/trig.csv examples/trig.json $@

examples/trig-2plots.svg: data/trig.csv examples/trig.json $(CSV2)
	-@ $(CSV2) svg --nocomment --cssid=svg-ex3 --include 5 7 -- data/trig.csv examples/trig.json $@

examples/trig-points.svg: data/trig.csv examples/trig.json $(CSV2)
	-@ $(CSV2) svg --nocomment --cssid=svg-ex4 --showpoints 4 --scattered 5 -- data/trig.csv examples/trig.json $@

examples/trig-bar.svg: data/trig.csv examples/trig.json $(CSV2)
	-@ $(CSV2) svg --nocomment --cssid=svg-ex5 --bared 8 --barwidth 10 --baroffset=0 data/trig.csv examples/trig.json $@

examples/layout.svg: data/trig.csv examples/layout.json examples/layout.inc
	-@ $(CSV2) svg data/trig.csv examples/layout.json $@

examples/colourNamesList.png:
	-@ $(CSV2) png show colournames --bg cornsilk --size 12 -- - - $@
