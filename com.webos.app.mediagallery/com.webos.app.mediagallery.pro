# @@@LICENSE
#
# Copyright (c) 2020-2021 LG Electronics, Inc.
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

include($$PWD/shader.pri)

# !load(webos-variables):error("Cannot load webos-variables.prf")

# for qtcreator cross-referencing qml types
# OTHER_FILES += $$files(*.qml)

defined(WEBOS_INSTALL_WEBOS_APPLICATIONSDIR, var) {
    INSTALL_APPDIR = $$WEBOS_INSTALL_WEBOS_APPLICATIONSDIR/com.webos.app.mediagallery
    INSTALL_JSONDIR = $$INSTALL_APPDIR
    INSTALL_QMLDIR = $$INSTALL_APPDIR/qml
    INSTALL_SHADERDIR = $$INSTALL_QMLDIR/App

    json.path = $$INSTALL_JSONDIR
    json.files += appinfo.json icon.png
    qml.path = $$INSTALL_QMLDIR
    qml.files = qml/App

    shader_eos_es.path = $$INSTALL_SHADERDIR/components/Eos/Controls
    shader_eos_es.files = $$ELIDESHADER
    shader_eos_sci.path = $$INSTALL_SHADERDIR/components/Eos/Items
    shader_eos_sci.files = $$SMOOTHCLIPITEM
    shader_qmlapp_rcs.path = $$INSTALL_SHADERDIR/components/QmlAppComponents/Shader
    shader_qmlapp_rcs.files = $$ROUNDCROPSHADER

    INSTALLS += json qml shader_eos_es shader_eos_sci shader_qmlapp_rcs
}
