import { NativeModules, Platform } from 'react-native';

const LINKING_ERROR =
  `The package 'react-native-camera-parameters' doesn't seem to be linked. Make sure: \n\n` +
  Platform.select({ ios: "- You have run 'pod install'\n", default: '' }) +
  '- You rebuilt the app after installing the package\n' +
  '- You are not using Expo Go\n';

const CameraParameters = NativeModules.CameraParameters
  ? NativeModules.CameraParameters
  : new Proxy(
      {},
      {
        get() {
          throw new Error(LINKING_ERROR);
        },
      }
    );

type CameraParametersType = {
  FOCAL_LENGTH: number;
  SENSOR_HEIGHT: number;
  SENSOR_WIDTH: number;
  DISPLAY_METRICS_Density: number;
  DISPLAY_METRICS_DensityDP: number;
  DISPLAY_METRICS_HeightPixel: number;
  DISPLAY_METRICS_ScaledDensity: number;
  DISPLAY_METRICS_WidthPixel: number;
  DISPLAY_METRICS_Xdp: number;
  DISPLAY_METRICS_Ydp: number;
};

// Android supported
export function getCameraParameters(): CameraParametersType {
  return CameraParameters.getConstants();
}

// IOS test function
export function multiply(a: number, b: number): number {
  return CameraParameters.multiply(a, b);
}
