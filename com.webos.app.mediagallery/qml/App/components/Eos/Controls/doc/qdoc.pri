# @@@LICENSE
#
# Copyright (c) 2014 LG Electronics, Inc.
#
# Confidential computer software. Valid license from LG required for
# possession, use or copying. Consistent with FAR 12.211 and 12.212,
# Commercial Computer Software, Computer Software Documentation, and
# Technical Data for Commercial Items are licensed to the U.S. Government
# under vendor's standard commercial license.
#
# LICENSE@@@


# http://qt-project.org/doc/qt-5/qdoc-guide.html

!exists($$QMAKE_DOCS): error("Cannot find documentation specification file $$QMAKE_DOCS")

QMAKE_DOCS_BASE_OUTDIR = $$PWD/doc

QMAKE_DOCS_TARGET = $$replace(QMAKE_DOCS, ^(.*/)?(.*)\\.qdocconf$, \\2)
QMAKE_DOCS_OUTPUTDIR = $$QMAKE_DOCS_BASE_OUTDIR/$$QMAKE_DOCS_TARGET

qtPrepareTool(QDOC, qdoc)

html_docs.commands += $$QDOC $$QMAKE_DOCS
html_docs.target = docs

QMAKE_EXTRA_TARGETS += html_docs
PRE_TARGETDEPS += docs
