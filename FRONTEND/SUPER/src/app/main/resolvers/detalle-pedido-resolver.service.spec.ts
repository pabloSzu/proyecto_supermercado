import { TestBed } from '@angular/core/testing';
import { ResolveFn } from '@angular/router';
import { detallePedidoResolver } from './detalle-pedido-resolver.service';



describe('detallePedidoResolver', () => {
  const executeResolver: ResolveFn<any> = (...resolverParameters) => 
      TestBed.runInInjectionContext(() => detallePedidoResolver(...resolverParameters));

  beforeEach(() => {
    TestBed.configureTestingModule({});
  });

  it('should be created', () => {
    expect(executeResolver).toBeTruthy();
  });
});
