package be.devine.cp3.billSplit.mobile.view {
import be.devine.cp3.billSplit.model.AppModel;

import feathers.controls.Header;

import starling.display.Sprite;

public class Screen extends Sprite
{
    public var _appModel:AppModel;

    public var _header:Header;

    public function Screen()
    {
        _appModel = AppModel.getInstance();

        _header = new Header();
        addChild( _header );
    }
}
}
