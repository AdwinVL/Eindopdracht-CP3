package be.devine.cp3.billSplit.mobile.view {
import starling.events.Event;

public class Settings extends Screen
{
    public static const CLICKED:String = "clicked";

    public function Settings()
    {

    }

    private function addedHandler():void
    {
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
