create proc [dbo].[sp_sys_Borrar_tablas_compras]
as
declare @IdEmpresa int
set @IdEmpresa =15

delete [dbo].[com_cotizacion_compra_det] where IdEmpresa=@IdEmpresa
delete [dbo].[com_cotizacion_compra] where IdEmpresa=@IdEmpresa

delete [dbo].[com_dev_compra_det] where IdEmpresa=@IdEmpresa
delete [dbo].[com_dev_compra] where IdEmpresa=@IdEmpresa


delete [dbo].[com_GenerOCompra_Det_x_com_ordencompra_local_det_CusCider] where goc_IdEmpresa=@IdEmpresa
delete [dbo].[com_GenerOCompra_Det] where IdEmpresa=@IdEmpresa
delete [dbo].[com_GenerOCompra] where IdEmpresa=@IdEmpresa


delete [dbo].[com_ListadoMateriales_Det_x_com_GenerOCompra_Det] where go_IdEmpresa=@IdEmpresa
delete [dbo].[com_ListadoMateriales_Det] where IdEmpresa=@IdEmpresa
delete [dbo].[com_ListadoMateriales] where IdEmpresa=@IdEmpresa


delete [dbo].[com_ordencompra_local_det_x_com_solicitud_compra_det] where ocd_IdEmpresa=@IdEmpresa
delete [dbo].[com_solicitud_compra_det_aprobacion] where IdEmpresa=@IdEmpresa
delete [dbo].[com_solicitud_compra_det] where IdEmpresa=@IdEmpresa
delete [dbo].[com_solicitud_compra] where IdEmpresa=@IdEmpresa

delete [dbo].[com_ordencompra_local_det] where IdEmpresa=@IdEmpresa
delete [dbo].[com_ordencompra_local] where IdEmpresa=@IdEmpresa

delete [dbo].[com_comprador] where IdEmpresa=@IdEmpresa


return