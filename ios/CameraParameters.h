
#ifdef RCT_NEW_ARCH_ENABLED
#import "RNCameraParametersSpec.h"

@interface CameraParameters : NSObject <NativeCameraParametersSpec>
#else
#import <React/RCTBridgeModule.h>

@interface CameraParameters : NSObject <RCTBridgeModule>
#endif

@end
