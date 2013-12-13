package be.devine.cp3.billSplit.mobile.view {
import be.devine.cp3.billSplit.mobile.view.controls.navButton;

import feathers.controls.Label;

import feathers.controls.TextInput;

import starling.display.DisplayObject;

import starling.events.Event;
import starling.events.ResizeEvent;

public class Split extends Screen
{
    public static const CLICKED:String = "clicked";

    private var _btnHome:navButton;
    private var _btnNext:navButton;

    private var _lblToPay:Label;
    private var _toPay:TextInput;

    public function Split()
    {

        _btnHome = new navButton('home');
        _btnHome.label = 'home';
        _btnHome.addEventListener( starling.events.Event.TRIGGERED, triggeredHandler );

        _btnNext = new navButton('custom');
        _btnNext.label = 'next';
        _btnNext.addEventListener( starling.events.Event.TRIGGERED, triggeredHandler );

        _header.leftItems = new <DisplayObject>[ _btnHome ];
        _header.rightItems = new <DisplayObject>[ _btnNext ];

        _lblToPay = new Label();
        _lblToPay.text = 'How much to pay?';
        addChild(_lblToPay);

        _toPay = new TextInput();
        _toPay.maxChars = 4;
        _toPay.restrict = "0-9";
        addChild(_toPay);

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

        layout();
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
        _header.title = String(_appModel.payers) + '-way split';
        _header.setSize(stage.stageWidth, 120);

        _lblToPay.x = 15;
        _lblToPay.y = _header.height + 20;
        _lblToPay.setSize(stage.stageWidth - 30, 30);

        _toPay.x = 15;
        _toPay.y = _header.height + _lblToPay.height + 20;
        _toPay.setSize(stage.stageWidth - 30, 50);
    }
}
}