import { NativeModule, requireNativeModule } from "expo";

// 简化的模块事件类型
export type ExpoHakkaModuleEvents = {
	onToolbarButtonPress: (params: { buttonId: string; itemId?: string }) => void;
};

declare class ExpoHakkaModule extends NativeModule<ExpoHakkaModuleEvents> {
	hello(): string;
}

// This call loads the native module object from the JSI.
export default requireNativeModule<ExpoHakkaModule>("ExpoHakka");
