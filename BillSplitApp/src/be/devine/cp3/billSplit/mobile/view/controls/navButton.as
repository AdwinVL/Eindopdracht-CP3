/**
 * Created with IntelliJ IDEA.
 * User: School
 * Date: 8/12/13
 * Time: 19:24
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.billSplit.mobile.view.controls {
import be.devine.cp3.billSplit.model.AppModel;

import feathers.controls.Button;

public class navButton extends Button {

    private var _appModel:AppModel;

    public var destination:String;

    public function navButton(destination:String) {

        super();
        _appModel = AppModel.getInstance();
        this.destination = destination;
    }
}
}
