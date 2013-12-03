/**
 * Created with IntelliJ IDEA.
 * User: JoonVT
 * Date: 03/12/13
 * Time: 22:26
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.starling {
import starling.display.Quad;
import starling.display.Sprite;

public class Application extends Sprite {


    public function Application() {

        var q:Quad = new Quad(100, 100, 0xff0000);
        addChild(q);
    }
}
}
