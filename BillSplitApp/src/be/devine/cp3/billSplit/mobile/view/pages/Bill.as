package be.devine.cp3.billSplit.mobile.view.pages {
import be.devine.cp3.billSplit.mobile.view.*;
import be.devine.cp3.billSplit.mobile.view.controls.NavButton;
import be.devine.cp3.billSplit.mobile.view.payers.BasePayer;

import feathers.controls.List;
import feathers.data.ListCollection;

import starling.display.DisplayObject;

import starling.events.Event;
import starling.events.ResizeEvent;

public class Bill extends Screen
{
    public static const CLICKED:String = "clicked";

    private var _btnHome:NavButton;
    private var _btnPrevious:NavButton;

    private var _arrList:Array;

    private var _list:List;
    private var _listContent:ListCollection;

    public function Bill()
    {
        _btnHome = new NavButton('home');
        _btnHome.label = 'home';
        _btnHome.addEventListener( starling.events.Event.TRIGGERED, triggeredHandler );

        _btnPrevious = new NavButton('split');
        _btnPrevious.label = 'previous';
        _btnPrevious.addEventListener( starling.events.Event.TRIGGERED, triggeredHandler );

        _header.leftItems = new <DisplayObject>[ _btnPrevious ];
        _header.rightItems = new <DisplayObject>[ _btnHome ];

        _arrList = [];

        for each(var payer:BasePayer in _appModel.arrPayers)
        {
            var payerStats:String = payer.payerName.text + ", you pay " + payer.totalAmount.text;
            _arrList.push(payerStats);
        }

        _listContent = new ListCollection(_arrList);

        _list = new List();
        _list.dataProvider = _listContent;
        _list.isSelectable = false;
        addChild( _list );

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
        _header.title = 'Da Bill';
        _header.setSize(stage.stageWidth, 120);

        _list.y = _header.height + 20;
        _list.width = stage.stageWidth;
        _list.height = stage.stageHeight - _list.y;
    }
}
}