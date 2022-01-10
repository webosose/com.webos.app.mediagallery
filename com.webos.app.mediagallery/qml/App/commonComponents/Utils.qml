/* @@@LICENSE
*
*      Copyright (c) 2021 LG Electronics, Inc.
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
* http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*
* LICENSE@@@ */

import QtQuick 2.6

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
