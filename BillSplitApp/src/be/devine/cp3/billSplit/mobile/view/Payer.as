package be.devine.cp3.billSplit.mobile.view {
import be.devine.cp3.billSplit.mobile.view.Screen;
import be.devine.cp3.billSplit.model.AppModel;

import feathers.controls.Slider;

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

    private var _name:TextField;
    private var _percentage:TextField;
    private var _totalAmount:TextField;
    private var _icon:Image;
    private var _bg:Quad;
    private var _slider:Slider;

    public function Payer(i:uint, stageRef:Stage)
    {
        _appModel = AppModel.getInstance();

        const atlasBitmapData:BitmapData = (new ATLAS_IMAGE()).bitmapData;
        _atlas = new TextureAtlas(Texture.fromBitmapData(atlasBitmapData, false), XML(new ATLAS_XML()));

        _name = new TextField(200, 30, "", "Insignia", 24, 0xdaede2);
        _percentage = new TextField(200, 60, "", "Insignia", 60, 0xea2e49);
        _totalAmount = new TextField(200, 30, "", "Insignia", 24, 0x77c4d3);
        _slider = new Slider();

       /* if(i == 0)
        {
            trace("adding High player");
            _icon = new Image(_atlas.getTexture("IcnHigh"));
            _bg = new Quad(stageRef.width, 160, 0x42485f);
            _name.text = "The high roller";
        }
        else if(i == _appModel.payers - 1)
        {
            trace("adding Low player");
            _icon = new Image(_atlas.getTexture("IcnLow"));
            _bg = new Quad(stageRef.width, 160, 0x5a617a);
            _name.text = "Mr. Cheap";
        }
        else
        {
            trace("adding Medium player");
            _icon = new Image(_atlas.getTexture("IcnMedium"));
            _bg = new Quad(stageRef.width, 160, 0x4d546a);
            _name.text = "Co-payer " + i;
        }*/

        if(i == 0)
        {
            _icon = new Image(_atlas.getTexture("IcnHigh"));
            _bg = new Quad(stageRef.width, 160, 0x42485f);
            _name.text = "Me";
        }
        else
        {
            _icon = new Image(_atlas.getTexture("IcnMedium"));
            _bg = new Quad(stageRef.width, 160, 0x42485f);
            _name.text = "Payer " + i;
        }

        _icon.x = 23;
        _icon.y = 15;

        _name.x = _icon.x + _icon.width + 10;
        _name.y = _icon.y;
        _name.hAlign = "left";
        _name.vAlign = "top";

        _totalAmount.text = "€ " + _appModel.getPrice();
        _totalAmount.x = stageRef.width - _totalAmount.width - 20;
        _totalAmount.y = _name.y;
        _totalAmount.hAlign = "right";
        _totalAmount.vAlign = "top";

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
        _slider.addEventListener( Event.CHANGE, slider_changeHandler );

        _percentage.text = _slider.value.toString() + "%";
        _percentage.hAlign = "left";
        _percentage.vAlign = "top";

        addChild(_bg);
        addChild(_icon);
        addChild(_name);
        addChild(_percentage);
        addChild(_totalAmount);
        addChild(_slider);
    }

    private function slider_changeHandler( event:Event ):void
    {
        var slider:Slider = Slider( event.currentTarget );
        trace( "slider.value changed:", slider.value);
        _percentage.text = _slider.value.toString() + "%";
    }

    public function get totalAmount():TextField {
        return _totalAmount;
    }

    public function set totalAmount(value:TextField):void {
        _totalAmount = value;
    }
}
}
