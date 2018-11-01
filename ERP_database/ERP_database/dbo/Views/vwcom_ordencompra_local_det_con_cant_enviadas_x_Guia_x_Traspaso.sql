
create view [dbo].[vwcom_ordencompra_local_det_con_cant_enviadas_x_Guia_x_Traspaso]
as
select A.IdEmpresa_OC,A.IdSucursal_OC,A.IdOrdenCompra_OC,A.Secuencia_OC,sum(A.Cantidad_enviar) as Cantidad_enviar
				from in_Guia_x_traspaso_bodega_det A
				group by A.IdEmpresa_OC,A.IdSucursal_OC,A.IdOrdenCompra_OC,A.Secuencia_OC