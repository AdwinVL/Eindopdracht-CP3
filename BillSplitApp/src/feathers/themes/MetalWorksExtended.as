/**
 * Created with IntelliJ IDEA.
 * User: School
 * Date: 14/12/13
 * Time: 22:13
 * To change this template use File | Settings | File Templates.
 */
package feathers.themes {
import feathers.controls.Button;

import starling.display.DisplayObjectContainer;

import flash.text.TextFormat;

public class MetalWorksExtended extends MetalWorksMobileTheme
{
    [Embed(source="/../assets/fonts/Blanch/BLANCH_CONDENSED.otf", embedAsCFF="false", fontFamily="Blanch")]
    private static const Blanch:Class;

    public static const ALTERNATE_NAME_MY_CUSTOM_BUTTON:String = "my-custom-button";

    private const fontNames:String = "Blanch";

    public function MetalWorksExtended( root:DisplayObjectContainer, scaleToDPI:Boolean = true )
    {
        super( root, scaleToDPI );

    }
    override protected function initialize():void
    {

        super.initialize();

        this.setInitializerForClass( Button, myCustomButtonInitializer, ALTERNATE_NAME_MY_CUSTOM_BUTTON );
    }

    private function myCustomButtonInitializer( button:Button ):void
    {
        //button.defaultLabelProperties.textFormat = new TextFormat(fontNames, 30, 0x000000);
    }

}
}
