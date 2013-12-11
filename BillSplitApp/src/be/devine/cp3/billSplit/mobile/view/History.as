/**
 * Created with IntelliJ IDEA.
 * User: School
 * Date: 11/12/13
 * Time: 14:25
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.billSplit.mobile.view {
import be.devine.cp3.billSplit.model.AppModel;

import starling.display.Sprite;
import starling.events.Event;

public class History extends Sprite
{
    public static const CLICKED:String = "clicked";
    private var _appModel:AppModel;

    public function History()
    {
        _appModel = AppModel.getInstance();

    }

    private function addedHandler():void
    {
        include "parts/header.as"
        removeEventListener(starling.events.Event.ADDED_TO_STAGE, addedHandler);
        stage.addEventListener(starling.events.Event.RESIZE, resizeHandler);
        layout();
    }
    private function resizeHandler(event:starling.events.Event):void
    {
        layout();
    }

    private function layout():void
    {

    }
}
}
