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
        var clockTime = System.getClockTime();
        var width = dc.getWidth();
        var height = dc.getHeight();
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.fillRectangle(0, 0, width, height);

        dc.setColor(0xeff809, Graphics.COLOR_TRANSPARENT);
        dc.fillCircle(width / 2, height * 0.1, height * 0.05);
        dc.fillCircle(width * 0.9, height / 2, height * 0.05);
        dc.fillCircle(width / 2, height * 0.9, height * 0.05);
        dc.fillCircle(width * 0.1, height / 2, height * 0.05);

        var angle = (clockTime.sec / 60.0) * Math.PI * 2 - (Math.PI / 2.0);
        var radius = width * 0.3;
        var centerX = width / 2;
        var centerY = height / 2;
        var dropletX = centerX + (radius * Math.cos(angle));
        var dropletY = centerY + (radius * Math.sin(angle));
        var offsetX = _droplet.getWidth() / 2;
        var offsetY = _droplet.getHeight() / 2;
        dc.drawBitmap(dropletX - offsetX, dropletY - offsetY, _droplet);
        dc.drawBitmap( width * 0.1, width * 0.1, _leaf);
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
