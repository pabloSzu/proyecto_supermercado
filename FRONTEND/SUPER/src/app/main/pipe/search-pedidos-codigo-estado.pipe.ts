import { Pipe, PipeTransform } from '@angular/core';

@Pipe({
  name: 'searchPedidosCodigoEstado'
})
export class SearchPedidosCodigoEstadoPipe implements PipeTransform {

  transform(pedidos: any[], estadosSeleccionados: string[]): any[] {
    if (!pedidos || !estadosSeleccionados || estadosSeleccionados.length === 0) {
      return pedidos;
    }

    return pedidos.filter(pedido =>
      estadosSeleccionados.includes(pedido.codigo_estado)
    );
  }

}
