import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ModalPuntuarComponent } from './modal-puntuar.component';

describe('ModalPuntuarComponent', () => {
  let component: ModalPuntuarComponent;
  let fixture: ComponentFixture<ModalPuntuarComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [ModalPuntuarComponent]
    });
    fixture = TestBed.createComponent(ModalPuntuarComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
