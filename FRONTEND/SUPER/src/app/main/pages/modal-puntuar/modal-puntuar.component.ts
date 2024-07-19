import { Component, Input, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { NgbActiveModal } from '@ng-bootstrap/ng-bootstrap';
import { ServiciosResourceService } from '../../resources/servicios-resource.service';

interface EvaluacionPonderacion {
  evaluacion: string;
  ponderacion: number;
}

@Component({
  selector: 'app-modal-puntuar',
  templateUrl: './modal-puntuar.component.html',
  styleUrls: ['./modal-puntuar.component.css']
})
export class ModalPuntuarComponent implements OnInit {

  submitted: boolean = false;
  evaluaciones: EvaluacionPonderacion[] = [];
  selectedEvaluacion: EvaluacionPonderacion | null = null;
  form!: FormGroup;
  errorMessage: string = '';

  @Input() pedido: any;

  constructor(
    private _fb: FormBuilder,
    private _activeModal: NgbActiveModal,
    private _service: ServiciosResourceService
  ) {}

  ngOnInit(): void {
    this.initializeForm();
    this.loadEvaluaciones();
  }

  private initializeForm(): void {
    this.form = this._fb.group({
      id_proveedor: [{ value: this.pedido?.id_proveedor, disabled: true }],
      nombre_proveedor: [{ value: this.pedido?.nombre_proveedor, disabled: true }],
      codigo_seguimiento: [{ value: this.pedido?.codigo_seguimiento, disabled: true }],
      evaluacion: [this.pedido?.evaluacion || '', Validators.required],
      ponderacion: [this.pedido?.ponderacion || '', Validators.required]
    });
  }

  private loadEvaluaciones(): void {
    //Solo necesito el id_proveedor del this.pedido
    this._service.obtenerRanking(this.pedido).subscribe({
      next: (data) => {
        console.log(this.pedido);
        this.evaluaciones = data.map((item: any) => ({
          evaluacion: item.evaluacion,
          ponderacion: item.ponderacion
        }));

        // Seleccionar por defecto la evaluación del pedido si está presente
        if (this.pedido.evaluacion && this.pedido.ponderacion) {
          this.selectedEvaluacion = this.evaluaciones.find(
            ev => ev.evaluacion === this.pedido.evaluacion && ev.ponderacion === this.pedido.ponderacion
          ) || null;
        } else if (this.evaluaciones.length > 0) {
          this.selectedEvaluacion = this.evaluaciones[0];
        }
      },
      error: (error) => {
        console.error('Error al cargar las evaluaciones', error);
      }
    });
  }

  ok(): void {
    this.submitted = true;
    if (this.form.valid) {
      // Actualizar el pedido con los valores del formulario
      this.pedido.evaluacion = this.form.get('evaluacion')?.value;
      this.pedido.ponderacion = this.form.get('ponderacion')?.value;

      console.log("this.pedido:", this.pedido);

      this._service.evaluarPedido(this.pedido).subscribe({
        next: (response) => {
          console.log(response);
          console.log("Evaluación exitosa");
          this._activeModal.close();
        },
        error: (error) => {
          console.log(error);
          console.log("Error en la evaluación");
          this.errorMessage = $localize`Error en la evaluación. Por favor, intenta nuevamente.`;
          this.form.reset();
          this.submitted = false;
        }
      });
    }
  }

  close(): void {
    this._activeModal.close();
  }
}
