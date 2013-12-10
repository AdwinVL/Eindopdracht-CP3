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

        _splashPic = new Splash();
        _splashPic.width = 480;
        _splashPic.height = 800;
        addChild(_splashPic);


        _starling = new Starling(Application, stage);
        _starling.start();

        stage.addEventListener(flash.events.Event.RESIZE, resizeHandler);
    }

    private function resizeHandler(event:flash.events.Event):void
    {
        _starling.viewPort = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
        _starling.stage.stageWidth = stage.stageWidth;
        _starling.stage.stageHeight = stage.stageHeight;

        //_starling.stage.dispatchEvent(new starling.events.Event(starling.events.Event.RESIZE));
    }
}
}