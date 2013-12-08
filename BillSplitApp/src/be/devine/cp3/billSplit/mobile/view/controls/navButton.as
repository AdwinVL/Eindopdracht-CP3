/**
 * Created with IntelliJ IDEA.
 * User: School
 * Date: 8/12/13
 * Time: 19:24
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.billSplit.mobile.view.controls {
import feathers.controls.Button;

public class navButton extends Button {

    public var destination:String;

    public function navButton(destination:String) {

        this.destination = destination;
    }
}
}
