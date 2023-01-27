import * as React from 'react';

import { StyleSheet, View, Text } from 'react-native';
import {
  getCameraParameters,
  getCameraInfo,
} from 'react-native-camera-parameters';

export default function App() {
  React.useEffect(() => {
    console.log(getCameraParameters());
    getCameraInfo((cameraInfo: any) => {
      console.log('cameraInfo', cameraInfo);
    });
  }, []);

  return (
    <View style={styles.container}>
      <Text>Result: {getCameraParameters().FOCAL_LENGTH}</Text>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  box: {
    width: 60,
    height: 60,
    marginVertical: 20,
  },
});
