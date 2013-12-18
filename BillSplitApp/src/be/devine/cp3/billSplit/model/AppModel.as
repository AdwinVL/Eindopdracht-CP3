package be.devine.cp3.billSplit.model {
import flash.events.Event;
import flash.events.EventDispatcher;

public class AppModel extends EventDispatcher
{
    private static var instance:AppModel;

    public static const CURRENTPAGE_CHANGED_EVENT:String = "currentPageChanged";

    private var _currentPage:String = "home";
    private var _destination:String = "";

    private var _payers:uint;

    public static function getInstance():AppModel
    {
        if (instance == null) {
            instance = new AppModel(new Enforcer());
        }
        return instance;
    }

    public function AppModel(e:Enforcer)
    {
        if (e == null)
        {
            throw new Error("AppModel is a singleton, use getInstance() instead");
        }
    }

    [Bindable(event="currentPageChanged")]
    public function get currentPage():String
    {
        return _currentPage;
    }

    public function set currentPage(value:String):void
    {
        if (_currentPage == value) return;
        _currentPage = value;
        dispatchEvent(new Event(CURRENTPAGE_CHANGED_EVENT));
    }

    [Bindable(event="destinationChanged")]
    public function get destination():String
    {
        return _destination;
    }

    public function set destination(value:String):void
    {
        if (_destination == value) return;
        _destination = value;
    }

    public function get payers():uint
    {
        return _payers;
    }

    public function set payers(value:uint):void
    {
        _payers = value;
    }
}
}

internal class Enforcer {}