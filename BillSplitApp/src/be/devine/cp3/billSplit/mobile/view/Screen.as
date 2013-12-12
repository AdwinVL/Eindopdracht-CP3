package be.devine.cp3.billSplit.mobile.view {
import be.devine.cp3.billSplit.model.AppModel;

import feathers.controls.Header;

import starling.display.Sprite;
import starling.display.Stage;
import starling.events.Event;

public class Screen extends Sprite
{
    public var _appModel:AppModel;
    public var _header:Header;
    public var stageRef:Stage;

    public function Screen()
    {
        _appModel = AppModel.getInstance();

        _header = new Header();
        addChild( _header );

        addEventListener(starling.events.Event.ADDED_TO_STAGE, addedHandler);
    }

    private function addedHandler(event:Event):void
    {
        stageRef = this.stage;
    }

}
}
