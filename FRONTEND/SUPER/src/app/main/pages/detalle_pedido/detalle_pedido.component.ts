import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { ServiciosResourceService } from '../../resources/servicios-resource.service';
import Swal from 'sweetalert2';
import { NgbModal } from '@ng-bootstrap/ng-bootstrap';
import { ModalPuntuarComponent } from '../modal-puntuar/modal-puntuar.component';

@Component({
  selector: 'app-detalle_pedido',
  templateUrl: './detalle_pedido.component.html',
  styleUrls: ['./detalle_pedido.component.css']
})
export class DetallePedidoComponent implements OnInit {
  pedido: any; // Variable para almacenar los datos del pedido
  productos: any[] = [];
  imageUrl: string = '../../assets/splash_vertical.png';

  constructor(
    private route: ActivatedRoute,
    private _service: ServiciosResourceService,
    private _router: Router,
    private _modal: NgbModal
  ) { }

  ngOnInit() {
    this.route.params.subscribe(params => {
      this.cargarDetallePedido(); // Cargar detalle del pedido inicialmente y al cambiar los parámetros
    });
  }
  

  cargarDetallePedido(): void {
    this.route.data.subscribe((data) => {
      // Devuelve un objeto con una clave 'productos'
      const detallePedido = data['productos'];
      // El primer elemento del primer array es el PEDIDO
      this.pedido = detallePedido[0][0];
      // Los elementos restantes en el primer array son productos
      if (detallePedido.length > 1) {
        this.productos = detallePedido[1];
      }
      console.log("Pedido:", this.pedido);
      console.log("Productos:", this.productos);
    });
  }

  obtenerImagenBase64(imagen_contenido: string) {
    // Convierte la cadena Base64 a URL
    return `data:image/jpeg;base64,${imagen_contenido}`;
  }

  puntuar(pedido: any): void {
    const modalRef = this._modal.open(ModalPuntuarComponent);
    modalRef.componentInstance.pedido = pedido; // Pasa el objeto pedido al componente del modal
  }

  cancelarPedido(pedido: any): void {
    Swal.fire({
      title: $localize`¿Seguro que deseas cancelar el pedido ` + pedido["codigo_seguimiento"] + ' ?',
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
            console.log(response); // Verifica la respuesta del servicio en la consola
            console.log("Pedido cancelado");
  
            // Redireccionar a la ruta especificada después de cancelar
            this._router.navigate(['main/detalle_pedido', pedido.id_pedido]);
  
            // Actualizar datos después de la redirección
            this.actualizarPedido(pedido.id_pedido);
  
            Swal.fire(
              $localize`Cancelado!`,
              $localize`El pedido ` + pedido["codigo_seguimiento"] + $localize`ha sido cancelado. `,
              'success'
            );
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
  
  actualizarPedido(pedido: any): void {
    this._service.getDetallePedido(this.pedido).subscribe({
      next: (response) => {
        this.pedido = response[0][0];
      },
      error: (error) => {
        console.log(error);
        console.log("Error en la evaluación");
      }
    });
    
  }
}
  