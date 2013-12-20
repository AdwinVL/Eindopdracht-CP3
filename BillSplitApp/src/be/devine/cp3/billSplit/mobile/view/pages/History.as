package be.devine.cp3.billSplit.mobile.view.pages {
import be.devine.cp3.billSplit.mobile.view.*;

import be.devine.cp3.billSplit.mobile.view.controls.NavButton;
import be.devine.cp3.billSplit.model.AppModel;

import feathers.controls.List;

import feathers.data.ListCollection;

import flash.events.Event;

import starling.display.DisplayObject;

import starling.events.Event;
import starling.events.ResizeEvent;

public class History extends Screen
{
    public static const CLICKED:String = "clicked";

    private var _btnHome:NavButton;

    private var _listContent:ListCollection;
    private var _list:List;

    public function History()
    {
        _appModel.load();
        _appModel.addEventListener(AppModel.PAYERS_LOADED, payersLoadedHandler);

        _btnHome = new NavButton('home');
        _btnHome.label = 'home';
        _btnHome.addEventListener( starling.events.Event.TRIGGERED, triggeredHandler );

        _header.leftItems = new <DisplayObject>[ _btnHome ];

        _list = new List();

        addEventListener(starling.events.Event.ADDED_TO_STAGE, addedHandler);
    }

    private function addedHandler(event:starling.events.Event):void
    {
        removeEventListener(starling.events.Event.ADDED_TO_STAGE, addedHandler);
        stage.addEventListener(starling.events.Event.RESIZE, resizeHandler);
        addEventListener(starling.events.Event.REMOVED_FROM_STAGE, removedHandler);

        layout();
    }

    private function removedHandler(event:starling.events.Event):void {
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
        _header.title = 'History';
        _header.setSize(stage.stageWidth, 120);

        _list.y = _header.height + 20;
        _list.width = stage.stageWidth;
        _list.height = stage.stageHeight - _list.y;
    }

    private function payersLoadedHandler(event:flash.events.Event):void
    {
        _listContent = new ListCollection(_appModel.arrBills.name);

        _list.dataProvider = _listContent;
        addChild( _list );
    }
}
}
