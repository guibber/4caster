using Toybox.WatchUi as Ui;
using Toybox.System;
using CasterCore.Utils as Utils;

class CasterView extends Ui.SimpleDataField {
	
	var mView = null;
	
	function initialize(view) {
        SimpleDataField.initialize();
        mView = view;
        label = mView.GetLabel();
    }

    function compute(info) {
    	return mView.GetComputeViewString(info);
    }
}