import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ProveedorProductosYRankingComponent } from './proveedor-productos-y-ranking.component';

describe('ProveedorProductosYRankingComponent', () => {
  let component: ProveedorProductosYRankingComponent;
  let fixture: ComponentFixture<ProveedorProductosYRankingComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [ProveedorProductosYRankingComponent]
    });
    fixture = TestBed.createComponent(ProveedorProductosYRankingComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
