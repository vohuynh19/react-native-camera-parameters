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
  CMVideoDimensions dimensions = CMVideoFormatDescriptionGetDimensions(format.formatDescription);
  AVFrameRateRange *range = format.videoSupportedFrameRateRanges.firstObject;
  
  NSDictionary *cameraInfo = @{
    @"FOCAL_LENGTH": [NSNumber numberWithDouble:format.videoFieldOfView],
    @"SENSOR_WIDTH": [NSNumber numberWithDouble:dimensions.width],
    @"SENSOR_HEIGHT": [NSNumber numberWithDouble:dimensions.height],
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
