package be.devine.cp3.billSplit.mobile.view {
import be.devine.cp3.billSplit.mobile.view.controls.navButton;

import starling.events.Event;
import starling.events.ResizeEvent;

public class Costum extends Screen
{
    public static const CLICKED:String = "clicked";

    private var _buttonToHome:navButton;

    public function Costum()
    {
        _buttonToHome = new navButton('home');
        _buttonToHome.label = 'home';
        _buttonToHome.addEventListener( starling.events.Event.TRIGGERED, triggeredHandler );
        addChild( _buttonToHome );
        setChildIndex(_buttonToHome, 99);

        addEventListener(starling.events.Event.ADDED_TO_STAGE, addedHandler);
    }

    private function addedHandler(event:starling.events.Event):void
    {
        removeEventListener(starling.events.Event.ADDED_TO_STAGE, addedHandler);
        stage.addEventListener(starling.events.Event.RESIZE, resizeHandler);
        addEventListener(starling.events.Event.REMOVED_FROM_STAGE, removedHandler);

        layout();
    }

    private function removedHandler(event:Event):void {
        stageRef.removeEventListener(ResizeEvent.RESIZE, resizeHandler);
    }

    private function triggeredHandler(event:starling.events.Event):void
    {
        var button:navButton = navButton(event.currentTarget);
        _appModel.destination = button.destination;
        dispatchEventWith(CLICKED, true);
    }

    private function resizeHandler(event:starling.events.Event):void
    {
        layout();
    }

    private function layout():void
    {
        _header.title = "splitt da bill";
        _header.setSize(stage.stageWidth, 70);
    }
}
}
