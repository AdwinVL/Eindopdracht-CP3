/**
 * Created by School on 19/12/13.
 */
package be.devine.cp3.billSplit.mobile.view.controls {
import starling.display.Quad;
import starling.display.Sprite;
import starling.text.TextField;

public class PriceTag extends Sprite{

    public var amount:uint;
    private var bg:Quad;
    private var text:TextField;

    public function PriceTag(price:uint) {
        amount = price;

        text = new TextField(50, 50, "€" + amount.toString(),"Blanch", 20, 0x000000);
        bg = new Quad(50, 50, 0xffffff);

        addChild(bg);
        addChild(text);
    }
}
}
