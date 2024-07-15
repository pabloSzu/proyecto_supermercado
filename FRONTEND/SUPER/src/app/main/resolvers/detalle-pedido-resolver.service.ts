import { ResolveFn } from '@angular/router';
import { inject } from '@angular/core';
import { ServiciosResourceService } from '../resources/servicios-resource.service';


export const detallePedidoResolver: ResolveFn<any> = (route, state) => {
  const idPedido = route.params['idPedido'];
  return inject(ServiciosResourceService).getDetallePedido({ id_pedido: idPedido });
};
