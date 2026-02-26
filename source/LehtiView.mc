import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class LehtiView extends WatchUi.WatchFace {

    private var _leaf as BitmapResource;
    private var _droplet as BitmapResource;

    function initialize() {
        _leaf = Application.loadResource( Rez.Drawables.id_leaf ) as BitmapResource;
        _droplet = Application.loadResource( Rez.Drawables.id_droplet ) as BitmapResource;
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Get and show the current time
        var clockTime = System.getClockTime();
        var timeString = Lang.format("$1$:$2$", [clockTime.hour, clockTime.min.format("%02d")]);
        var view = View.findDrawableById("TimeLabel") as Text;
        view.setText(timeString);

        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);

        var width = dc.getWidth();
        var height = dc.getHeight();
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.fillRectangle(0, 0, width, height);
        dc.setColor(0xeff809, Graphics.COLOR_TRANSPARENT);
        dc.fillCircle(width / 2, height * 0.1, 7);
        dc.fillCircle(width * 0.9, height / 2, 7);
        dc.fillCircle(width / 2, height * 0.9, 7);
        dc.fillCircle(width * 0.1, height / 2, 7);
        dc.drawBitmap( width * 0.1, width * 0.1, _leaf);
        dc.drawBitmap( 50, 50, _droplet);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() as Void {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() as Void {
    }

}
