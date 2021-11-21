MKDIR_P := mkdir -p

RELEASE_DOC_FILES := copyright envylogger.html README.md
RELEASE_DOC_DIR := ./usr/local/share/doc/envylogger
RELEASE_MAN_FILES := envylogger.1.gz
RELEASE_MAN_DIR := ./usr/local/share/man/man1
RELEASE_SBIN_FILES := envylogger
RELEASE_SBIN_DIR := ./usr/local/sbin

directories := ${RELEASE_SBIN_DIR} ${RELEASE_MAN_DIR} ${RELEASE_DOC_DIR}


.PHONY: release release_dirs release_cleanall release_docs release_man release_sbin

release: envylogger.tar.gz

envylogger.tar.gz: release_docs release_man release_sbin
	tar czf envylogger.tar.gz ./usr
	if [ -d ./usr ] && [ -f envylogger.tar.gz ]; then rm -r ./usr; fi

release_cleanall:
	if [ -d ./usr ]; then rm -r ./usr; fi

release_dirs: release_cleanall
	for d in ${directories}; do ${MKDIR_P} $$d; done

release_docs: release_dirs ${RELEASE_DOC_FILES}
	for rf in ${RELEASE_DOC_FILES}; do cp -f $$rf ${RELEASE_DOC_DIR}; done

release_man: release_dirs ${RELEASE_MAN_FILES}
	for rf in ${RELEASE_MAN_FILES}; do cp -f $$rf ${RELEASE_MAN_DIR}; done

release_sbin: release_dirs ${RELEASE_SBIN_FILES}
	for rf in ${RELEASE_SBIN_FILES}; do cp -f $$rf ${RELEASE_SBIN_DIR}; done

