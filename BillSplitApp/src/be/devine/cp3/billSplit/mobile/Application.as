package be.devine.cp3.billSplit.mobile {
import be.devine.cp3.billSplit.mobile.view.Custom;
import be.devine.cp3.billSplit.mobile.view.History;
import be.devine.cp3.billSplit.mobile.view.Home;
import be.devine.cp3.billSplit.mobile.view.Settings;
import be.devine.cp3.billSplit.mobile.view.Split;
import be.devine.cp3.billSplit.mobile.view.controls.navButton;
import be.devine.cp3.billSplit.model.AppModel;

import feathers.controls.Button;

import feathers.controls.ScreenNavigator;
import feathers.controls.ScreenNavigatorItem;
import feathers.motion.transitions.ScreenSlidingStackTransitionManager;
import feathers.themes.MinimalMobileTheme;

import starling.animation.Transitions;
import starling.animation.Tween;
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
    private static const CUSTOM:String = "custom";
    private static const HISTORY:String = "history";
    private static const SETTINGS:String = "settings";

    private var _theme:MinimalMobileTheme;
    private var _transitionManager:ScreenSlidingStackTransitionManager;
    private var _tween:Tween;

    public function Application()
    {
        _theme = new MinimalMobileTheme();
        _theme.setInitializerForClass(navButton, _theme.getInitializerForClass(Button));

        _appModel = AppModel.getInstance();

        _navigator = new ScreenNavigator();
        _navigator.autoSizeMode = ScreenNavigator.AUTO_SIZE_MODE_CONTENT;
        _navigator.addScreen( HOME, new ScreenNavigatorItem( Home ) );
        _navigator.addScreen( SPLIT, new ScreenNavigatorItem( Split ) );
        _navigator.addScreen( CUSTOM, new ScreenNavigatorItem( Custom ) );
        _navigator.addScreen( HISTORY, new ScreenNavigatorItem( History ) );
        _navigator.addScreen( SETTINGS, new ScreenNavigatorItem( Settings ) );
        addChild( _navigator );

        _transitionManager = new ScreenSlidingStackTransitionManager( _navigator );
        _transitionManager.duration = 0.5;
        _transitionManager.ease = Transitions.EASE_OUT;

        _navigator.showScreen( HOME );

        addEventListener(Event.ADDED_TO_STAGE, addedHandler);
    }

    private function addedHandler(event:Event):void
    {
        removeEventListener(Event.ADDED_TO_STAGE, addedHandler);

        _tween = new Tween( Main._splashPic, 0.5);
        _tween.fadeTo(0);
        _tween.onComplete = function():void
        {
            Main._splashPic.parent.removeChild(Main._splashPic);
            Main._splashPic = null;
        };
        Starling.juggler.add(_tween);

        addEventListener(Home.CLICKED, triggeredHandler);
        stage.addEventListener(ResizeEvent.RESIZE, resizeHandler);
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

    private function triggeredHandler(event:starling.events.Event):void
    {
        _navigator.showScreen( _appModel.destination );
        _appModel.currentPage = _appModel.destination;
        trace("[APPLICATION] --- Screen Slide --- to " + _appModel.currentPage);
    }
}
}
