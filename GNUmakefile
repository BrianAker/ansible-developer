# vim:ft=make
#
_bootstrap_Makefile := $(wildcard aux)
_bootstrap_aux := $(wildcard aux)

.SUFFIXES:
.NOTPARALLEL:
srcdir= .
PROJECT=basename $(pwd)

ifneq ($(_bootstrap_Makefile),)
  git clone git@github.com:BrianAker/$(PROJECT) .
endif

ifneq ($(_bootstrap_aux),)
  include Makefile
else
.DEFAULT_GOAL:= basic_build
aux/README.md:
	git submodule init

.PHONY: basic_build
basic_build: aux/README.md
	@$(MAKE) $(AM_MAKEFLAGS)
endif

ALL_RECURSIVE_TARGETS+= $(AM_RECURSIVE_TARGETS)

ifneq ($(word 2, $(MAKECMDGOALS)), )
ifneq ($(filter $(ALL_RECURSIVE_TARGETS), $(MAKECMDGOALS)), )
.NOTPARALLEL:
endif
endif
