package be.devine.cp3.billSplit.mobile {
import be.devine.cp3.billSplit.mobile.view.Home;
import be.devine.cp3.billSplit.mobile.view.Split;
import be.devine.cp3.billSplit.model.AppModel;

import feathers.controls.ScreenNavigator;
import feathers.controls.ScreenNavigatorItem;
import feathers.motion.transitions.ScreenSlidingStackTransitionManager;

import feathers.themes.MetalWorksMobileTheme;

import starling.animation.Transitions;
import starling.core.Starling;

import starling.display.Sprite;
import starling.events.Event;
import starling.events.ResizeEvent;

public class Application extends Sprite
{
    private var _appModel:AppModel;

    private var _navigator:ScreenNavigator;

    private static const HOME:String = "home";
    private static const SPLIT:String = "split";
    private var _transitionManager:ScreenSlidingStackTransitionManager;

    public function Application()
    {
        new MetalWorksMobileTheme();

        _appModel = AppModel.getInstance();

        _navigator = new ScreenNavigator();
        _navigator.autoSizeMode = ScreenNavigator.AUTO_SIZE_MODE_CONTENT;
        _navigator.addScreen( HOME, new ScreenNavigatorItem( Home ) );
        _navigator.addScreen( SPLIT, new ScreenNavigatorItem( Split ) );
        addChild( _navigator );

        _transitionManager = new ScreenSlidingStackTransitionManager( _navigator );
        _transitionManager.duration = 1;
        _transitionManager.ease = Transitions.EASE_OUT;

        _navigator.showScreen( HOME );

        addEventListener(Event.ADDED_TO_STAGE, addedHandler);

    }

    private function addedHandler(event:Event):void
    {
        removeEventListener(Event.ADDED_TO_STAGE, addedHandler);
        addEventListener(Home.CLICKED, triggeredHandler);

        stage.addEventListener(ResizeEvent.RESIZE, resizeHandler);

        layout();
    }

    private function resizeHandler(event:ResizeEvent):void
    {
        var eventHeight:uint = event.height;
        var eventWidth:uint = event.width;
        var stageHoogte:uint = stage.stageHeight;
        var stageBreedte:uint = stage.stageWidth;

        trace("--- Resize ---");

        stage.stageWidth = event.width;
        stage.stageHeight = event.height;
        trace("[APPLICATION] starling.viewPort.width: " + Starling.current.viewPort.width);
        trace("[APPLICATION] starling.viewPort.height: " + Starling.current.viewPort.height);
        trace("[APPLICATION] stage.stageWidth: " + stageBreedte + " -->> " + event.width);
        trace("[APPLICATION] stage.stageHeight: " + stageHoogte + " -->> " + event.height);
    }

    private function layout():void
    {

    }

    private function triggeredHandler(event:starling.events.Event):void
    {
        trace("--- Screen Slide ---");
        _navigator.showScreen( SPLIT );
    }
}
}
