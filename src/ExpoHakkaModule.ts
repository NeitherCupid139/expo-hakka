import { NativeModule, requireNativeModule } from 'expo';

import { ExpoHakkaModuleEvents } from './ExpoHakka.types';

declare class ExpoHakkaModule extends NativeModule<ExpoHakkaModuleEvents> {
  PI: number;
  hello(): string;
  setValueAsync(value: string): Promise<void>;
}

// This call loads the native module object from the JSI.
export default requireNativeModule<ExpoHakkaModule>('ExpoHakka');
