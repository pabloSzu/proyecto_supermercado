import { ResolveFn } from '@angular/router';
import { inject } from '@angular/core';
import { ServiciosResourceService } from '../resources/servicios-resource.service';


export const pedidosProveedorResolver: ResolveFn<any> = (route, state) => {
  const idProveedor = route.params['idProveedor'];
  return inject(ServiciosResourceService).getPedidosProveedor({ id_proveedor: idProveedor });
};
