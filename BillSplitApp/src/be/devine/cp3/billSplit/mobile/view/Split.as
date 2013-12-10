/**
 * Created with IntelliJ IDEA.
 * User: JoonVT
 * Date: 05/12/13
 * Time: 15:33
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.billSplit.mobile.view {
import be.devine.cp3.billSplit.mobile.view.controls.navButton;
import be.devine.cp3.billSplit.model.AppModel;

import feathers.controls.Header;
import feathers.controls.NumericStepper;

import starling.display.Sprite;
import starling.events.Event;

public class Split extends Sprite
{
    private var _appModel:AppModel;
    private var _buttonToHome:navButton;
    private var _header:Header;
    private var _stepper:NumericStepper;
    public static const CLICKED:String = "clicked";

    public function Split()
    {
        _appModel = AppModel.getInstance();

        _header = new Header();
        _header.title = "Splitt da Bill";
        addChild( _header );

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

        addEventListener(starling.events.Event.ADDED_TO_STAGE, addedHandler);
    }

    private function addedHandler(event:starling.events.Event):void
    {
        removeEventListener(starling.events.Event.ADDED_TO_STAGE, addedHandler);

        stage.addEventListener(starling.events.Event.RESIZE, resizeHandler);

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
        _header.setSize(stage.stageWidth, 50);

        _stepper.x = 10;
        _stepper.y = 100;
        _stepper.setSize(stage.stageWidth - 20, 50);
    }
}
}
