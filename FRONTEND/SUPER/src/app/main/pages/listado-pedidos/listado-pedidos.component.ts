import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { ServiciosResourceService } from '../../resources/servicios-resource.service';
import Swal from 'sweetalert2';
import { NgbModal } from '@ng-bootstrap/ng-bootstrap';
import { ModalPuntuarComponent } from '../modal-puntuar/modal-puntuar.component';

@Component({
  selector: 'app-listado-pedidos',
  templateUrl: './listado-pedidos.component.html',
  styleUrls: ['./listado-pedidos.component.css']
})
export class ListadoPedidosComponent implements OnInit {

  imageUrl: string = '../../assets/splash_vertical.png';
  pedidos: any[] = [];
  pedidosOriginales: any[] = [];
  searchTerm: string = '';
  estadoFiltro: { [key: string]: boolean } = {
    PENDIENTE: false,
    EN_PROCESO: false,
    ENVIADO: false,
    ENTREGADO: false,
    CANCELADO: false
  };

  // Mapa para convertir códigos de estado a texto legible
  private estadoTextoMap: { [key: string]: string } = {
    PENDIENTE: $localize`PENDIENTE`,
    EN_PROCESO: $localize`EN PROCESO`,
    ENVIADO: $localize`ENVIADO`,
    ENTREGADO: $localize`ENTREGADO`,
    CANCELADO: $localize`CANCELADO`
  };

  constructor(
    private route: ActivatedRoute,
    private _service: ServiciosResourceService,
    private _modal: NgbModal
  ) { }

  ngOnInit(): void {
    this.route.data.subscribe((data) => {
      this.pedidos = Array.isArray(data['pedidos']) ? data['pedidos'] : []; // Verificar que sea un array
      this.pedidosOriginales = [...this.pedidos];
      this.aplicarFiltro(); // Aplica el filtro al inicio
    });
  }

  cancelarPedido(pedido: any): void {
    Swal.fire({
      title: $localize`¿Seguro que deseas cancelar el pedido '` + pedido["codigo_seguimiento"] + `' ?`,
      icon: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#3085d6',
      cancelButtonColor: '#d33',
      confirmButtonText: $localize`Sí, cancelar pedido`,
      cancelButtonText: $localize`No, mantener pedido`
    }).then((result) => {
      if (result.isConfirmed) {
        this._service.cancelarPedido(pedido).subscribe({
          next: (response) => {
            console.log(response);
            console.log("Pedido cancelado");
            Swal.fire(
              $localize`Cancelado!`,
              $localize`El pedido '` + pedido["codigo_seguimiento"] + `' ha sido cancelado. `,
              'success'
            );

            // Actualiza el estado del pedido en la lista
            const index = this.pedidosOriginales.findIndex(p => p.codigo_seguimiento === pedido.codigo_seguimiento);
            if (index !== -1) {
              this.pedidosOriginales[index].codigo_estado = 'CANCELADO';
              this.aplicarFiltro(); // Aplica el filtro después de actualizar
            }
          },
          error: (error) => {
            console.log(error);
            Swal.fire(
              'Error!',
              $localize`No se pudo cancelar el pedido.`,
              'error'
            );
          }
        });
      }
    });
  }

  actualizarPedidos(): void {
    this._service.getPedidos().subscribe({
      next: (pedidos) => {
        this.pedidos = Array.isArray(pedidos) ? pedidos : []; // Verificar que sea un array
        this.pedidosOriginales = [...this.pedidos];
        this.aplicarFiltro(); // Aplica el filtro después de actualizar los pedidos
      },
      error: (error) => {
        console.log("Error al actualizar los pedidos", error);
      }
    });
  }

  puntuar(pedido: any): void {
    const modalRef = this._modal.open(ModalPuntuarComponent);
    modalRef.componentInstance.pedido = pedido; // Pasa el objeto pedido al componente del modal
  }

  getEstadoClass(codigoEstado: string): string {
    switch (codigoEstado) {
      case 'PENDIENTE':
        return 'badge bg-secondary text-white';
      case 'EN_PROCESO':
        return 'badge bg-warning text-dark';
      case 'ENVIADO':
        return 'badge bg-primary';
      case 'ENTREGADO':
        return 'badge bg-success';
      case 'CANCELADO':
        return 'badge bg-danger';
      default:
        return '';
    }
  }

  getEstadoTexto(codigoEstado: string): string {
    return this.estadoTextoMap[codigoEstado] || codigoEstado;
  }

  toggleEstadoFiltro(key: string): void {
    this.estadoFiltro[key] = !this.estadoFiltro[key];
    this.aplicarFiltro();
  }

  aplicarFiltro(): void {
    // Obtener los estados seleccionados
    const estadosSeleccionados = Object.keys(this.estadoFiltro)
                                    .filter(key => this.estadoFiltro[key]);

    // Verificar si no hay estados seleccionados
    if (estadosSeleccionados.length === 0) {
        // Mostrar todos los pedidos
        this.pedidos = [...this.pedidosOriginales];
    } else {
        // Filtrar los pedidos basados en los estados seleccionados
        this.pedidos = this.pedidosOriginales
                         .filter((pedido: any) => estadosSeleccionados.includes(pedido.codigo_estado));
    }
  }

  obtenerEstadosSeleccionados(): string[] {
    return Object.keys(this.estadoFiltro)
                 .filter(key => this.estadoFiltro[key]);
  }
}
