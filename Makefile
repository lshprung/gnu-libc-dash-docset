DOCSET_NAME = glibc

DOCSET_DIR    = $(DOCSET_NAME).docset
CONTENTS_DIR  = $(DOCSET_DIR)/Contents
RESOURCES_DIR = $(CONTENTS_DIR)/Resources
DOCUMENTS_DIR = $(RESOURCES_DIR)/Documents

INFO_PLIST_FILE = $(CONTENTS_DIR)/Info.plist
INDEX_FILE      = $(RESOURCES_DIR)/docSet.dsidx
ICON_FILE       = $(DOCSET_DIR)/icon.png
ARCHIVE_FILE    = $(DOCSET_NAME).tgz

SRC_ICON = src/icon.png

MANUAL_URL  = https://www.gnu.org/software/libc/manual/html_node/libc-html_node.tar.gz
MANUAL_FILE = tmp/libc-html_node.tar.gz

ERROR_DOCSET_NAME = $(error DOCSET_NAME is unset)
WARNING_MANUAL_URL = $(warning MANUAL_URL is unset)
ERROR_MANUAL_FILE = $(error MANUAL_FILE is unset)
.phony: err warn

ifndef DOCSET_NAME
err: ; $(ERROR_DOCSET_NAME)
endif

ifndef MANUAL_FILE
err: ; $(ERROR_MANUAL_FILE)
endif

ifndef MANUAL_URL
warn: 
	$(WARNING_MANUAL_URL)
	$(MAKE) all
endif

DOCSET = $(INFO_PLIST_FILE) $(INDEX_FILE)
ifdef SRC_ICON
DOCSET += $(ICON_FILE)
endif

all: $(DOCSET)

archive: $(ARCHIVE_FILE)

clean:
	rm -rf $(DOCSET_DIR) $(ARCHIVE_FILE)

dist-clean: clean
	rm -rf tmp

tmp:
	mkdir -p $@

$(ARCHIVE_FILE): $(DOCSET)
	tar --exclude='.DS_Store' -czf $@ $(DOCSET_DIR)

$(MANUAL_FILE): tmp
	curl -o $@ $(MANUAL_URL)

$(DOCSET_DIR):
	mkdir -p $@

$(CONTENTS_DIR): $(DOCSET_DIR)
	mkdir -p $@

$(RESOURCES_DIR): $(CONTENTS_DIR)
	mkdir -p $@

$(DOCUMENTS_DIR): $(RESOURCES_DIR) $(MANUAL_FILE)
	mkdir -p $@
	tar -x -z -f $(MANUAL_FILE) -C $@

$(INFO_PLIST_FILE): src/Info.plist $(CONTENTS_DIR)
	cp src/Info.plist $@

$(INDEX_FILE): src/index-page.sh src/index-terms.sh $(DOCUMENTS_DIR)
	rm -f $@
	src/index-page.sh $@ $(DOCUMENTS_DIR)/libc/*.html
	src/index-terms.sh "Entry" $@ $(DOCUMENTS_DIR)/libc/Concept-Index.html
	src/index-terms.sh "Type" $@ $(DOCUMENTS_DIR)/libc/Type-Index.html
	src/index-terms.sh "Function" $@ $(DOCUMENTS_DIR)/libc/Function-Index.html
	src/index-terms.sh "Variable" $@ $(DOCUMENTS_DIR)/libc/Variable-Index.html
	src/index-terms.sh "File" $@ $(DOCUMENTS_DIR)/libc/File-Index.html

$(ICON_FILE): src/icon.png $(DOCSET_DIR)
	cp $(SRC_ICON) $@
