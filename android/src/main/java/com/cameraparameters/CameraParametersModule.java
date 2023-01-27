package com.cameraparameters;

import androidx.annotation.NonNull;

import java.util.Map;
import java.util.HashMap;
import android.util.DisplayMetrics;
import android.widget.Toast;
import android.content.Context;
import android.hardware.camera2.CameraManager;
import android.hardware.camera2.CameraCaptureSession;
import android.hardware.camera2.CameraCharacteristics;

import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.module.annotations.ReactModule;

@ReactModule(name = CameraParametersModule.NAME)
public class CameraParametersModule extends ReactContextBaseJavaModule {
  public static final String NAME = "CameraParameters";

  public CameraParametersModule(ReactApplicationContext reactContext) {
    super(reactContext);
  }

  @Override
  @NonNull
  public String getName() {
    return NAME;
  }

  @Override
  @NonNull
  public Map<String, Object> getConstants() {
    final Map<String, Object> constants = new HashMap<>();
    double focalLength = 4.12F, sensorHeight = 3.14, sensorWidth = 4.9, xdpi = 295, ydpi = 295;
     DisplayMetrics displayMetrics=null;
     try{
       displayMetrics = getReactApplicationContext().getResources().getDisplayMetrics();
       CameraManager mCameraManager = (CameraManager) getReactApplicationContext().getSystemService(Context.CAMERA_SERVICE);
       String frontCameraId = null;
        for (String cameraId : mCameraManager.getCameraIdList()) {
           CameraCharacteristics characteristics = mCameraManager.getCameraCharacteristics(cameraId);
           Integer facing = characteristics.get(CameraCharacteristics.LENS_FACING);
           if (facing != null && facing == CameraCharacteristics.LENS_FACING_FRONT) {
               frontCameraId = cameraId;
               break;
           }
       }
       CameraCharacteristics cameraCharacteristics = mCameraManager.getCameraCharacteristics(frontCameraId);
       focalLength = cameraCharacteristics.get(CameraCharacteristics.LENS_INFO_AVAILABLE_FOCAL_LENGTHS)[0];
       sensorHeight = cameraCharacteristics.get(CameraCharacteristics.SENSOR_INFO_PHYSICAL_SIZE).getHeight();
       sensorWidth = cameraCharacteristics.get(cameraCharacteristics.SENSOR_INFO_PHYSICAL_SIZE).getWidth();
     }
     
     catch(Exception e){
         Toast.makeText(getReactApplicationContext(),"Exception "+e,Toast.LENGTH_SHORT).show();
     }
     finally{
       constants.put("FOCAL_LENGTH",focalLength);
       constants.put("SENSOR_HEIGHT",sensorHeight);
       constants.put("SENSOR_WIDTH",sensorWidth);
       
       constants.put("DISPLAY_METRICS_Density",displayMetrics.density);
       constants.put("DISPLAY_METRICS_DensityDPI",displayMetrics.densityDpi);
       constants.put("DISPLAY_METRICS_HeightPixels",displayMetrics.heightPixels);
       constants.put("DISPLAY_METRICS_WidthPixels",displayMetrics.widthPixels);
       constants.put("DISPLAY_METRICS_ScaledDensity",displayMetrics.scaledDensity);
       constants.put("DISPLAY_METRICS_Xdpi",displayMetrics.xdpi);
       constants.put("DISPLAY_METRICS_Ydpi",displayMetrics.ydpi);
     }
    return constants;
  }


  // Example method
  // See https://reactnative.dev/docs/native-modules-android
  @ReactMethod
  public void multiply(double a, double b, Promise promise) {
    promise.resolve(a * b);
  }

  
}
