import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { ServiciosResourceService } from '../../resources/servicios-resource.service';

@Component({
  selector: 'app-listado-proveedores',
  templateUrl: './listado-proveedores.component.html',
  styleUrls: ['./listado-proveedores.component.css']
})
export class ListadoProveedoresComponent implements OnInit {

  imageUrl: string = '../../assets/splash_vertical.png';
  proveedores: any[] = [];

  constructor(private route: ActivatedRoute,
              private _service: ServiciosResourceService) { }

  ngOnInit(): void {
    this.route.data.subscribe(data => {
      this.proveedores = data['proveedores'];
    });
  }

  toggleHabilitado(proveedor: any): void {
    const updatedProveedor = {
      id_proveedor: proveedor.id_proveedor,
      habilitado: !proveedor.habilitado
    };

    this._service.altabajaProveedor([updatedProveedor]).subscribe({
      next: (response) => {
        console.log(response);
        console.log("Alta/Baja exitosa");
        proveedor.habilitado = !proveedor.habilitado; // Solo actualizar si el request fue exitoso
        this.actualizarProveedores();
      },
      error: (error) => {
        console.log(error);
        console.log("Error en Alta/Baja");
      }
    });
  }

  actualizarProveedores(): void {
    this._service.getProveedores().subscribe({
      next: (proveedores) => {
        this.proveedores = proveedores;
      },
      error: (error) => {
        console.log("Error al actualizar los proveedores", error);
      }
    });
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
}
