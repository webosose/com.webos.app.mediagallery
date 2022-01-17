# @@@LICENSE
#
#      Copyright (c) 2020-2021 LG Electronics, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
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
