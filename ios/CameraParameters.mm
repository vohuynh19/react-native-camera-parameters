#import "CameraParameters.h"
#import <AVFoundation/AVFoundation.h>

@implementation CameraParameters
RCT_EXPORT_MODULE()

// Example method
// See // https://reactnative.dev/docs/native-modules-ios
RCT_REMAP_METHOD(multiply,
                 multiplyWithA:(double)a withB:(double)b
                 withResolver:(RCTPromiseResolveBlock)resolve
                 withRejecter:(RCTPromiseRejectBlock)reject)
{
    NSNumber *result = @(a * b);

    resolve(result);
}

- (NSDictionary *)getConstants {
    AVCaptureDevice *frontCamera = [AVCaptureDevice defaultDeviceWithDeviceType:AVCaptureDeviceTypeBuiltInWideAngleCamera mediaType:AVMediaTypeVideo position:AVCaptureDevicePositionFront];
    NSDictionary *cameraProperties = @{
                                      @"FOCAL_LENGTH": [NSNumber numberWithFloat:frontCamera.activeFormat.videoFocusMode],
                                      @"SENSOR_HEIGHT": [NSNumber numberWithFloat:frontCamera.activeFormat.highResolutionStillImageDimensions.height],
                                      @"SENSOR_WIDTH": [NSNumber numberWithFloat:frontCamera.activeFormat.highResolutionStillImageDimensions.width]
                                      };
    return cameraProperties;
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
