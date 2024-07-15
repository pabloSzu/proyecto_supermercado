import { Injectable } from '@angular/core';
import { IResourceMethodObservable, Resource, ResourceAction, ResourceHandler, ResourceParams, ResourceRequestBodyType, ResourceRequestMethod, ResourceResponseBodyType } from '@ngx-resource/core';

import { environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root'
})
@ResourceParams({
  pathPrefix: `${environment.apiUrl}`
})
export class ServiciosResourceService extends Resource {

  constructor(handler?: ResourceHandler) {
    super(handler);
  }
  
  @ResourceAction({
    method: ResourceRequestMethod.Post,
    path: '/login',
  })
  loginUsuario!: IResourceMethodObservable<{ usuario: any }, any>;

  @ResourceAction({
    method: ResourceRequestMethod.Post,
    path: '/pedidos',
  })
  getPedidos!: IResourceMethodObservable<{ pedidos: any }, any>;
  
  @ResourceAction({
    method: ResourceRequestMethod.Post,
    path: '/cancelar_pedido',
  })
  cancelarPedido!: IResourceMethodObservable<{ pedidos: any }, any>;

  @ResourceAction({
    method: ResourceRequestMethod.Post,
    path: '/ranking_ponderado',
  })
  obtenerRanking!: IResourceMethodObservable<{ id_proveedor: any }, any>;

  @ResourceAction({
    method: ResourceRequestMethod.Post,
    path: '/productos_proveedor',
  })
  obtenerProductosProveedor!: IResourceMethodObservable<{ id_proveedor: any }, any>;

  @ResourceAction({
    method: ResourceRequestMethod.Post,
    path: '/evaluar_pedido',
  })
  evaluarPedido!: IResourceMethodObservable<any, any>;

  @ResourceAction({
    method: ResourceRequestMethod.Post,
    path: '/pedido_proveedor',
  })
  getPedidosProveedor!: IResourceMethodObservable<any, any>;

  @ResourceAction({
    method: ResourceRequestMethod.Post,
    path: '/estadistica_proveedor',
  })
  getEstadisticaProveedor!: IResourceMethodObservable< any , any>;

  @ResourceAction({
    method: ResourceRequestMethod.Post,
    path: '/update_ponderacion',
  })
  updatePonderacion!: IResourceMethodObservable< any , any>;

  @ResourceAction({
    method: ResourceRequestMethod.Post,
    path: '/proveedores',
  })
  getProveedores!: IResourceMethodObservable<{ proveedores: any }, any>;

  @ResourceAction({
    method: ResourceRequestMethod.Post,
    path: '/altabaja_proveedor',
  })
  altabajaProveedor!: IResourceMethodObservable<any , any>;

  @ResourceAction({
    method: ResourceRequestMethod.Post,
    path: '/detalle_pedido',
  })
  getDetallePedido!: IResourceMethodObservable< any , any>;

  @ResourceAction({
    method: ResourceRequestMethod.Post,
    path: '/datos_proveedor',
  })
  getDatosProveedor!: IResourceMethodObservable< any , any>;

  @ResourceAction({
    method: ResourceRequestMethod.Post,
    path: '/productos_join',
  })
  getProductosJoin!: IResourceMethodObservable< any , any>;

  @ResourceAction({
    method: ResourceRequestMethod.Post,
    path: '/insertar_datos_proveedor',
  })
  insertProveedorNuevo!: IResourceMethodObservable< any , any>;
}
