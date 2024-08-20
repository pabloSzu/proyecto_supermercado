import { Component, Input } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { ServiciosResourceService } from '../../resources/servicios-resource.service';
import { NgbActiveModal } from '@ng-bootstrap/ng-bootstrap';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-modal-cancelar',
  templateUrl: './modal-cancelar.component.html',
  styleUrls: ['./modal-cancelar.component.css']
})
export class ModalCancelarComponent {

  form!: FormGroup;
  errorMessage: string = '';
  submitted: boolean = false;

  @Input() pedido: any;
  
  constructor(
    private _fb: FormBuilder,
    private _activeModal: NgbActiveModal,
    private _service: ServiciosResourceService
  ) {}

  ngOnInit(): void {
    this.initializeForm();
  }


  private initializeForm(): void {
    this.form = this._fb.group({
      id_proveedor: [{ value: this.pedido?.id_proveedor, disabled: true }],
      nombre_proveedor: [{ value: this.pedido?.nombre_proveedor, disabled: true }],
      codigo_seguimiento: [{ value: this.pedido?.codigo_seguimiento, disabled: true }],
      motivo_cancelacion: [this.pedido?.motivo_cancelacion || '']
    });
  }

  ok(): void {
    this.submitted = true;
    if (this.form.valid) {
      // Actualizar el pedido con los valores del formulario
      this.pedido.motivo_cancelacion = this.form.get('motivo_cancelacion')?.value;

      console.log("this.pedido:", this.pedido);


      Swal.fire({
        title: $localize`¿Seguro que deseas cancelar el pedido '` + this.pedido["codigo_seguimiento"] + `' ?`,
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: $localize`Sí, cancelar pedido`,
        cancelButtonText: $localize`No, mantener pedido`
      }).then((result) => {
        if (result.isConfirmed) {
          this._service.cancelarPedido(this.pedido).subscribe({
            next: (response) => {
              console.log(response);
              console.log("Pedido cancelado");
              Swal.fire(
                $localize`Cancelado!`,
                $localize`El pedido '` + this.pedido["codigo_seguimiento"] + `' ha sido cancelado. `,
                'success'
              );
              this._activeModal.close();
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
  }

  close(): void {
    this._activeModal.close();
  }
}
