OBJS:= $(shell find prouzalib* -type f \( -iname \*.*pgm -o -iname \*.file \) | sed 's/$$/.obj/')
OBJS:= prouzalib/$$test.rpgle.pgm.obj

VPATH=build

#OBJS_NEU=$(shell find prouzalib* -type f \( -iname \*.*pgm \) | sed 's/$$/.obj/' | sed 's/#/\\#/' | sed 's/\\$$/\\$$$$\\$$$$/')
#OBJS:= $(shell find prouzalib* -type f \( -iname \*y.rpgle.pgm \) | sed 's/$$/.obj'"'"'/' | sed 's/^/'"'"'/' | sed 's/#/\\#/' | sed 's/\$$/\$$\$$\$$\$$/')
OBJS= $(shell find prouzalib* -type f \( -iname \*.pf.file \) | sed 's/$$/.obj/' | sed 's/\$$/\$$\$$/' )# | sed 's/#/\\#/'  )
#OBJS:=build/prouzalib/qrpglesrc/$$$$t§§x\#y.rpgle.pgm.obj

#SRC_PREREQ=$(subst \#,\\\#,$(subst $$,$$$$$$$$,$@))
SRC_PREREQ=$$(basename $$@)
#ok#SRC_PREREQ=prouzalib/qrpglesrc/$$$$t§§x\#y.rpgle.pgm

FOO = 123-456-789.obj

.SECONDEXPANSION:
%.srvpgm.obj: README.md
	$(info SRVPGM)
	$(info basename $$(basename $$@))

#.SECONDEXPANSION:
%.pf.file.obj: $(SRC_PREREQ)
#%.pgm.obj: prouzalib/qrpglesrc/$$$$t§§x\#y.rpgle.pgm
	$(info PGM)
	$(info 0.1 Pre: $<)
	$(info 0.2 $@)
	$(info 0.3 $*)
#	$(info 0.4 Pre: $^)
#	$(info 0.6 Pre: $?)
#	$(info 0.7 Empty: $%)
#	$(info 0.8 Pre: $|)
#	$(info 0.9 Pre: $+)
#	$(info 1.1 Obj Lib+Srcpf: $(@D))
	$(info 1.2 Obj Filename: $(basename $(basename $(basename $(@F)))))
#	$(info 1 $(patsubst .obj,,$^))
#	$(info 1 $(^:.obj=))
#	$(info 2 $(basename $^)')
#	MAKEFILE_DIR=$(shell dirname $(abspath $(lastword $(MAKEFILE_LIST))))
#	$(info 3 $(shell echo $@ | cut -d "/" -f1 ))
#	$(info 4 $(patsubst %/%,%,$(dir $(patsubst %/,%,$(dir $@)))))
#	$(info 5 $(SRC_PREREQ)')
#	$(info 6 basename $(basename $(SRC_PREREQ)))
#	$(info 7 dir $(dir $@))
#	$(info 7 dir $(dir $(patsubst %/,%,$(dir $(subst ',,$@)))))
#	$(info 7 dir $(wordlist 1,2,$(subst /, ,$(subst ',,$@))))
	echo ${$@%/*}
	echo "PGM Test"
	echo $(FOO:.obj=)


.PHONY: all
all: $(OBJS)
	$(info Test $(OBJS))
	echo "All Test"

