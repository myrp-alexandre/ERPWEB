CREATE  procedure [dbo].[spSys_IniciaModu_Com] @IdEmpresa int
as
begin

	delete from dbo.com_ListadoMateriales_Det_x_com_GenerOCompra_Det where go_IdEmpresa=@IdEmpresa
	delete from dbo.com_GenerOCompra_Det_x_com_ordencompra_local_det_CusCider where goc_IdEmpresa=@IdEmpresa
	delete from dbo.com_GenerOCompra_Det where IdEmpresa=@IdEmpresa
	delete from dbo.com_GenerOCompra where IdEmpresa=@IdEmpresa
	delete from dbo.com_ListadoMateriales_Det where IdEmpresa=@IdEmpresa
	delete from dbo.com_ListadoMateriales where IdEmpresa=@IdEmpresa
	delete from dbo.com_ordencompra_local_det where IdEmpresa=@IdEmpresa
	delete from dbo.com_ordencompra_local where IdEmpresa=@IdEmpresa
	delete from dbo.com_TerminoPago 

end