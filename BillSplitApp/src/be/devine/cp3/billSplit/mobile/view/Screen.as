package be.devine.cp3.billSplit.mobile.view {
import be.devine.cp3.billSplit.model.AppModel;

import feathers.controls.Header;

import flash.display.BitmapData;

import starling.display.Sprite;
import starling.display.Stage;
import starling.events.Event;
import starling.textures.Texture;
import starling.textures.TextureAtlas;

public class Screen extends Sprite
{
    public var _appModel:AppModel;
    public var _header:Header;
    public var stageRef:Stage;

    [Embed(source="/../assets/images/icons/Icons.png")]
    protected static const ATLAS_IMAGE:Class;

    [Embed(source="/../assets/images/icons/Icons.xml", mimeType="application/octet-stream")]
    protected static const ATLAS_XML:Class;

    [Embed(source="/../assets/fonts/Blanch/BLANCH_CONDENSED.otf", embedAsCFF="false", fontFamily="Blanch")]
    public static const Blanch:Class;

    [Embed(source="/../assets/fonts/Insignia LT Std/InsigniaLTStd.otf", embedAsCFF="false", fontFamily="Insignia")]
    public static const Insignia:Class;

    public var _atlas:TextureAtlas;

    public function Screen()
    {
        _appModel = AppModel.getInstance();

        _header = new Header();
        addChild( _header );

        const atlasBitmapData:BitmapData = (new ATLAS_IMAGE()).bitmapData;
        _atlas = new TextureAtlas(Texture.fromBitmapData(atlasBitmapData, false), XML(new ATLAS_XML()));

        addEventListener(starling.events.Event.ADDED_TO_STAGE, addedHandler);
    }

    private function addedHandler(event:Event):void
    {
        stageRef = this.stage;
    }

}
}
