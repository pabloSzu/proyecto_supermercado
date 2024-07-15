import { AppErrorHandler } from './app-error-handler';
const injector = {} as any; // Proporciona un objeto simulado para Injector
const ngZone = {} as any; // Proporciona un objeto simulado para NgZone

describe('AppErrorHandler', () => {
  it('should create an instance', () => {
    expect(new AppErrorHandler(injector, ngZone)).toBeTruthy();
  });
});
