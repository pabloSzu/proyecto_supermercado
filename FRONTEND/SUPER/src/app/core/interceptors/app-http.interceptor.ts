import { HttpEvent, HttpHandler, HttpInterceptor, HttpRequest } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { finalize } from 'rxjs/operators';
import { LoaderService } from '../services/loader.service';

@Injectable()
export class AppHttpInterceptor implements HttpInterceptor {

  constructor(private _loader: LoaderService) { }

  intercept(request: HttpRequest<any>, next: HttpHandler): Observable<HttpEvent<any>> {
    this._loader.start();
    console.log('entro');

    return next.handle(request).pipe(
      finalize(() => this._loader.complete())
    );
  }

}
