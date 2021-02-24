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


TEMPLATE = aux
uri = Eos.Style

QML_FILES = \
    qmldir \
    $$files(moonstone/*.qml)

OTHER_FILES += QML_FILES

!defined(WEBOS_INSTALL_QML, var) {
    instbase = $$[QT_INSTALL_QML]
} else {
    instbase = $$WEBOS_INSTALL_QML
}

styles.base = $$_PRO_FILE_PWD_
styles.files = $$QML_FILES
styles.path = $$instbase/$$replace(uri, \\., /)

INSTALLS += styles
