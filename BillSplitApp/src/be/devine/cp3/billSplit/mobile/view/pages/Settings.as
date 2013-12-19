package be.devine.cp3.billSplit.mobile.view.pages {
import be.devine.cp3.billSplit.mobile.view.*;
import be.devine.cp3.billSplit.mobile.view.controls.NavButton;

import feathers.controls.Label;
import feathers.controls.NumericStepper;

import starling.display.DisplayObject;

import starling.events.Event;
import starling.events.ResizeEvent;

public class Settings extends Screen
{
    public static const CLICKED:String = "clicked";

    private var _btnHome:NavButton;

    private var _lblMaxPayers:Label;
    private var _maxPayers:NumericStepper;

    private var _lblMaxPriceChar:Label;
    private var _maxPriceChar:NumericStepper;

    public function Settings()
    {
        _btnHome = new NavButton('home');
        _btnHome.label = 'home';
        _btnHome.addEventListener( starling.events.Event.TRIGGERED, triggeredHandler );

        _header.leftItems = new <DisplayObject>[ _btnHome ];

        _lblMaxPayers = new Label();
        _lblMaxPayers.text = 'Maximum payers?';
        addChild(_lblMaxPayers);

        _maxPayers = new NumericStepper();
        _maxPayers.minimum = 2;
        _maxPayers.maximum = 25;
        _maxPayers.value = _appModel.maxPayers;
        _maxPayers.step = 1;
        addChild(_maxPayers);

        _lblMaxPriceChar = new Label();
        _lblMaxPriceChar.text = 'Maximum digits in price?';
        addChild(_lblMaxPriceChar);

        _maxPriceChar = new NumericStepper();
        _maxPriceChar.minimum = 1;
        _maxPriceChar.maximum = 5;
        _maxPriceChar.value = _appModel.maxPriceChar;
        _maxPriceChar.step = 1;
        addChild(_maxPriceChar);

        addEventListener(starling.events.Event.ADDED_TO_STAGE, addedHandler);
    }

    private function addedHandler(event:starling.events.Event):void
    {
        removeEventListener(Event.ADDED_TO_STAGE, addedHandler);
        stage.addEventListener(Event.RESIZE, resizeHandler);
        addEventListener(Event.REMOVED_FROM_STAGE, removedHandler);

        layout();
    }

    private function removedHandler(event:starling.events.Event):void {
        stageRef.removeEventListener(ResizeEvent.RESIZE, resizeHandler);

        layout();
    }

    private function triggeredHandler(event:starling.events.Event):void
    {
        var button:NavButton = NavButton(event.currentTarget);
        _appModel.destination = button.destination;

        _appModel.maxPayers = _maxPayers.value;
        _appModel.maxPriceChar = _maxPriceChar.value;

        dispatchEventWith(CLICKED, true);
    }

    private function resizeHandler(event:starling.events.Event):void
    {
        layout();
    }

    private function layout():void
    {
        _header.title = 'Settings';
        _header.setSize(stage.stageWidth, 120);

        _lblMaxPayers.x = 15;
        _lblMaxPayers.y = _header.height + 20;
        _lblMaxPayers.setSize(stage.stageWidth - 30, 30);

        _maxPayers.x = 15;
        _maxPayers.y = _header.height + _lblMaxPayers.height + 40;
        _maxPayers.setSize(stage.stageWidth - 30, 100);

        _lblMaxPriceChar.x = 15;
        _lblMaxPriceChar.y = _maxPayers.y + _maxPayers.height + 20;
        _lblMaxPriceChar.setSize(stage.stageWidth - 30, 30);

        _maxPriceChar.x = 15;
        _maxPriceChar.y = _lblMaxPriceChar.y + _lblMaxPriceChar.height + 30;
        _maxPriceChar.setSize(stage.stageWidth - 30, 100);
    }
}
}