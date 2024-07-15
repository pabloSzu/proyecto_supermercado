import { TestBed } from '@angular/core/testing';
import { ResolveFn } from '@angular/router';
import { pedidosResolver } from './pedidos-resolver.service';



describe('pedidosResolver', () => {
  const executeResolver: ResolveFn<any> = (...resolverParameters) => 
      TestBed.runInInjectionContext(() => pedidosResolver(...resolverParameters));

  beforeEach(() => {
    TestBed.configureTestingModule({});
  });

  it('should be created', () => {
    expect(executeResolver).toBeTruthy();
  });
});
