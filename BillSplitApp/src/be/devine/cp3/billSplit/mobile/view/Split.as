package be.devine.cp3.billSplit.mobile.view {
import be.devine.cp3.billSplit.mobile.view.controls.navButton;

import feathers.controls.NumericStepper;

import starling.events.Event;

public class Split extends Screen
{
    private var _buttonToHome:navButton;
    private var _stepper:NumericStepper;
    public static const CLICKED:String = "clicked";


    public function Split()
    {
        _stepper = new NumericStepper();
        _stepper.minimum = 0;
        _stepper.maximum = 100;
        _stepper.value = 20;
        _stepper.step = 1;
        addChild( _stepper );

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

        layout();

        _buttonToHome = new navButton('home');
        _buttonToHome.label = 'home';
        _buttonToHome.addEventListener( starling.events.Event.TRIGGERED, triggeredHandler );
        addChild( _buttonToHome );
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
        _stepper.x = 10;
        _stepper.y = 100;
        _stepper.setSize(stage.stageWidth - 20, 50);
    }
}
}
