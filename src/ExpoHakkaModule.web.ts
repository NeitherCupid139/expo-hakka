import { registerWebModule, NativeModule } from 'expo';

import { ExpoHakkaModuleEvents } from './ExpoHakka.types';

class ExpoHakkaModule extends NativeModule<ExpoHakkaModuleEvents> {
  PI = Math.PI;
  async setValueAsync(value: string): Promise<void> {
    this.emit('onChange', { value });
  }
  hello() {
    return 'Hello world! 👋';
  }
}

export default registerWebModule(ExpoHakkaModule, 'ExpoHakkaModule');
