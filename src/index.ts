// Reexport the native module. On web, it will be resolved to ExpoHakkaModule.web.ts
// and on native platforms to ExpoHakkaModule.ts
export { default } from './ExpoHakkaModule';
export { default as ExpoHakkaView } from './ExpoHakkaView';
export * from  './ExpoHakka.types';
