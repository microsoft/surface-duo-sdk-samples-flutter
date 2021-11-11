package com.example.duo_flutter_sample

import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant

// Surface Du: Required imports for the Surface Du APIs
import io.flutter.plugin.common.MethodChannel
import com.microsoft.device.display.DisplayMask
import android.hardware.Sensor
import android.hardware.SensorManager
import android.hardware.SensorEvent
import android.hardware.SensorEventListener
import android.util.Log

class MainActivity: FlutterActivity() {
    // Surface Du: Platform Channel Name (matches what Flutter app passes)
    private val CHANNEL = "duosdk.microsoft.dev"
    // Surface Du: The name of the Hinge Angle sensor we will look for
    private val HINGE_ANGLE_SENSOR_NAME = "Hinge Angle"
    // Surface Du:  Store the sensor info and current hinge value
    private var mSensorsSetup : Boolean = false
    private var mSensorManager: SensorManager? = null
    private var mHingeAngleSensor: Sensor? = null
    private var mSensorListener: SensorEventListener? = null
    private var mCurrentHingeAngle: Float = 0.0f

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);

        // Surface Duo: Here is were we define the Method Channel and how we handle the requests
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
        call, result ->
            if (!isDualScreenDevice()) {
                result.success(false)
            } else {
                try {
                    when (call.method) {
                        "isDualScreenDevice" -> {
                            if (isDualScreenDevice()) {
                                result.success(true)
                            } else {
                                result.success(false)
                            }
                        }
                        "isAppSpanned" -> {
                            if (isAppSpanned()) {
                                result.success(true)
                            } else {
                                result.success(false)
                            }
                        }
                        "getHingeAngle" -> {
                            if (!mSensorsSetup) setupSensors()
                            result.success(mCurrentHingeAngle)
                        }
                        "getHingeSize" -> {
                        result.success(getHingeSize())
                        }
                        else -> {
                            result.notImplemented()
                        }
                    }
                } catch (e: Exception) {
                    Log.i("error", e.toString())
                    result.success(false)
                }
            }
        }
    }

    fun getHingeSize(): Int {
        //The size will always be the same,
        // it will either be the height (Double Landscape)
        // or the width (Double portrait)
        val displayMask = DisplayMask.fromResourcesRectApproximation(activity)
        val boundings = displayMask.boundingRects

        if (boundings.isEmpty()) return 0

        val first = boundings[0]

        val density: Float = activity!!.resources.displayMetrics.density

        val height = ((first.right / density) - (first.left / density)).toInt()
        val width = ((first.bottom / density) - (first.top / density)).toInt()

        if (width < height) {
            return width
        } else {
            return height
        }
    }

    // Surface Duo: Is the app running on a Dual-Screen device
    fun isDualScreenDevice(): Boolean {
        val feature = "com.microsoft.device.display.displaymask"
        val pm = context.packageManager
        if (pm.hasSystemFeature(feature)) {
            return true
        } else {
            return false
        }
    }

    // Surface Duo: Is the app running Spanned across screens or not
    fun isAppSpanned(): Boolean {
        var displayMask = DisplayMask.fromResourcesRectApproximation(this)
        var boundings = displayMask.getBoundingRects()
        var first = boundings.get(0)
        var rootView = this.getWindow().getDecorView().getRootView()
        var drawingRect = android.graphics.Rect()
        rootView.getDrawingRect(drawingRect)
        if (first.intersect(drawingRect)) {
            return true
        } else {
            return false
        }
    }

    // Surface Duo: Setup listening for the Hinge Sensor and update the Angle value
    private fun setupSensors() {
        mSensorManager = getSystemService(SENSOR_SERVICE) as SensorManager?
        val sensorList: List<Sensor> = mSensorManager!!.getSensorList(Sensor.TYPE_ALL)
        for (sensor in sensorList) {
            if (sensor.getName().contains(HINGE_ANGLE_SENSOR_NAME)) {
                mHingeAngleSensor = sensor
                break
            }
        }
        mSensorListener = object : SensorEventListener {
            override fun onSensorChanged(event: SensorEvent) {
                if (event.sensor === mHingeAngleSensor) {
                    mCurrentHingeAngle = event.values.get(0) as Float
                }
            }

            override fun onAccuracyChanged(sensor: Sensor?, accuracy: Int) {
                //TODO
            }
        }

        mSensorManager?.registerListener(mSensorListener, mHingeAngleSensor, SensorManager.SENSOR_DELAY_NORMAL)

        mSensorsSetup = true
    }
}
