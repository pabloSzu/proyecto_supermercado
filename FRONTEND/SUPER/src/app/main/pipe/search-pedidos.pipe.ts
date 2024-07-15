import { Pipe, PipeTransform } from '@angular/core';


@Pipe({
  name: 'searchPedidos'
})
export class SearchPedidosPipe implements PipeTransform {

  transform(pedidos: any[], searchTerm: string): any[] {
    if (!pedidos || !searchTerm) {
      return pedidos;
    }

    return pedidos.filter(pedido =>
      pedido.nombre_proveedor.toLowerCase().includes(searchTerm.toLowerCase()) ||
      pedido.codigo_estado.toLowerCase().includes(searchTerm.toLowerCase()) ||
      pedido.codigo_seguimiento.toLowerCase().includes(searchTerm.toLowerCase())
    );
  }
}

