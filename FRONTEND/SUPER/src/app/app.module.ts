import { ErrorHandler, NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { AppErrorHandler } from './core/handlers/app-error-handler';
import { HttpClientModule, HTTP_INTERCEPTORS } from '@angular/common/http';

import { ResourceModule } from '@ngx-resource/handler-ngx-http';
import { CoreModule } from './core/core.module';
import { AppHttpInterceptor } from './core/interceptors/app-http.interceptor';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { FormsModule } from '@angular/forms';

@NgModule({
  declarations: [
    AppComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    CoreModule,
    HttpClientModule,
    ResourceModule.forRoot(),
    BrowserAnimationsModule,
    FormsModule
  ],
  providers: [
    { provide: HTTP_INTERCEPTORS, useClass: AppHttpInterceptor, multi: true },
    { provide: ErrorHandler, useClass: AppErrorHandler }
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
