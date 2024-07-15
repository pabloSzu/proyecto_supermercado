import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ServiciosResourceService } from '../../resources/servicios-resource.service';
import Swal from 'sweetalert2';
import { Router } from '@angular/router';

@Component({
  selector: 'app-alta-proveedor',
  templateUrl: './alta-proveedor.component.html',
  styleUrls: ['./alta-proveedor.component.css']
})
export class AltaProveedorComponent implements OnInit {
  form!: FormGroup;
  formRanking: FormGroup[] = [];
  ranking: any[] = [];
  configuracion: any = {};
  productos: any[] = [];
  ListaProveedores: any[] = [];
  mensajeError: string = '';
  imageUrl: string = '../../assets/splash_vertical.png';
  mostrarRegistrarProveedor: boolean = false;

  constructor(
    private _fb: FormBuilder,
    private _service: ServiciosResourceService,
    private _router: Router
  ) { }

  ngOnInit(): void {
    this.form = this._fb.group({
      nombre_url: ['', Validators.required],
      token: ['', Validators.required]
    });
  }

  onSubmit(): void {
    // Verificar si el nombre_url ya existe en ListaProveedores
    this._service.getProveedores().subscribe({
      next: (proveedores) => {
        this.ListaProveedores = proveedores;
        const nombreUrlExistente = this.ListaProveedores.some(proveedor => proveedor.nombre_url === this.form.value.nombre_url);

        if (nombreUrlExistente) {
          console.log('La URL ya existe en Nuestros Proveedores. Por favor, elija otro.');
          this.mensajeError = 'La URL ya existe en Nuestros Proveedores.';
          return;
        }

        // Continuar con el proceso si el formulario es válido y el nombre URL no existe aún
        if (this.form.valid) {
          this.mensajeError = '';
          this._service.getDatosProveedor(this.form.value).subscribe({
            next: (response) => {
              this.ranking = response.ranking;
              this.configuracion = response.configuracion[0];
              this.mostrarRegistrarProveedor = true;

              // Inicializar formRanking con FormGroup para cada item en ranking
              this.ranking.forEach((item) => {
                this.formRanking.push(this._fb.group({
                  ponderacion: [item.ponderacion, [Validators.required, Validators.min(0), Validators.max(10)]]
                }));
              });

              this._service.getProductosJoin(response.productos).subscribe({
                next: (productosResponse) => {
                  this.productos = productosResponse;
                },
                error: (error) => {
                  console.log("Error al obtener los productos:", error);
                }
              });
            },
            error: (error) => {
              console.log("Error al obtener los datos del proveedor:", error);
              this.mensajeError = 'El nombre URL no existe.';
            }
          });
        }
      },
      error: (error) => {
        console.log("Error al obtener los proveedores:", error);
        this.mensajeError = 'El nombre URL no existe.';
      }
    });
  }










  obtenerImagenBase64(imagen_contenido: string) {
    return `data:image/jpeg;base64,${imagen_contenido}`;
  }

  registrarProveedor(): void {
    let todasPonderacionesValidas = true;
    this.formRanking.forEach((fg) => {
      if (fg.invalid || fg.get('ponderacion')!.value === null) {
        todasPonderacionesValidas = false;
        fg.markAllAsTouched(); // Marcar todos los controles como tocados para mostrar errores
      }
    });

  

    if (todasPonderacionesValidas) {
      const productosSinImagenContenido = this.productos.map(producto => {
        const { imagen_contenido, ...resto } = producto;
        return resto;
      });
  
      const datosRegistro = {
        configuracion: [this.configuracion],
        ranking: this.ranking,
        productos: productosSinImagenContenido
      };
      console.log('Datos de Registro:', JSON.stringify(datosRegistro));
          Swal.fire({
            title: '¿Seguro que deseas agregar al proveedor ?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Sí, agregar proveedor',
            cancelButtonText: 'No, no hacer nada'
          }).then((result) => {
            if (result.isConfirmed) { 
              this._service.insertProveedorNuevo(datosRegistro).subscribe({
              next: (proveedorResponse) => {
              console.log('Datos del proveedor nuevo:', JSON.stringify(proveedorResponse));  
            Swal.fire(
                'Se ha agregado al proveedor',
                'El proveedor  ha sido agregado. ',
                'success'
              );
            this._router.navigate(['main/listado-proveedores']);
            } 
          }
        )
        }
      }
    );
    }
  }
}
