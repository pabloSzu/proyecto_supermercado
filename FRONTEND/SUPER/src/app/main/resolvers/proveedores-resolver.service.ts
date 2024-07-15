import { ResolveFn } from '@angular/router';
import { inject } from '@angular/core';
import { ServiciosResourceService } from '../resources/servicios-resource.service';


export const proveedoresResolver: ResolveFn<any> = (route, state) => {
  return inject(ServiciosResourceService).getProveedores();
};
