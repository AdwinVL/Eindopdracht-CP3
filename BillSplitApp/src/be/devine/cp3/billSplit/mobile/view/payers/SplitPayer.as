package be.devine.cp3.billSplit.mobile.view.payers {
import be.devine.cp3.billSplit.model.AppModel;

import feathers.controls.Slider;
import feathers.events.FeathersEventType;

import flash.events.Event;

import starling.display.Stage;
import starling.events.Event;
import starling.text.TextField;

public class SplitPayer extends BasePayer {

    private var _slider:Slider;
    private var _percentage:TextField;
    private var _sliderChanged:Boolean = false;

    public function SplitPayer(i:uint, stageRef:Stage) {

        super(i, stageRef);

        _appModel.addEventListener(AppModel.PRICE_CHANGED, priceChangedHandler);

        _percentage = new TextField(200, 60, "", "Insignia", 60, 0xea2e49);
        _slider = new Slider();

        _percentage.x = _icon.x + _icon.width +10;
        _percentage.y = _icon.y + _icon.height - _percentage.fontSize;

        _slider.minimum = 0;
        _slider.maximum = 100;
        _slider.width = stageRef.width - _percentage.x  - 140;
        _slider.height = 80;
        _slider.x = _percentage.x + 100 + 20;
        _slider.y = _percentage.y;
        _slider.value = (Math.floor(100/_appModel.payers));
        _slider.step = .01;
        _slider.page = 10;
        _slider.addEventListener( flash.events.Event.CHANGE, slider_liveChangeHandler );
        _slider.addEventListener( feathers.events.FeathersEventType.END_INTERACTION, slider_changeHandler );

        _percentage.text = _slider.value.toString() + "%";
        _percentage.hAlign = "left";
        _percentage.vAlign = "top";

        priceChangedHandler();

        addChild(_percentage);
        addChild(_slider);
    }
    private function slider_liveChangeHandler( event:starling.events.Event ):void
    {
        _percentage.text = Math.round(_slider.value).toString() + "%";
        var price:Number = ((_slider.value / 100) * _appModel.price);
        totalAmount.text = '€ ' + trim(price, 2);
    }

    private function priceChangedHandler(event:flash.events.Event = null ):void
    {
        var price:Number = ((_slider.value / 100) * _appModel.price);
        totalAmount.text = '€ ' + trim(price, 2);
    }

    private function slider_changeHandler( event:starling.events.Event ):void
    {
        _sliderChanged = true;
    }

    private function priceChangedHandler(event:flash.events.Event):void
    {
        _totalAmount.text = String(Math.round(_appModel.price / _appModel.payers));
    }
}
}
