/* @@@LICENSE
 *
 * Copyright (c) 2014 LG Electronics, Inc.
 *
 * Confidential computer software. Valid license from LG required for
 * possession, use or copying. Consistent with FAR 12.211 and 12.212,
 * Commercial Computer Software, Computer Software Documentation, and
 * Technical Data for Commercial Items are licensed to the U.S. Government
 * under vendor's standard commercial license.
 *
 * LICENSE@@@ */

import QtQuick 2.4
import Eos.Style 0.1

/*!
    \qmltype Picker
    \since Eos 0.1
    \brief The picker element holds a selection of
    items - similar to a listview. In opposite
    to a list view only one item is shown at a time.
    Semantically the picker is similar to a
    combobox.
*/
FocusScope {
    id: root

    /*!
        \qmlproperty variant style

        Points to a picker style element that describes the styling
        of the picker. There is no default implementation for this
        property.
    */
    property variant style

    // Semantically this is very similar to Qt's Combobox.
    // Maybe rename it?

    /*!
        \qmlproperty variant model

        This property allows to assign a ListModel to the picker.
    */
    property variant model

    /*!
        \qmlproperty real currentIndex

        This property allows to assign a ListModel to the picker.
    */
    property real currentIndex: 0

    /*!
        \qmlproperty real currentText

        This property allows to retrieve the current text of the picker.
    */
    property string currentText: (model !== undefined && model.get(currentIndex) !== undefined) ? model.get(currentIndex).name : ""

    /*!
        \qmlmethod incrementCurrentIndex()

        This method increments the current index by one.
    */
    function incrementCurrentIndex() {
        if (model === undefined) {
            currentIndex = 0;
            return;
        }

        ++currentIndex;
        if (currentIndex >= model.count) {
            currentIndex = 0;
        }
    }

    /*!
        \qmlmethod decrementCurrentIndex()

        This method decrements the current index by one.
    */
    function decrementCurrentIndex() {
        if (model === undefined) {
            currentIndex = 0;
            return;
        }

        --currentIndex;
        if (currentIndex < 0) {
            currentIndex = model.count - 1;
        }
    }
}
