package be.devine.cp3.billSplit.mobile.view {
import be.devine.cp3.billSplit.mobile.view.controls.navButton;
import be.devine.cp3.billSplit.model.AppModel;

import feathers.controls.Button;

import feathers.controls.Header;
import feathers.controls.NumericStepper;

import starling.display.Sprite;
import starling.events.Event;
import starling.events.ResizeEvent;

public class Home extends Sprite
{
    private var _appModel:AppModel;

    private var _header:Header;
    private var _stepper:NumericStepper;

    public static const CLICKED:String = "clicked";
    private var _buttonToSplit:navButton;

    public function Home()
    {
        _appModel = AppModel.getInstance();

        _header = new Header();
        _header.title = "Da Bill";
        addChild( _header );

        _stepper = new NumericStepper();
        _stepper.minimum = 0;
        _stepper.maximum = 100;
        _stepper.value = 50;
        _stepper.step = 1;
        addChild( _stepper );

        _buttonToSplit = new navButton('split');
        _buttonToSplit.label = 'next boyyy';
        _buttonToSplit.addEventListener( starling.events.Event.TRIGGERED, triggeredHandler );
        addChild( _buttonToSplit );

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
        removeEventListener(starling.events.Event.ADDED_TO_STAGE, addedHandler);

        stage.addEventListener(ResizeEvent.RESIZE, resizeHandler);

        layout();
    }

    private function resizeHandler(event:ResizeEvent):void
    {
        layout();
    }

    private function layout():void
    {
        _header.setSize(stage.stageWidth, 50);

        _stepper.x = 10;
        _stepper.y = 100;
        _stepper.setSize(stage.stageWidth - 20, 50);

        _buttonToSplit.x = 10;
        _buttonToSplit.y = stage.stageHeight - 60;
        _buttonToSplit.setSize(stage.stageWidth - 20, 50);
    }
}
}
