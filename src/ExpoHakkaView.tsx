import { requireNativeView } from 'expo';
import * as React from 'react';

import { ExpoHakkaViewProps } from './ExpoHakka.types';

const NativeView: React.ComponentType<ExpoHakkaViewProps> =
  requireNativeView('ExpoHakka');

export default function ExpoHakkaView(props: ExpoHakkaViewProps) {
  return <NativeView {...props} />;
}
