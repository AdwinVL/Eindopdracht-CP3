package be.devine.cp3.billSplit.mobile.view.pages {
import be.devine.cp3.billSplit.mobile.view.*;
import be.devine.cp3.billSplit.mobile.view.controls.NavButton;

import feathers.controls.ToggleSwitch;

import starling.display.DisplayObject;

import starling.events.Event;
import starling.events.ResizeEvent;

public class Settings extends Screen
{
    public static const CLICKED:String = "clicked";

    private var _btnHome:NavButton;

    private var _toggle:ToggleSwitch;

    public function Settings()
    {
        _btnHome = new NavButton('home');
        _btnHome.label = 'home';
        _btnHome.addEventListener( starling.events.Event.TRIGGERED, triggeredHandler );

        _header.leftItems = new <DisplayObject>[ _btnHome ];

        _toggle = new ToggleSwitch();
        _toggle.isSelected = true;
        addChild( _toggle );

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
        var button:NavButton = NavButton(event.currentTarget);
        _appModel.destination = button.destination;
        dispatchEventWith(CLICKED, true);
    }

    private function resizeHandler(event:starling.events.Event):void
    {
        layout();
    }

    private function layout():void
    {
        _header.title = "settings";
        _header.setSize(stage.stageWidth, 70);

        _toggle.x = 10;
        _toggle.y = _header.height + 20;
        _toggle.setSize(stage.stageWidth - 20, 50);
    }
}
}
