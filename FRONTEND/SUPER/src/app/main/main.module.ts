import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { MainComponent } from './main.component';
import { LoginComponent } from './pages/login/login.component';
import { MainRoutingModule } from './main-routing.module';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { ServiciosResourceService } from './resources/servicios-resource.service'; // Asegúrate de que la ruta sea correcta
import { SplashComponent } from './pages/splash/splash.component';
import { ListadoPedidosComponent } from './pages/listado-pedidos/listado-pedidos.component';
import { ListadoProveedoresComponent } from './pages/listado-proveedores/listado-proveedores.component';
import { ModalPuntuarComponent } from './pages/modal-puntuar/modal-puntuar.component';
import { ProveedorComponent } from './pages/proveedor/proveedor.component';
import { DetallePedidoComponent } from './pages/detalle_pedido/detalle_pedido.component';
import { AltaProveedorComponent } from './pages/alta-proveedor/alta-proveedor.component';
import { SearchPedidosPipe } from './pipe/search-pedidos.pipe';
import { SearchPedidosCodigoEstadoPipe } from './pipe/search-pedidos-codigo-estado.pipe';
import { ProveedorProductosYRankingComponent } from './pages/proveedor-productos-y-ranking/proveedor-productos-y-ranking.component';

@NgModule({
  declarations: [
    MainComponent,
    LoginComponent,
    SplashComponent,
    ListadoPedidosComponent,
    ModalPuntuarComponent,
    ProveedorComponent,
    ListadoProveedoresComponent,
    DetallePedidoComponent,
    AltaProveedorComponent,
    SearchPedidosPipe,
    SearchPedidosCodigoEstadoPipe,
    ProveedorProductosYRankingComponent
  ],
  imports: [
    CommonModule,
    MainRoutingModule,
    FormsModule,
    ReactiveFormsModule
  ],
  providers: [
    ServiciosResourceService
  ],
  exports: [
    SearchPedidosPipe,
    SearchPedidosCodigoEstadoPipe
  ]
})
export class MainModule { }
