# @@@LICENSE
#
# Copyright (c) <2020> LG Electronics, Inc.
#
# Confidential computer software. Valid license from LG Electronics required for
# possession, use or copying. Consistent with FAR 12.211 and 12.212,
# Commercial Computer Software, Computer Software Documentation, and
# Technical Data for Commercial Items are licensed to the U.S. Government
# under vendor's standard commercial license.
#
# LICENSE@@@


TEMPLATE = aux
QT = quick qml
CONFIG += webos

# !load(webos-variables):error("Cannot load webos-variables.prf")

# for qtcreator cross-referencing qml types
# OTHER_FILES += $$files(*.qml)

defined(WEBOS_INSTALL_WEBOS_APPLICATIONSDIR, var) {
    INSTALL_APPDIR = $$WEBOS_INSTALL_WEBOS_APPLICATIONSDIR/com.webos.app.avn.music
    INSTALL_JSONDIR = $$INSTALL_APPDIR
    INSTALL_QMLDIR = $$INSTALL_APPDIR/qml

    json.path = $$INSTALL_JSONDIR
    json.files += appinfo.json icon.png
    qml.path = $$INSTALL_QMLDIR
    qml.files = qml/App

    INSTALLS += json qml
}
