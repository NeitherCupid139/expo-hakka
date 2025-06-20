import * as React from 'react';

import { ExpoHakkaViewProps } from './ExpoHakka.types';

export default function ExpoHakkaView(props: ExpoHakkaViewProps) {
  return (
    <div>
      <iframe
        style={{ flex: 1 }}
        src={props.url}
        onLoad={() => props.onLoad({ nativeEvent: { url: props.url } })}
      />
    </div>
  );
}
