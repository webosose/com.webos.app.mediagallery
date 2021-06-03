# @@@LICENSE
#
# Copyright (c) 2021 LG Electronics, Inc.
#
# Confidential computer software. Valid license from LG Electronics required for
# possession, use or copying. Consistent with FAR 12.211 and 12.212,
# Commercial Computer Software, Computer Software Documentation, and
# Technical Data for Commercial Items are licensed to the U.S. Government
# under vendor's standard commercial license.
#
# LICENSE@@@

versionAtLeast(QT_VERSION, 6.0.0) {
    ELIDESHADER = $$system($$PWD/shaderconversion.sh 6 \"$$PWD/qml/Shaders/ElideShader\" \"$$shadowed($$PWD/qml/Shaders/ElideShader)\")
    SMOOTHCLIPITEM = $$system($$PWD/shaderconversion.sh 6 \"$$PWD/qml/Shaders/SmoothClipItem\" \"$$shadowed($$PWD/qml/Shaders/SmoothClipItem)\")
    ROUNDCROPSHADER = $$system($$PWD/shaderconversion.sh 6 \"$$PWD/qml/Shaders/RoundCropShader\" \"$$shadowed($$PWD/qml/Shaders/RoundCropShader)\")
} else {
    ELIDESHADER = $$system($$PWD/shaderconversion.sh 5 \"$$PWD/qml/Shaders/ElideShader\" \"$$shadowed($$PWD/qml/Shaders/ElideShader)\")
    SMOOTHCLIPITEM = $$system($$PWD/shaderconversion.sh 5 \"$$PWD/qml/Shaders/SmoothClipItem\" \"$$shadowed($$PWD/qml/Shaders/SmoothClipItem)\")
    ROUNDCROPSHADER = $$system($$PWD/shaderconversion.sh 5 \"$$PWD/qml/Shaders/RoundCropShader\" \"$$shadowed($$PWD/qml/Shaders/RoundCropShader)\")
}
