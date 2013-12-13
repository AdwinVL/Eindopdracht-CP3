package {
import be.devine.cp3.billSplit.mobile.Application;

import flash.display.Bitmap;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.geom.Rectangle;

import starling.core.Starling;
import starling.events.Event;
import starling.textures.TextureSmoothing;

[SWF(frameRate=60)]

public class Main extends Sprite
{
    private var _starling:Starling;

    [Embed(source="../assets/images/splash.jpg")]
    private var Splash:Class;

    public static  var _splashPic:Bitmap;

    public function Main()
    {
        stage.align = StageAlign.TOP_LEFT;
        stage.scaleMode = StageScaleMode.NO_SCALE;

        _starling = new Starling(Application, stage);
        _starling.start();

        _splashPic = new Splash();
        addChild(_splashPic);

        stage.addEventListener(flash.events.Event.RESIZE, resizeHandler);
    }

    private function resizeHandler(event:flash.events.Event):void
    {
        _starling.viewPort = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
        _starling.stage.stageWidth = stage.stageWidth;
        _starling.stage.stageHeight = stage.stageHeight;

        if(_splashPic != null)
        {
            _splashPic.width = stage.stageWidth;
            _splashPic.height = stage.stageHeight;
            _splashPic.smoothing = TextureSmoothing.TRILINEAR;
        }
    }
}
}