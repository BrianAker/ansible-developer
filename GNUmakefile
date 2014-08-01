# vim:ft=make
#
_bootstrap_Makefile := $(wildcard Makefile)

.SUFFIXES:
.NOTPARALLEL:
srcdir= .
PROJECT= $(shell basename `pwd`)

ifneq ($(_bootstrap_Makefile),)
  include Makefile
else
.DEFAULT_GOAL:= basic_build

Makefile:
	git clone git@github.com:BrianAker/$(PROJECT) .
	git submodule init
	git submodule update

.PHONY: basic_build
basic_build: Makefile
	@$(MAKE) $(AM_MAKEFLAGS)
endif

ALL_RECURSIVE_TARGETS+= $(AM_RECURSIVE_TARGETS)

ifneq ($(word 2, $(MAKECMDGOALS)), )
ifneq ($(filter $(ALL_RECURSIVE_TARGETS), $(MAKECMDGOALS)), )
.NOTPARALLEL:
endif
endif
