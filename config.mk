SRC_ICON_FILE = $(SOURCE_DIR)/icon.png
INDEX_ENTRY_CLASS=printindex-index-entry

VERSION=latest
MANUAL_URL  = https://sourceware.org/glibc/manual/$(VERSION)/html_node/libc-html_node.tar.gz
MANUAL_FILE = tmp/libc-html_node.tar.gz

$(MANUAL_FILE): tmp
	curl -o $@ $(MANUAL_URL)

$(DOCUMENTS_DIR): $(RESOURCES_DIR) $(MANUAL_FILE)
	mkdir -p $@
	tar -x -z -f $(MANUAL_FILE) -C $@

$(INDEX_FILE): $(SOURCE_DIR)/src/index-pages.py $(SCRIPTS_DIR)/gnu/index-terms.py $(DOCUMENTS_DIR)
	rm -f $@
	$(SOURCE_DIR)/src/index-pages.py $@ $(DOCUMENTS_DIR)/libc/*.html
	$(SCRIPTS_DIR)/gnu/index-terms.py "Entry"    $(INDEX_ENTRY_CLASS) $@ $(DOCUMENTS_DIR)/libc/Concept-Index.html
	$(SCRIPTS_DIR)/gnu/index-terms.py "Type"     $(INDEX_ENTRY_CLASS) $@ $(DOCUMENTS_DIR)/libc/Type-Index.html
	$(SCRIPTS_DIR)/gnu/index-terms.py "Function" $(INDEX_ENTRY_CLASS) $@ $(DOCUMENTS_DIR)/libc/Function-Index.html
	$(SCRIPTS_DIR)/gnu/index-terms.py "Variable" $(INDEX_ENTRY_CLASS) $@ $(DOCUMENTS_DIR)/libc/Variable-Index.html
	$(SCRIPTS_DIR)/gnu/index-terms.py "File"     $(INDEX_ENTRY_CLASS) $@ $(DOCUMENTS_DIR)/libc/File-Index.html
