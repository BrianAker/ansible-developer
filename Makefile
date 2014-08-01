# vim:ft=make

.SUFFIXES:
.SUFFIXES:

BUILD:=
CHECK:=
DISTCLEAN:=
MAINTAINERCLEAN:=
PREREQ=

PKG_INSTALLER=
PKG_UPDATE=
PKG_UPGRADE=
PKG_SEARCH_INSTALL= $(PKG_INSTALLER) $(1)
BASE_INSTALL_PATH= /usr/

include aux/include.mk

PLAYBOOKS+= $(wildcard playbooks/*.yml) 

DIST_MAKEFILES:=

.PHONY: clean
clean:
	@rm -rf $(BUILD)
	@find roles | grep role.yml | xargs rm

.PHONY: distclean
distclean: clean distclean-am

.PHONY: distclean-am
distclean-am:
	@rm -rf $(DISTCLEAN)

.PHONY: maintainer-clean
maintainer-clean: distclean
	@rm -rf $(MAINTAINERCLEAN)

.PHONY: check
check: all $(CHECK)

DIR= roles files .inventory/host_vars .inventory/group_vars
DIR_DIRSTMP:= $(addsuffix /.dirstamp, $(DIR))
PREREQ+= $(DIR_DIRSTMP)

$(DIR_DIRSTMP):
	-@mkdir -p $(@D)
	@touch $@
PREREQ+= $(DIR_DIRSTMP)

.inventory/localhost:
	@echo "localhost" > $@
PREREQ+= .inventory/localhost

.PHONY: install
install: all
	$(ANSIBLE_PLAYBOOK) site.yml -u deploy

.PHONY: upgrade
upgrade: all
	$(ANSIBLE_PLAYBOOK) maintenance.yml

all: $(PREREQ) $(BUILD)

.DEFAULT_GOAL:= all

.NOTPARALLEL:
