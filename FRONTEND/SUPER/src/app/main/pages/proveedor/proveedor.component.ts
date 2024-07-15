import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { ServiciosResourceService } from '../../resources/servicios-resource.service';
import Swal from 'sweetalert2';
import { NgbModal } from '@ng-bootstrap/ng-bootstrap';
import { ModalPuntuarComponent } from '../modal-puntuar/modal-puntuar.component';

@Component({
  selector: 'app-proveedor',
  templateUrl: './proveedor.component.html',
  styleUrls: ['./proveedor.component.css']
})
export class ProveedorComponent implements OnInit {

  imageUrl: string = '../../assets/splash_vertical.png';

  pedidos: any[] = [];
  estadistica: any[] = [];

  constructor(
    private _router: Router, 
    private route: ActivatedRoute,
    private _service: ServiciosResourceService, 
    private _modal: NgbModal
  ) { }

  ngOnInit(): void {
    this.route.data.subscribe((data) => {
      this.pedidos = Array.isArray(data['pedidos']) ? data['pedidos'] : [];
      console.log('Datos del resolver:', this.pedidos);
    });
    this.route.data.subscribe((data) => {
      this.estadistica = Array.isArray(data['estadistica']) ? data['estadistica'] : [];
      console.log('Datos del resolver:', this.estadistica);
    });
    console.log(this.estadistica);
  }

  getCircleColor(puntaje: number): string {
    if (puntaje >= 0 && puntaje < 3) {
      return '#FF5733'; // Rojo
    } else if (puntaje >= 2 && puntaje < 4) {
      return '#FDC60A'; // Amarillo
    } else {
      return '#4CAF50'; // Verde
    }
  }

  getEstadoTexto(codigoEstado: string): string {
    switch (codigoEstado) {
      case 'PENDIENTE':
        return 'PENDIENTE';
      case 'EN_PROCESO':
        return 'EN PROCESO';
      case 'ENVIADO':
        return 'ENVIADO';
      case 'ENTREGADO':
        return 'ENTREGADO';
      case 'CANCELADO':
        return 'CANCELADO';
      default:
        return '';
    }
  }
}
