package be.devine.cp3.billSplit.mobile.view.payers {
import be.devine.cp3.billSplit.mobile.view.controls.PriceTag;
import be.devine.cp3.billSplit.model.AppModel;

import feathers.controls.Button;

import feathers.controls.Slider;
import feathers.events.FeathersEventType;

import flash.display.BitmapData;

import starling.display.Image;
import starling.display.Quad;
import starling.display.Sprite;
import starling.display.Stage;
import starling.events.Event;
import starling.text.TextField;
import starling.textures.Texture;
import starling.textures.TextureAtlas;

public class Payer extends Sprite
{
    private var _appModel:AppModel;

    [Embed(source="/../assets/images/icons/Icons.png")]
    protected static const ATLAS_IMAGE:Class;

    [Embed(source="/../assets/images/icons/Icons.xml", mimeType="application/octet-stream")]
    protected static const ATLAS_XML:Class;

    [Embed(source="/../assets/fonts/Insignia LT Std/InsigniaLTStd.otf", embedAsCFF="false", fontFamily="Insignia")]
    public static const Insignia:Class;

    public var _atlas:TextureAtlas;

    private var _payerName:TextField;
    private var _percentage:TextField;
    private var _totalAmount:TextField;
    private var _icon:Image;
    private var _bg:Quad;
    private var _slider:Slider;
    private var _addBtn:Button;
    private var _arrPriceTags:Array = [];
    private var _priceTag:PriceTag;

    private var _sliderChanged:Boolean = false;

    public function Payer(i:uint, stageRef:Stage)
    {
        _appModel = AppModel.getInstance();

        const atlasBitmapData:BitmapData = (new ATLAS_IMAGE()).bitmapData;
        _atlas = new TextureAtlas(Texture.fromBitmapData(atlasBitmapData, false), XML(new ATLAS_XML()));

        _payerName = new TextField(200, 30, "", "Insignia", 24, 0xdaede2);
        _totalAmount = new TextField(200, 30, "", "Insignia", 24, 0x77c4d3);

        if(i == 0)
        {
            _icon = new Image(_atlas.getTexture("IcnHigh"));
            _bg = new Quad(stageRef.width, 160, 0x42485f);
            _payerName.text = "App owner";
        }
        else
        {
            _icon = new Image(_atlas.getTexture("IcnMedium"));
            _bg = new Quad(stageRef.width, 160, 0x42485f);
            _payerName.text = "Payer " + (i + 1);
        }

        _icon.x = 23;
        _icon.y = 15;

        _payerName.x = _icon.x + _icon.width + 10;
        _payerName.y = _icon.y;
        _payerName.hAlign = "left";
        _payerName.vAlign = "top";

        _totalAmount.x = stageRef.width - _totalAmount.width - 20;
        _totalAmount.y = _payerName.y;
        _totalAmount.hAlign = "right";
        _totalAmount.vAlign = "top";

        // SPLIT
        if(_appModel.currentPage == "split")
        {
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
            _slider.step = 1;
            _slider.page = 10;
            _slider.addEventListener( Event.CHANGE, slider_liveChangeHandler );
            _slider.addEventListener( feathers.events.FeathersEventType.END_INTERACTION, slider_changeHandler );

            _percentage.text = _slider.value.toString() + "%";
            _percentage.hAlign = "left";
            _percentage.vAlign = "top";

            addChild(_percentage);
            addChild(_slider);
        }
        // COSTUM
        else if(_appModel.currentPage == "custom"){
            _addBtn = new Button();

            _addBtn.x = _icon.x + _icon.width + 15;
            _addBtn.y = _payerName.y + _payerName.fontSize + 15;
            _addBtn.label = '+';
            _addBtn.addEventListener( starling.events.Event.TRIGGERED, triggeredHandler );

            addChild(_addBtn);
        }
        addChild(_bg);
        addChild(_icon);
        addChild(_payerName);
        addChild(_totalAmount);

    }
    // COSTUM
    private function triggeredHandler(event:Event):void
    {
        trace("add clicked");
        _priceTag = new PriceTag(20);
        _arrPriceTags.push(_priceTag);

        priceTagLayout();
    }
    // COSTUM
    private function priceTagLayout():void {

        var columns:uint = 4;

        var xPos:uint;
        var yPos:uint;

        xPos = _addBtn.x + _addBtn.width + 15;
        yPos = _addBtn.y;

        for(var i:uint = 0; i<_arrPriceTags.length; i++){

            _arrPriceTags[i].x = xPos;
            _arrPriceTags[i].y = yPos;
            addChild(_arrPriceTags[i]);

            xPos += (_arrPriceTags[i].width + 10);

            if((i+1) % columns == 0) // veelvoud van aantal columns
            {
                yPos += (_arrPriceTags[i - 1].height + 5);
                xPos = _addBtn.x + _addBtn.width + 15;
            }
        }
    }
    // SPLIT
    private function slider_liveChangeHandler( event:Event ):void
    {
        _percentage.text = _slider.value.toString() + "%";
    }
    // SPLIT
    private function slider_changeHandler( event:Event ):void
    {
        _sliderChanged = true;
        _appModel.updateSliders(_payerName.text, _slider.value);
    }

    public function get totalAmount():TextField {
        return _totalAmount;
    }

    public function set totalAmount(value:TextField):void {
        _totalAmount = value;
    }

    public function get payerName():TextField
    {
        return _payerName;
    }

    public function get slider():Slider
    {
        return _slider;
    }

    public function set slider(value:Slider):void
    {
        _slider = value;
    }
    // SPLIT
    public function get percentage():TextField
    {
        return _percentage;
    }
    // SPLIT
    public function set percentage(value:TextField):void
    {
        _percentage = value;
    }
    // SPLIT
    public function get sliderChanged():Boolean
    {
        return _sliderChanged;
    }
    // SPLIT
    public function set sliderChanged(value:Boolean):void
    {
        _sliderChanged = value;
    }
}
}
