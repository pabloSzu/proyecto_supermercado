import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ServiciosResourceService } from '../../resources/servicios-resource.service';
import { Router } from '@angular/router';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit {

  form!: FormGroup;
  submitted: boolean = false;   
  errorMessage: string = '';

  constructor(
    private _service: ServiciosResourceService, 
    private _fb: FormBuilder,
    private _router: Router
  ) {}

  ngOnInit(): void {
    this.initForm();
  }

  loginUsuario(): void {
    this.submitted = true;
    this.errorMessage = '';
    if (this.form.valid) {
      const { ...formData } = this.form.value;
      console.log(" formdata ", JSON.stringify(formData));
      this._service.loginUsuario(formData).subscribe({
        next: (response) => {
          console.log(response);
          console.log("Login exitoso");
          this._router.navigate(['main/listado-pedidos']);
        },
        error: (error) => {
          console.log(error);
          console.log("Autenticacion fallida");
          this.errorMessage = $localize`Autenticación fallida. Por favor, verifica tus credenciales.`;
          this.form.reset();
          this.submitted = false;
        }
      });
    }
  }

  private initForm(): void {
    this.form = this._fb.group({ 
      usuario: ['', [Validators.required, Validators.maxLength(32)]],
      clave: ['', [Validators.required, Validators.maxLength(32)]],
    });
  }
}
