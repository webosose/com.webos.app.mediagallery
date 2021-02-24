/* @@@LICENSE
 *
 * Copyright (c) 2021 LG Electronics, Inc.
 *
 * Confidential computer software. Valid license from LG required for
 * possession, use or copying. Consistent with FAR 12.211 and 12.212,
 * Commercial Computer Software, Computer Software Documentation, and
 * Technical Data for Commercial Items are licensed to the U.S. Government
 * under vendor's standard commercial license.
 *
 * LICENSE@@@ */

import QtQuick 2.4

QtObject {
    function listProperty(item)
    {
        for (var p in item) {
            appLog.debug(p + ": " + item[p] + " " + typeof(item[p]));
            for(var q in item[p]) {
                    appLog.debug(q + ": " + item[p][q] + " " + typeof(item[p][q]));
            }
        }

    }
}
