using Toybox.Application as App;
using CasterCore.Config as Cfg;
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
    	return [ new CasterView(Std.BuildView(new Cfg.Settings("4caster", Cfg.DisplayModeStandard, 1609.34))) ];
    }

}