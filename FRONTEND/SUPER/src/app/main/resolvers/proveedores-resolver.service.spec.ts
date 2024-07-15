import { TestBed } from '@angular/core/testing';
import { ResolveFn } from '@angular/router';
import { proveedoresResolver } from './proveedores-resolver.service';



describe('proveedoresResolver', () => {
  const executeResolver: ResolveFn<any> = (...resolverParameters) => 
      TestBed.runInInjectionContext(() => proveedoresResolver(...resolverParameters));

  beforeEach(() => {
    TestBed.configureTestingModule({});
  });

  it('should be created', () => {
    expect(executeResolver).toBeTruthy();
  });
});
