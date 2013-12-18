package be.devine.cp3.billSplit.mobile.view {
import be.devine.cp3.billSplit.mobile.view.controls.navButton;

import feathers.controls.Label;
import feathers.controls.Slider;
import feathers.controls.TextInput;

import starling.display.DisplayObject;
import starling.display.Image;
import starling.display.Quad;
import starling.display.Sprite;

import starling.events.Event;
import starling.events.ResizeEvent;
import starling.text.TextField;

public class Split extends Screen
{
    public static const CLICKED:String = "clicked";

    private var _btnHome:navButton;
    private var _btnNext:navButton;

    private var _lblToPay:Label;
    private var _toPay:TextInput;

    private var _payerContainer:Sprite;
    private var _iconArr:Array;

    public function Split()
    {
        _btnHome = new navButton('home');
        _btnHome.label = 'home';
        _btnHome.addEventListener( starling.events.Event.TRIGGERED, triggeredHandler );

        _btnNext = new navButton('custom');
        _btnNext.label = 'next';
        _btnNext.addEventListener( starling.events.Event.TRIGGERED, triggeredHandler );

        _header.leftItems = new <DisplayObject>[ _btnHome ];
        _header.rightItems = new <DisplayObject>[ _btnNext ];

        _lblToPay = new Label();
        _lblToPay.text = 'How much to pay?';
        addChild(_lblToPay);

        _toPay = new TextInput();
        _toPay.maxChars = 4;
        _toPay.restrict = "0-9";
        addChild(_toPay);

        _payerContainer = new Sprite();
        _iconArr = [];

        addEventListener(starling.events.Event.ADDED_TO_STAGE, addedHandler);
    }

    private function addedHandler(event:starling.events.Event):void
    {
        removeEventListener(starling.events.Event.ADDED_TO_STAGE, addedHandler);
        stage.addEventListener(starling.events.Event.RESIZE, resizeHandler);
        addEventListener(starling.events.Event.REMOVED_FROM_STAGE, removedHandler);

        layout();
    }

    private function removedHandler(event:Event):void {
        stageRef.removeEventListener(ResizeEvent.RESIZE, resizeHandler);

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
        _header.title = String(_appModel.payers) + '-way split';
        _header.setSize(stage.stageWidth, 120);

        _lblToPay.x = 15;
        _lblToPay.y = _header.height + 20;
        _lblToPay.setSize(stage.stageWidth - 30, 30);

        _toPay.x = 15;
        _toPay.y = _header.height + _lblToPay.height + 20;
        _toPay.setSize(stage.stageWidth - 30, 50);

        addPayers();
    }

    private function addPayers():void
    {
        trace('People to Add: '+ _appModel.payers);
        for(var i:uint = 0; i<_appModel.payers; i++){
            trace("adding payer " + (i+1));

            var pHeight:uint = 160;
            var payer:Sprite = new Sprite();
            payer.y = (pHeight) * i;
            _payerContainer.addChild(payer);

            var name:TextField = new TextField(200, 30, "", "Insignia", 24, 0xdaede2);
            var percentage:TextField = new TextField(200, 60, "", "Insignia", 60, 0xea2e49);
            var totalAmount:TextField = new TextField(200, 30, "", "Insignia", 24, 0x77c4d3);
            var icon:Image;
            var bg:Quad;
            var slider:Slider = new Slider();

            if(_iconArr[i]!=null){
                removeChild(icon);
                removeChild(bg);
            }
            if(i == 0){
                trace("adding High player");
                icon = new Image(_atlas.getTexture("IcnHigh"));
                bg = new Quad(stage.width, pHeight, 0x42485f);
                name.text = "The high roller";
            }
            else if(i == _appModel.payers - 1){
                trace("adding Low player");
                icon = new Image(_atlas.getTexture("IcnLow"));
                bg = new Quad(stage.width, pHeight, 0x5a617a);
                name.text = "Mr. Cheap";
            }
            else{
                trace("adding Medium player");
                icon = new Image(_atlas.getTexture("IcnMedium"));
                bg = new Quad(stage.width, pHeight, 0x4d546a);
                name.text = "Co-payer " + i;
            }
            icon.x = 23;
            icon.y = 15;

            name.x = icon.x + icon.width + 10;
            name.y = icon.y;
            name.hAlign = "left";
            name.vAlign = "top";

            totalAmount.text = "€24";
            totalAmount.x = stage.width - totalAmount.width - 20;
            totalAmount.y = name.y;
            totalAmount.hAlign = "right";
            totalAmount.vAlign = "top";

            slider.minimum = 0;
            slider.maximum = 100;
            slider.width = stageRef.width- percentage.x  - 100 - 30;
            slider.height = 80;
            slider.x = percentage.x + 100 + 10;
            slider.y = percentage.y;
            slider.value = (Math.floor(100/_appModel.payers));
            slider.step = 1;
            slider.page = 10;
            slider.addEventListener( Event.CHANGE, slider_changeHandler );

            percentage.text = slider.value.toString() + "%";
            percentage.x = icon.x + icon.width +10;
            percentage.y = icon.y + icon.height - percentage.fontSize;
            percentage.hAlign = "left";
            percentage.vAlign = "top";

            payer.addChild(bg);
            payer.addChild(icon);
            payer.addChild(name);
            payer.addChild(percentage);
            payer.addChild(totalAmount);
            payer.addChild(slider);

            _iconArr.push(icon);
        }

        _payerContainer.y = _toPay.y + _toPay.height + 10;
        addChild(_payerContainer);
    }
    private function slider_changeHandler( event:Event ):void
    {
        var slider:Slider = Slider( event.currentTarget );
        trace( "slider.value changed:", slider.value);
    }
}
}