package be.devine.cp3.billSplit.mobile.view.payers {

import be.devine.cp3.billSplit.model.AppModel;

import flash.display.BitmapData;

import starling.display.Image;
import starling.display.Quad;
import starling.display.Sprite;
import starling.display.Stage;
import starling.text.TextField;
import starling.textures.Texture;
import starling.textures.TextureAtlas;

public class BasePayer extends Sprite
{
    public var _appModel:AppModel;

    [Embed(source="/../assets/images/icons/Icons.png")]
    protected static const ATLAS_IMAGE:Class;

    [Embed(source="/../assets/images/icons/Icons.xml", mimeType="application/octet-stream")]
    protected static const ATLAS_XML:Class;

    [Embed(source="/../assets/fonts/Insignia LT Std/InsigniaLTStd.otf", embedAsCFF="false", fontFamily="Insignia")]
    public static const Insignia:Class;

    public var _atlas:TextureAtlas;
    public var _payerName:TextField;
    public var _icon:Image;
    public var _totalAmount:TextField;

    private var _splitPayer:SplitPayer;
    private var _costumPayer:CostumPayer;
    private var _bg:Quad;

    public function BasePayer(i:uint, stageRef:Stage)
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

        trace('payer ' + _appModel.destination);

        addChild(_bg);
        addChild(_icon);
        addChild(_payerName);
        addChild(_totalAmount);
    }

    public function get payerName():TextField {
        return _payerName;
    }

    public function get totalAmount():TextField {
        return _totalAmount;
    }

    public function trim(theNumber:Number, decPlaces:Number) : Number {
        if (decPlaces >= 0) {
            var temp:Number = Math.pow(10, decPlaces);
            return Math.round(theNumber * temp) / temp;
        }

        return theNumber;
    }
}
}
