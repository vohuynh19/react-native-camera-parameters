#import "CameraParameters.h"
#import <AVFoundation/AVFoundation.h>

@implementation CameraParameters
RCT_EXPORT_MODULE()

// Example method
// See // https://reactnative.dev/docs/native-modules-ios
RCT_EXPORT_METHOD(getCameraInfo:(RCTResponseSenderBlock)callback)
{
  AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
  AVCaptureDeviceFormat *format = [device activeFormat];
  float sensorWidthInPx = format.highResolutionStillImageDimensions.width;
  float FOV = format.videoFieldOfView + 0.00001;
  float FOVInRadians = FOV * M_PI / 180.0;
  float focalLengthInPx = (sensorWidthInPx * 0.5) / tan(FOVInRadians / 2);

  NSDictionary *cameraInfo = @{
    @"FOCAL_LENGTH": [NSNumber numberWithDouble: focalLengthInPx],
    @"SENSOR_WIDTH": [NSNumber numberWithDouble: sensorWidthInPx],
  };

  callback(@[cameraInfo]);
}


// Don't compile this code when we build for the old architecture.
#ifdef RCT_NEW_ARCH_ENABLED
- (std::shared_ptr<facebook::react::TurboModule>)getTurboModule:
    (const facebook::react::ObjCTurboModule::InitParams &)params
{
    return std::make_shared<facebook::react::NativeCameraParametersSpecJSI>(params);
}
#endif

@end
