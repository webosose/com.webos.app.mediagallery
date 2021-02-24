# @@@LICENSE
#
# (c) Copyright 2015 LG Electronics
#
# Confidential computer software. Valid license from LG required for
# possession, use or copying. Consistent with FAR 12.211 and 12.212,
# Commercial Computer Software, Computer Software Documentation, and
# Technical Data for Commercial Items are licensed to the U.S. Government
# under vendor's standard commercial license.
#
# LICENSE@@@

TEMPLATE = aux

uri = Eos.Controls.SkullCloseButton

!defined(WEBOS_INSTALL_QML, var) {
    instbase = $$[QT_INSTALL_QML]
} else {
    instbase = $$WEBOS_INSTALL_QML
}

skullclosebutton.base = $$_PRO_FILE_PWD_
skullclosebutton.files = $$files(*.qml) $$files(images/*.png)
skullclosebutton.path = $$instbase/$$replace(uri, \\., /)

INSTALLS += skullclosebutton
