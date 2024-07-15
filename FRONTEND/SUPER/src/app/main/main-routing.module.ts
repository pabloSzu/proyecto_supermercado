import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { MainComponent } from './main.component';
import { LoginComponent } from './pages/login/login.component';
import { SplashComponent } from './pages/splash/splash.component';
import { ListadoPedidosComponent } from './pages/listado-pedidos/listado-pedidos.component';
import { ListadoProveedoresComponent } from './pages/listado-proveedores/listado-proveedores.component';
import { pedidosResolver } from './resolvers/pedidos-resolver.service';
import { ProveedorComponent } from './pages/proveedor/proveedor.component';
import { DetallePedidoComponent } from './pages/detalle_pedido/detalle_pedido.component';
import { pedidosProveedorResolver } from './resolvers/pedidos-proveedor-resolver.service';
import { estadisticaProveedorResolver } from './resolvers/estadistica-proveedor-resolver.service';
import { proveedoresResolver } from './resolvers/proveedores-resolver.service';
import { detallePedidoResolver } from './resolvers/detalle-pedido-resolver.service';
import { AltaProveedorComponent } from './pages/alta-proveedor/alta-proveedor.component';
import { ProveedorProductosYRankingComponent } from './pages/proveedor-productos-y-ranking/proveedor-productos-y-ranking.component';


const routes: Routes = [
  { path: '', component: MainComponent, children: [
    { path: '', component: SplashComponent },
    { path: 'login',  component: LoginComponent },
    { path: 'alta-proveedor',  component: AltaProveedorComponent },
    { path: 'listado-pedidos',  resolve: { pedidos: pedidosResolver }, component: ListadoPedidosComponent},
    { path: 'listado-proveedores',  resolve: { proveedores: proveedoresResolver }, component: ListadoProveedoresComponent},
    { path: 'proveedor/:idProveedor', resolve: { pedidos: pedidosProveedorResolver, estadistica: estadisticaProveedorResolver }, component: ProveedorComponent},
    { path: 'proveedor_productos_y_ranking/:idProveedor', component: ProveedorProductosYRankingComponent},
    { path: 'detalle_pedido/:idPedido', resolve: { productos: detallePedidoResolver}, component: DetallePedidoComponent},
  ] }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class MainRoutingModule { }
