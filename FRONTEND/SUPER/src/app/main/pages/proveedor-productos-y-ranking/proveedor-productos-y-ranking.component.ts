import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ServiciosResourceService } from '../../resources/servicios-resource.service';
import Swal from 'sweetalert2';
import { ActivatedRoute, Router } from '@angular/router';

interface EvaluacionPonderacion {
  evaluacion: string;
  ponderacion: number;
}

@Component({
  selector: 'app-proveedor-productos-y-ranking',
  templateUrl: './proveedor-productos-y-ranking.component.html',
  styleUrls: ['./proveedor-productos-y-ranking.component.css']
})
export class ProveedorProductosYRankingComponent implements OnInit {
  form!: FormGroup;
  formRanking: FormGroup[] = [];
  evaluaciones: EvaluacionPonderacion[] = [];
  configuracion: any = {};
  productos: any[] = [];
  ListaProveedores: any[] = [];
  mensajeError: string = '';
  imageUrl: string = '../../assets/splash_vertical.png';
  mostrarRegistrarProveedor: boolean = false;
  proveedor: any;
  idProveedor: string | null = null; // Declarar idProveedor como una propiedad de la clase

  constructor(
    private fb: FormBuilder,
    private service: ServiciosResourceService,
    private router: Router,
    private route: ActivatedRoute
  ) { }

  ngOnInit(): void {
    this.route.paramMap.subscribe(params => {
      this.idProveedor = params.get('idProveedor');
    })
    
    this.loadEvaluaciones();
    this.loadProductos();
    this.loadConfiguracion();
  }

  private loadEvaluaciones(): void {
    if (this.idProveedor) {
      this.service.obtenerRanking({ id_proveedor: this.idProveedor }).subscribe({
        next: (data) => {
          // Ordena los datos por id_ranking
          data.sort((a: any, b: any) => a.id_ranking - b.id_ranking);
          
          this.evaluaciones = data.map((item: any) => ({
            evaluacion: item.evaluacion,
            ponderacion: item.ponderacion
          }));
          this.createFormRanking();
        },
        error: (err) => {
          console.error('Error fetching ranking data', err);
        }
      });
    }
  }

  private loadProductos(): void {
      if (this.idProveedor) {
        this.service.obtenerProductosProveedor({ id_proveedor: this.idProveedor }).subscribe({
          next: (data) => {
            this.productos = data;
            console.log('Productos cargados:', this.productos);
          },
          error: (err) => {
            console.error('Error fetching productos data', err);
          }
        });
      }
  }

  private loadConfiguracion(): void {
      if (this.idProveedor) {
        this.service.getEstadisticaProveedor({ id_proveedor: this.idProveedor }).subscribe({
          next: (data) => {
            this.configuracion = data[0]; // Asigna el primer elemento de data, ya que parece ser un array según tu JSON de ejemplo
            console.log('CONFIGURACION:', this.configuracion); // Asegúrate de que los datos se están recibiendo correctamente
          },
          error: (err) => {
            console.error('Error fetching configuracion data', err);
          }
        });
      }
  }

  private createFormRanking(): void {
    this.formRanking = this.evaluaciones.map((item) => this.fb.group({
      ponderacion: [item.ponderacion, [Validators.required, Validators.min(0), Validators.max(10)]]
    }));
  }


  onChangePonderacion(item: any, index: number) {
    const json = {
      id_proveedor: this.idProveedor, // Usar this.idProveedor en lugar de item.id_proveedor
      evaluacion: item.evaluacion,
      ponderacion: this.formRanking[index].get('ponderacion')!.value
    };

    if (this.idProveedor) {
      this.service.updatePonderacion(json).subscribe({
        next: () => {
          Swal.fire({
            icon: 'success',
            title: 'Ponderación actualizada',
            text: 'La ponderación ha sido actualizada correctamente.'
          });
        },
        error: (err) => {
          Swal.fire({
            icon: 'error',
            title: 'Error',
            text: 'Hubo un error al actualizar la ponderación. Inténtelo de nuevo más tarde.'
          });
          console.error('Error updating ponderacion data', err);
        }
      });
    }
  }





  obtenerImagenBase64(imagen_contenido: string) {
    // Convierte la cadena Base64 a URL
    return `data:image/jpeg;base64,${imagen_contenido}`;
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
