import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.Math;

class LehtiView extends WatchUi.WatchFace {

    private var _leaf as BitmapResource;
    private var _droplet as BitmapResource;
    private var _caterpillar as BitmapResource;
    private var _three as BitmapResource;
    private var _six as BitmapResource;
    private var _nine as BitmapResource;
    private var _twelve as BitmapResource;
    private var isAwake as Boolean = true;

    function initialize() {
        _leaf = Application.loadResource( Rez.Drawables.id_leaf ) as BitmapResource;
        _droplet = Application.loadResource( Rez.Drawables.id_droplet ) as BitmapResource;
        _caterpillar = Application.loadResource( Rez.Drawables.id_caterpillar ) as BitmapResource;
        _three = Application.loadResource( Rez.Drawables.id_three ) as BitmapResource;
        _six = Application.loadResource( Rez.Drawables.id_six ) as BitmapResource;
        _nine = Application.loadResource( Rez.Drawables.id_nine ) as BitmapResource;
        _twelve = Application.loadResource( Rez.Drawables.id_twelve ) as BitmapResource;
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
        var centerX = width / 2.0;
        var centerY = height / 2.0;
        var ballOffsetX = 17; 
        var ballOffsetY = 17;

        if (isAwake) {
            dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
            dc.fillRectangle(0, 0, width, height);
        } else {
            dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
            dc.clear();
        }

        dc.drawBitmap((width * 0.9) - ballOffsetX, centerY - ballOffsetY, _three);
        dc.drawBitmap(centerX - ballOffsetX, (height * 0.9) - ballOffsetY, _six);
        dc.drawBitmap((width * 0.1) - ballOffsetX, centerY - ballOffsetY, _nine);
        dc.drawBitmap(centerX - ballOffsetX, (height * 0.1) - ballOffsetY, _twelve);

        var hour12 = clockTime.hour % 12;
        var hourAngle = ((hour12 + (clockTime.min / 60.0)) / 12.0) * Math.PI * 2;
        var leafWidth = _leaf.getWidth();
        var leafHeight = _leaf.getHeight();
        var leafCenterX = leafWidth / 2.0;
        var leafCenterY = leafHeight / 2.0;
        var transform = new Graphics.AffineTransform();
        transform.setToTranslation(leafCenterX, leafCenterY);
        transform.rotate(hourAngle);
        transform.translate(-leafCenterX, -leafCenterY);
        var options = {
            :transform => transform,
            :filterMode => Graphics.FILTER_MODE_BILINEAR 
        };
        dc.drawBitmap2(0, 0, _leaf, options);

        var minAngle = ((clockTime.min + (clockTime.sec / 60.0)) / 60.0) * Math.PI * 2 - (Math.PI / 2.0);
        var minRadius = width * 0.3;
        var dropletX = centerX + (minRadius * Math.cos(minAngle));
        var dropletY = centerY + (minRadius * Math.sin(minAngle));
        var dropOffsetX = _droplet.getWidth() / 2.0;
        var dropOffsetY = _droplet.getHeight() / 2.0;
        dc.drawBitmap(dropletX - dropOffsetX, dropletY - dropOffsetY, _droplet);

        if (isAwake) {
            var secAngle = (clockTime.sec / 60.0) * Math.PI * 2 - (Math.PI / 2.0);
            var secRadius = width * 0.27; 
            var caterpillarX = centerX + (secRadius * Math.cos(secAngle));
            var caterpillarY = centerY + (secRadius * Math.sin(secAngle));
            var catWidth = _caterpillar.getWidth();
            var catHeight = _caterpillar.getHeight();
            var catCenterX = catWidth / 2.0;
            var catCenterY = catHeight / 2.0;
            var catTransform = new Graphics.AffineTransform();
            catTransform.setToTranslation(caterpillarX, caterpillarY);
            var catRotationAngle = secAngle + (Math.PI / 2.0); 
            catTransform.rotate(catRotationAngle);
            catTransform.translate(-catCenterX, -catCenterY);
            var catOptions = {
                :transform => catTransform,
                :filterMode => Graphics.FILTER_MODE_BILINEAR 
            };
            dc.drawBitmap2(0, 0, _caterpillar, catOptions);
        }
    }

    function onHide() as Void {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() as Void {
        isAwake = true;
        WatchUi.requestUpdate();
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() as Void {
        isAwake = false;
        WatchUi.requestUpdate();
    }
}
