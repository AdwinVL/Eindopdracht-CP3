package be.devine.cp3.billSplit.mobile.view.controls {
import be.devine.cp3.billSplit.model.AppModel;

import feathers.controls.Button;

public class navButton extends Button {

    private var _appModel:AppModel;

    public var destination:String;

    public function navButton(destination:String)
    {
        _appModel = AppModel.getInstance();

        this.destination = destination;
    }
}
}
