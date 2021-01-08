# @@@LICENSE
#
# Copyright (c) 2014-2015 LG Electronics, Inc.
#
# Confidential computer software. Valid license from LG required for
# possession, use or copying. Consistent with FAR 12.211 and 12.212,
# Commercial Computer Software, Computer Software Documentation, and
# Technical Data for Commercial Items are licensed to the U.S. Government
# under vendor's standard commercial license.
#
# LICENSE@@@


TEMPLATE = subdirs
SUBDIRS = SkullCloseButton

uri = Eos.Controls

QML_FILES = \
    qmldir \
    $$files(*.qml) \
    $$files(*.js)

!defined(WEBOS_INSTALL_QML, var) {
    instbase = $$[QT_INSTALL_QML]
} else {
    instbase = $$WEBOS_INSTALL_QML
}

controls.base = $$_PRO_FILE_PWD_
controls.files = $$QML_FILES
controls.path = $$instbase/$$replace(uri, \\., /)

INSTALLS += controls
