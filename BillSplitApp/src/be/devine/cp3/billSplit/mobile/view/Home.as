package be.devine.cp3.billSplit.mobile.view {
import be.devine.cp3.billSplit.mobile.view.controls.navButton;
import be.devine.cp3.billSplit.model.AppModel;

import feathers.controls.NumericStepper;
import feathers.controls.text.StageTextTextEditor;
import feathers.core.ITextEditor;

import flash.text.AutoCapitalize;

import starling.display.Quad;
import starling.display.Sprite;
import starling.events.Event;
import starling.events.ResizeEvent;

public class Home extends Screen
{

    private var _stepper:NumericStepper;
    private var _stepperBg:Quad;

    public static const CLICKED:String = "clicked";
    private var _buttonToSplit:navButton;
    private var _buttonToCostum:navButton;
    private var _buttonToHistory:navButton;
    private var _buttonToSettings:navButton;

    public function Home()
    {
        _stepper = new NumericStepper();
        _stepper.minimum = 0;
        _stepper.maximum = 20;
        _stepper.value = 3;
        _stepper.step = 1;
        _stepper.textInputProperties.fontFamily = "Helvetica";
        _stepper.textInputProperties._fontSize = 90;
        _stepper.textInputProperties.paddingTop = 35;
        _stepper.textInputProperties.title = _stepper.value.toString() + " People";

        _buttonToSplit = new navButton('split');
        _buttonToSplit.label = 'Regular Split';
        _buttonToSplit.addEventListener( starling.events.Event.TRIGGERED, triggeredHandler );

        _buttonToCostum = new navButton('costum');
        _buttonToCostum.label = 'Costum Input';
        _buttonToCostum.addEventListener( starling.events.Event.TRIGGERED, triggeredHandler );

        _buttonToHistory = new navButton('history');
        _buttonToHistory.label = 'History';
        _buttonToHistory.addEventListener( starling.events.Event.TRIGGERED, triggeredHandler );

        _buttonToSettings = new navButton('settings');
        _buttonToSettings.label = 'Settings';
        _buttonToSettings.addEventListener( starling.events.Event.TRIGGERED, triggeredHandler );

        addEventListener(starling.events.Event.ADDED_TO_STAGE, addedHandler);
    }

    private function triggeredHandler(event:starling.events.Event):void
    {
        var button:navButton = navButton(event.currentTarget);
        _appModel.destination = button.destination;
        dispatchEventWith(CLICKED, true);
    }

    private function addedHandler(event:starling.events.Event):void
    {
        _stepperBg = new Quad(stage.stageWidth, (stage.stageHeight*17.5)/100, 0x333745);
        addChild( _stepperBg );
        addChild( _stepper );
        addChild( _buttonToSplit );
        addChild( _buttonToCostum );
        addChild( _buttonToHistory );
        addChild( _buttonToSettings );

        removeEventListener(starling.events.Event.ADDED_TO_STAGE, addedHandler);
        stage.addEventListener(ResizeEvent.RESIZE, resizeHandler);

        layout();
    }

    public static function headerTextEditorFactory():ITextEditor
    {
        var textEditor:StageTextTextEditor = new StageTextTextEditor();

        textEditor.autoCapitalize = AutoCapitalize.NONE;
        textEditor.autoCorrect = false;
        textEditor.color = 0x000000;
        textEditor.displayAsPassword = false;
        textEditor.fontFamily = "Insignia";
        textEditor.fontSize = 24;

        return textEditor;
    }

    private function resizeHandler(event:ResizeEvent):void
    {
        layout();
    }

    private function layout():void
    {
        _header.title = "billsplit app";
        _header.setSize(stage.stageWidth, 70);

        var _headerHeight:Number = 70;

        _stepperBg.y = _headerHeight;
        _stepperBg.width = stage.stageWidth;

        _stepper.setSize(stage.stageWidth, 90);
        _stepper.y = _headerHeight + (_stepperBg.height-_stepper.height)/2;

        _buttonToSplit.y = _headerHeight + _stepperBg.height;
        _buttonToCostum.y = _headerHeight + _stepperBg.height;

        if(stage.stageHeight < stage.stageWidth)
        {
            _buttonToSplit.setSize(stage.stageWidth / 4, stage.stageWidth / 4);
            _buttonToCostum.setSize(stage.stageWidth / 4, stage.stageWidth / 4);
            _buttonToHistory.setSize(stage.stageWidth / 4, stage.stageWidth / 4);
            _buttonToSettings.setSize(stage.stageWidth / 4, stage.stageWidth / 4);

            _buttonToSplit.x = 0;
            _buttonToCostum.x = stage.stageWidth / 4;
            _buttonToHistory.x = (stage.stageWidth / 4)*2;
            _buttonToSettings.x = (stage.stageWidth / 4)*3;

            _buttonToHistory.y = _headerHeight + _stepperBg.height;
            _buttonToSettings.y = _headerHeight + _stepperBg.height;
        }
        else
        {
            _buttonToSplit.setSize(stage.stageWidth / 2, stage.stageWidth / 2);
            _buttonToCostum.setSize(stage.stageWidth / 2, stage.stageWidth / 2);
            _buttonToHistory.setSize(stage.stageWidth / 2, stage.stageWidth / 2);
            _buttonToSettings.setSize(stage.stageWidth / 2, stage.stageWidth / 2);

            _buttonToSplit.x = 0;
            _buttonToHistory.x = 0;
            _buttonToCostum.x = stage.stageWidth / 2;
            _buttonToSettings.x = stage.stageWidth / 2;

            _buttonToHistory.y = _headerHeight + _stepperBg.height + _buttonToSplit.height;
            _buttonToSettings.y = _headerHeight + _stepperBg.height + _buttonToSplit.height;
        }
    }
}
}
