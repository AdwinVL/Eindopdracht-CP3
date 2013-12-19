package be.devine.cp3.billSplit.mobile.view.pages {
import be.devine.cp3.billSplit.mobile.view.*;
import be.devine.cp3.billSplit.mobile.view.controls.NavButton;
import be.devine.cp3.billSplit.mobile.view.payers.Payer;

import feathers.controls.Label;
import feathers.controls.ScrollContainer;
import feathers.controls.TextInput;
import feathers.events.FeathersEventType;

import flash.text.SoftKeyboardType;

import starling.display.DisplayObject;

import starling.events.Event;
import starling.events.ResizeEvent;

public class Split extends Screen
{
    public static const CLICKED:String = "clicked";

    private var _btnHome:NavButton;
    private var _btnNext:NavButton;

    private var _lblToPay:Label;
    private var _toPay:TextInput;

    private var _payerContainer:ScrollContainer;

    public function Split()
    {
        _btnHome = new NavButton('home');
        _btnHome.label = 'home';
        _btnHome.addEventListener( starling.events.Event.TRIGGERED, triggeredHandler );

        _btnNext = new NavButton('bill');
        _btnNext.label = 'next';
        _btnNext.addEventListener( starling.events.Event.TRIGGERED, triggeredHandler );

        _header.leftItems = new <DisplayObject>[ _btnHome ];
        _header.rightItems = new <DisplayObject>[ _btnNext ];

        _lblToPay = new Label();
        _lblToPay.text = 'How much to pay?';
        addChild(_lblToPay);

        _toPay = new TextInput();
        _toPay.text = String(_appModel.price);
        _toPay.maxChars = 4;
        _toPay.restrict = '0-9';
        _toPay.textEditorProperties.textAlign = "center";
        _toPay.textEditorProperties.softKeyboardType = SoftKeyboardType.NUMBER;
        _toPay.addEventListener( FeathersEventType.FOCUS_IN, input_focusInHandler );
        _toPay.addEventListener( FeathersEventType.FOCUS_OUT, input_focusOutHandler );
        addChild(_toPay);

        _payerContainer = new ScrollContainer();

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
        _toPay.y = _header.height + _lblToPay.height + 40;
        _toPay.setSize(stage.stageWidth - 30, 50);
        _toPay.text = _appModel.price.toString();

        addPayers();
    }

    private function addPayers():void
    {
        var yPos:uint = 0;

        for(var i:uint = 0; i < _appModel.payers; i++)
        {
            var payer:Payer = new Payer(i, stageRef);
            payer.y = yPos;
            _payerContainer.addChild(payer);

            yPos += payer.height;

            _appModel.arrPayers.push(payer);
        }

        _payerContainer.y = _toPay.y + _toPay.height + 10;
        _payerContainer.height = stage.stageHeight - _payerContainer.y;
        addChild(_payerContainer);
    }

    private function input_focusInHandler(event:starling.events.Event):void
    {
        _toPay.text = '';
    }

    private function input_focusOutHandler(event:starling.events.Event):void
    {
        if(_toPay.text == '')
        {
            _toPay.text = '0';
        }
        else
        {
            _appModel.price = uint(_toPay.text);
        }
    }
}
}