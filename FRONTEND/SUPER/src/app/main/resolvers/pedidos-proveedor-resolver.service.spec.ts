import { TestBed } from '@angular/core/testing';
import { ResolveFn } from '@angular/router';
import { pedidosProveedorResolver } from './pedidos-proveedor-resolver.service';



describe('PedidosproveedorResolver', () => {
  const executeResolver: ResolveFn<any> = (...resolverParameters) => 
      TestBed.runInInjectionContext(() => pedidosProveedorResolver(...resolverParameters));

  beforeEach(() => {
    TestBed.configureTestingModule({});
  });

  it('should be created', () => {
    expect(executeResolver).toBeTruthy();
  });
});
