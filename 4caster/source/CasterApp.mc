using Toybox.Application as App;
using CasterCore.Config as Cfg;

class CasterApp extends App.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state) {
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
    }

    // Return the initial view of your application here
    function getInitialView() {
        return [ new CasterView(new Cfg.Settings("4caster", Cfg.DisplayModeStandard, 1609.34)) ];
    }

}