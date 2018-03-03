using Toybox.Application as App;
using CasterCore.Standard as Std;

class CasterApp extends App.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    function onStart(state) {
    }

    function onStop(state) {
    }

    function getInitialView() {
    	return [ Std.BuildDataField() ];
    }

}