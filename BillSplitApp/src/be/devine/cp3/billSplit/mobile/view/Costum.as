/**
 * Created with IntelliJ IDEA.
 * User: School
 * Date: 11/12/13
 * Time: 13:47
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.billSplit.mobile.view {
import starling.events.Event;

public class Costum extends Screen
{
    public static const CLICKED:String = "clicked";

    public function Costum()
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
