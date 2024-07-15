import { TestBed } from '@angular/core/testing';

import { ServiciosResourceService } from './servicios-resource.service';

describe('ServiciosResourceService', () => {
  let service: ServiciosResourceService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(ServiciosResourceService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
