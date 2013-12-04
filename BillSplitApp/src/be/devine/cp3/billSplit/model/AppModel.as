package be.devine.cp3.billSplit.model {
import flash.events.EventDispatcher;

public class AppModel extends EventDispatcher
{
    private static var instance:AppModel;

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
}
}

internal class Enforcer {}