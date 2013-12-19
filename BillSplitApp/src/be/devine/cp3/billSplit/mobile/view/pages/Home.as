package be.devine.cp3.billSplit.mobile.view.pages {
import be.devine.cp3.billSplit.mobile.view.*;
import be.devine.cp3.billSplit.mobile.view.controls.NavButton;

import feathers.controls.NumericStepper;

import starling.display.Image;

import starling.display.Quad;
import starling.events.Event;
import starling.events.ResizeEvent;

public class Home extends Screen
{
    private var _stepper:NumericStepper;
    private var _stepperBg:Quad;
    private var _splitBg:Quad;
    private var _customBg:Quad;
    private var _historyBg:Quad;
    private var _settingsBg:Quad;

    public static const CLICKED:String = "clicked";
    private var _buttonToSplit:NavButton;
    private var _buttonToCustom:NavButton;
    private var _buttonToHistory:NavButton;
    private var _buttonToSettings:NavButton;

    public function Home()
    {
        _splitBg = new Quad(100, 100, 0x42485f);
        _customBg = new Quad(100, 100, 0x5a617a);
        _historyBg = new Quad(100, 100, 0x333745);
        _settingsBg = new Quad(100, 100, 0x393d4b);

        _stepper = new NumericStepper();
        _stepper.minimum = 0;
        _stepper.maximum = 20;
        _stepper.value = _appModel.payers;
        _stepper.step = 1;
        _stepper.textInputProperties.paddingTop = 20;

        _buttonToSplit = new NavButton('split');
        _buttonToSplit.label = 'Regular Split';
        _buttonToSplit.defaultSkin = new Quad( 100, 100, 0x42485f );
        _buttonToSplit.defaultIcon = new Image(_atlas.getTexture("IcnSplit"));
        _buttonToSplit.addEventListener( starling.events.Event.TRIGGERED, triggeredHandler );

        _buttonToCustom = new NavButton('custom');
        _buttonToCustom.label = 'Custom Input';
        _buttonToCustom.defaultIcon = new Image(_atlas.getTexture("IcnInput"));
        _buttonToCustom.defaultSkin = new Quad( 100, 100, 0x5a617a );
        _buttonToCustom.addEventListener( starling.events.Event.TRIGGERED, triggeredHandler );

        _buttonToHistory = new NavButton('history');
        _buttonToHistory.label = 'History';
        _buttonToHistory.defaultIcon = new Image(_atlas.getTexture("IcnHistory"));
        _buttonToHistory.defaultSkin = new Quad( 100, 100, 0x333745 );
        _buttonToHistory.addEventListener( starling.events.Event.TRIGGERED, triggeredHandler );

        _buttonToSettings = new NavButton('settings');
        _buttonToSettings.label = 'Settings';
        _buttonToSettings.defaultIcon = new Image(_atlas.getTexture("IcnSettings"));
        _buttonToHistory.defaultSkin = new Quad( 100, 100, 0x393d4b );
        _buttonToSettings.addEventListener( starling.events.Event.TRIGGERED, triggeredHandler );
        addEventListener(starling.events.Event.ADDED_TO_STAGE, addedHandler);
    }

    private function triggeredHandler(event:starling.events.Event):void
    {
        var button:NavButton = NavButton(event.currentTarget);

        _appModel.payers = _stepper.value;
        _appModel.destination = button.destination;

        dispatchEventWith(CLICKED, true);
    }

    private function addedHandler(event:starling.events.Event):void
    {
        removeEventListener(starling.events.Event.ADDED_TO_STAGE, addedHandler);
        stage.addEventListener(ResizeEvent.RESIZE, resizeHandler);
        addEventListener(starling.events.Event.REMOVED_FROM_STAGE, removedHandler);

        _stepperBg = new Quad(stage.stageWidth, (stage.stageHeight*17.5)/100, 0x333745);
        addChild( _stepperBg );
        addChild( _stepper );
        addChild( _buttonToSplit );
        addChild( _buttonToCustom );
        addChild( _buttonToHistory );
        addChild( _buttonToSettings );

        layout();
    }

    private function removedHandler(event:Event):void
    {
        stageRef.removeEventListener(ResizeEvent.RESIZE, resizeHandler);
    }

    private function resizeHandler(event:ResizeEvent):void
    {
        layout();
    }

    private function layout():void
    {
        _header.title = "billsplit app";
        _header.setSize(stage.stageWidth, 120);

        _stepperBg.y = _header.height;
        _stepperBg.width = stage.stageWidth;
        _stepperBg.height = _header.height + 30;

        _stepper.x = 15;
        _stepper.setSize(stage.stageWidth - 30, 120);
        _stepper.y = _header.height + (_stepperBg.height-_stepper.height)/2;

        _buttonToSplit.y = _header.height + _stepperBg.height;
        _buttonToCustom.y = _header.height + _stepperBg.height;

        _buttonToSplit.padding = 0;
        _buttonToCustom.padding = 0;
        _buttonToHistory.padding = 0;
        _buttonToSettings.padding = 0;

        if(stage.stageHeight < stage.stageWidth)
        {
            _buttonToSplit.setSize(stage.stageWidth / 4, stage.stageWidth / 4);
            _buttonToCustom.setSize(stage.stageWidth / 4, stage.stageWidth / 4);
            _buttonToHistory.setSize(stage.stageWidth / 4, stage.stageWidth / 4);
            _buttonToSettings.setSize(stage.stageWidth / 4, stage.stageWidth / 4);

            _buttonToSplit.x = 0;
            _buttonToCustom.x = stage.stageWidth / 4;
            _buttonToHistory.x = (stage.stageWidth / 4)*2;
            _buttonToSettings.x = (stage.stageWidth / 4)*3;

            _buttonToHistory.y = _header.height + _stepperBg.height;
            _buttonToSettings.y = _header.height + _stepperBg.height;

            _buttonToSplit.defaultIcon.scaleX = 0.65;
            _buttonToCustom.defaultIcon.scaleX = 0.65;
            _buttonToHistory.defaultIcon.scaleX = 0.65;
            _buttonToSettings.defaultIcon.scaleX = 0.65;
            _buttonToSplit.defaultIcon.scaleY = 0.65;
            _buttonToCustom.defaultIcon.scaleY = 0.65;
            _buttonToHistory.defaultIcon.scaleY = 0.65;
            _buttonToSettings.defaultIcon.scaleY = 0.65;

            _buttonToHistory.paddingLeft= -10;

            _buttonToSplit.labelOffsetY =  + 80;
            _buttonToCustom.labelOffsetY =  + 80;
            _buttonToHistory.labelOffsetY =  + 80;
            _buttonToSettings.labelOffsetY =  + 80;
        }
        else
        {
            _buttonToSplit.setSize(stage.stageWidth / 2, stage.stageWidth / 2);
            _buttonToCustom.setSize(stage.stageWidth / 2, stage.stageWidth / 2);
            _buttonToHistory.setSize(stage.stageWidth / 2, stage.stageWidth / 2);
            _buttonToSettings.setSize(stage.stageWidth / 2, stage.stageWidth / 2);

            _buttonToSplit.x = 0;
            _buttonToHistory.x = 0;
            _buttonToCustom.x = stage.stageWidth / 2;
            _buttonToSettings.x = stage.stageWidth / 2;

            _buttonToHistory.y = _header.height + _stepperBg.height + _buttonToSplit.height;
            _buttonToSettings.y = _header.height + _stepperBg.height + _buttonToSplit.height;

            _buttonToSplit.defaultIcon.scaleX = 0.8;
            _buttonToCustom.defaultIcon.scaleX = 0.8;
            _buttonToHistory.defaultIcon.scaleX = 0.8;
            _buttonToSettings.defaultIcon.scaleX = 0.8;
            _buttonToSplit.defaultIcon.scaleY = 0.8;
            _buttonToCustom.defaultIcon.scaleY = 0.8;
            _buttonToHistory.defaultIcon.scaleY = 0.8;
            _buttonToSettings.defaultIcon.scaleY = 0.8;

            _buttonToHistory.paddingLeft= -15;

            _buttonToSplit.labelOffsetY =  + 100;
            _buttonToCustom.labelOffsetY =  + 100;
            _buttonToHistory.labelOffsetY =  + 100;
            _buttonToSettings.labelOffsetY =  + 100;
        }

        _buttonToSplit.iconOffsetX = (_buttonToSplit.width - _buttonToSplit.defaultIcon.width) / 2;
        _buttonToCustom.iconOffsetX = (_buttonToCustom.width - _buttonToCustom.defaultIcon.width) / 2;
        _buttonToHistory.iconOffsetX = (_buttonToHistory.width - _buttonToHistory.defaultIcon.width) / 2;
        _buttonToSettings.iconOffsetX = (_buttonToSettings.width - _buttonToSettings.defaultIcon.width) / 2;

        _buttonToSplit.paddingTop = -30;
        _buttonToCustom.paddingTop = -23;
        _buttonToHistory.paddingTop = -30;
        _buttonToSettings.paddingTop = -25;

        _buttonToSplit.labelOffsetX = -(_buttonToSplit.width / 3);
        _buttonToCustom.labelOffsetX = -(_buttonToCustom.width / 3);
        _buttonToHistory.labelOffsetX = -(_buttonToHistory.width / 3);
        _buttonToSettings.labelOffsetX = -(_buttonToSettings.width / 3);
    }
}
}
