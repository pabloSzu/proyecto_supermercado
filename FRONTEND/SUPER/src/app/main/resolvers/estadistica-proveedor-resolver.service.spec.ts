import { TestBed } from '@angular/core/testing';
import { ResolveFn } from '@angular/router';
import { estadisticaProveedorResolver } from './estadistica-proveedor-resolver.service';



describe('estadisticaProveedorResolver', () => {
  const executeResolver: ResolveFn<any> = (...resolverParameters) => 
      TestBed.runInInjectionContext(() => estadisticaProveedorResolver(...resolverParameters));

  beforeEach(() => {
    TestBed.configureTestingModule({});
  });

  it('should be created', () => {
    expect(executeResolver).toBeTruthy();
  });
});
