CREATE procedure [dbo].[spSys_IniciaModu_fa] @IdEmpresa int
as
begin

	delete from dbo.fa_parametro where IdEmpresa=@IdEmpresa
	delete from dbo.fa_cotizacion_det where IdEmpresa=@IdEmpresa
	delete from dbo.fa_devol_venta_det where IdEmpresa=@IdEmpresa
	delete from dbo.fa_factura_det where IdEmpresa=@IdEmpresa
	delete from dbo.fa_guia_remision_det_x_fa_orden_Desp_det where gi_IdEmpresa=@IdEmpresa
	delete from dbo.fa_orden_Desp_det_x_fa_pedido_det where od_IdEmpresa=@IdEmpresa
	delete from dbo.fa_guia_remision_det where IdEmpresa=@IdEmpresa
	delete from dbo.fa_notaCreDeb_det where IdEmpresa=@IdEmpresa
	delete from dbo.fa_orden_Desp_det where IdEmpresa=@IdEmpresa
	delete from dbo.fa_pedido_det where IdEmpresa=@IdEmpresa
	delete from dbo.fa_cliente where IdEmpresa=@IdEmpresa
	delete from dbo.fa_cotizacion where IdEmpresa=@IdEmpresa
	delete from dbo.fa_devol_venta where IdEmpresa=@IdEmpresa
	delete from dbo.fa_guia_remision_x_prd_Despacho where IdEmpresa_guia =@IdEmpresa
	delete from dbo.fa_notaCreDeb_x_ct_cbtecble where no_IdEmpresa=@IdEmpresa
	delete from dbo.fa_factura_x_ct_cbtecble where vt_IdEmpresa=@IdEmpresa
	delete from dbo.fa_factura_x_fa_cotizacion where fa_IdEmpresa=@IdEmpresa
	delete from dbo.fa_factura_x_fa_guia_remision where fa_IdEmpresa=@IdEmpresa
	delete from dbo.fa_guia_remision where IdEmpresa=@IdEmpresa
	delete from dbo.fa_pedido where IdEmpresa=@IdEmpresa
	delete from dbo.fa_factura where IdEmpresa=@IdEmpresa
	delete from dbo.fa_notaCreDeb where IdEmpresa=@IdEmpresa
	delete from dbo.fa_orden_Desp where IdEmpresa=@IdEmpresa
	delete from dbo.fa_TipoNota_x_Empresa_x_Sucursal where IdEmpresa=@IdEmpresa
	delete from dbo.fa_vendedor_x_ro_empleado where IdEmpresa=@IdEmpresa
	delete from dbo.fa_VendedorxSucursal where IdEmpresa=@IdEmpresa
	delete from dbo.fa_Vendedor where IdEmpresa=@IdEmpresa

end