import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { LoaderComponent } from './layout/loader/loader.component';
import { MessageDialogComponent } from './layout/message-dialog/message-dialog.component';
import { AppMessageService } from './services/app-message.service';
import { NgbModalModule } from '@ng-bootstrap/ng-bootstrap';


@NgModule({
  declarations: [
    MessageDialogComponent,
    LoaderComponent
  ],
  imports: [
    CommonModule,
    NgbModalModule
  ],
  providers: [
    AppMessageService
  ],
  exports: [
    LoaderComponent
  ]
})
export class CoreModule { }