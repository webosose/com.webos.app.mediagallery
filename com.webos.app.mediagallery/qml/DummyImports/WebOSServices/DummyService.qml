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

QtObject {
    property string appId
    signal response(string method, string payload, int token)
    signal callFailure(var response)
    signal callSuccess(var response)
    signal callResponse(var response)
    property var privateMethods
    property var publicMethods
    property int subscriptionToken: 0

    property string service
    property string method

    property url mockUrl;

    property var tokens: []

    function pushSubscription() { }

    // this function exists to give us a complete parseable URI
    function setMockUrl(params) {
        mockUrl = "mock/" + service + method + "/" + params + ".json";
    }

    function call(s, m, params) {
        var xhr = new XMLHttpRequest;
        // TODO: since i refactored use of "service" and "method" out, actually need
        // to stop using them .. just leave them there for qml properties
        service = s.replace("palm://", "");
        service = service.replace("luna://", "");
        if(service.charAt(service.length - 1) == "/")
            service = service.substring(0, service.length - 1);
        s = service;

        method = m;
        if(method.charAt(0) !== "/")
            method = "/" + method;
        m = method;

        // muck this around so that the eventual output becomes a file called similarly to:
        // mock/com.webos.service.eim/getAllInputStatus/_subscribe_true_.json

        if(!params) {
            var p = "__";
        } else {
            if(!params.replace) params = JSON.stringify(params);
            p = params.replace(/{/g, "_");
            p = p.replace(/}/g, "_");
            p = p.replace(/:/g, "_");
            p = p.replace(/"/g, "");
            p = p.replace(/,/g, "_");
            p = p.replace(/\[/g, "_");
            p = p.replace(/]/g, "_");
            p = p.replace(/\\/g, "");
            p = p.replace(/\.\./g, "");
        }
        // hopefully we'll have enough uniqueness at 100 chars without making
        // too insane filenames
        if(p.length > 100)
            p = p.substring(0, 100);

        setMockUrl(p);
        var url = mockUrl.toString();

        xhr.open("GET", url);

        // A tricky way to toss params.
        xhr.onreadystatechange = (function(_this, _method, _params) {
            return function() {
                if(xhr.readyState == XMLHttpRequest.DONE) {
                    if(xhr.responseText.length > 0) {

                        var token = 0;
                        for (var i = 0 ; i < tokens.length; i++ ) {
                            if (tokens[i].method === _method && tokens[i].params === _params)
                                token = tokens[i].token;
                        }

                        response(method, xhr.responseText, token);

                        try {
                            var a = JSON.parse(xhr.responseText);
                        } catch(e) {
                            appLog.warn("Error parsing JSON in " + url);
                            callFailure({ "returnValue": false });
                            callResponse({ "returnValue": false });
                        }

                        callResponse(a);
                        if(a.returnValue === true)
                            callSuccess(a);
                        else
                            callFailure(a);
                    } else {
                        appLog.warn("Mock data not found at ", url);
                        appLog.warn("Method call was: luna-send -n 1 luna://" + s + m + " " + JSON.stringify(params) + "");
                        callResponse({ "returnValue": false });
                        callFailure({ "returnValue": false });
                    }
                }
            }
        })(xhr, m,p);

        xhr.send();

        tokens.push({token:tokens.length,method:m,params:p})

        return tokens[tokens.length-1].token;
    }

    function callService(p) {
        call(service, method, JSON.stringify(p));
    }

    function cancel() {}
}
