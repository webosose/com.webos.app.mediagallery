/* @@@LICENSE
 *
 * Copyright (c) <2013-2014> LG Electronics, Inc.
 *
 * Confidential computer software. Valid license from LG required for
 * possession, use or copying. Consistent with FAR 12.211 and 12.212,
 * Commercial Computer Software, Computer Software Documentation, and
 * Technical Data for Commercial Items are licensed to the U.S. Government
 * under vendor's standard commercial license.
 *
 * LICENSE@@@ */

import QtQuick 2.4
import WebOSServices 1.0

Service {
    property var sCallback;
    property var fCallback;

    onCallResponse: {
        if(response.returnValue === true) {
            if(sCallback)
                sCallback.call(response);
        } else {
            if(fCallback)
                fCallback.call(response);
        }
    }

    function find(query, successCallback, failureCallback) {
        appLog.warn("FIND IN DB");
        sCallback = successCallback;
        fCallback = failureCallback;
        call("luna://com.palm.db/", "/find", query);
    }

    function putKind(query, scb, fcb) {
        sCallback = scb;
        fCallback = fcb;
        call("luna://com.palm.db/", "/putKind", query);
    }

    function delKind(query, scb, fcb) {
        sCallback = scb;
        fCallback = fcb;
        call("luna://com.palm.db/", "/delKind", query);
    }

    function put(query, scb, fcb) {
        sCallback = scb;
        fCallback = fcb;
        call("luna://com.palm.db/", "/put", query);
    }

    function merge(query, scb, fcb) {
        sCallback = scb;
        fCallback = fcb;
        call("luna://com.palm.db/", "/merge", query);
    }

    function get(query, scb, fcb) {
        sCallback = scb;
        fCallback = fcb;
        call("luna://com.palm.db/", "/get", query);
    }

    function batch(query, scb, fcb) {
        sCallback = scb;
        fCallback = fcb;
        call("luna://com.palm.db/", "/batch", query);
    }

    // does not exist in main
//    function putMerge(query, scb, fcb) {
//        sCallback = scb;
//        fCallback = fcb;
//        call("luna://com.palm.db/", "/putMerge", query);
//    }

    function del(query, scb, fcb) {
        sCallback = scb;
        fCallback = fcb;
        call("luna://com.palm.db/", "/del", query);
    }

    function search(query, scb, fcb) {
        sCallback = scb;
        fCallback = fcb;
        call("luna://com.palm.db/", "/search", query);
    }

    function collate(query, scb, fcb) {
        sCallback = scb;
        fCallback = fcb;
        call("luna://com.palm.db/", "/collate", query);
    }

}

