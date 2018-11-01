CREATE procedure [dbo].[spSys_IniciaModu_CXC] @IdEmpresa int
as
begin

	delete from dbo.cxc_Parametro where IdEmpresa=@IdEmpresa
	delete from dbo.cxc_Parametros_x_cheqProtesto where IdEmpresa=@IdEmpresa
	delete from dbo.cxc_cobro_x_EstadoCobro where IdEmpresa=@IdEmpresa
	delete from dbo.cxc_cobro_det where IdEmpresa=@IdEmpresa
	
	delete from dbo.cxc_cobro_x_caj_Caja_Movimiento where cbr_IdEmpresa=@IdEmpresa
	delete from dbo.cxc_cobro_tipo_Param_conta_x_sucursal where IdEmpresa=@IdEmpresa
	delete from dbo.cxc_cobro_tipo_x_Retencion where IdEmpresa=@IdEmpresa
	delete from dbo.cxc_cobro_x_ct_cbtecble where cbr_IdEmpresa=@IdEmpresa
	delete from dbo.cxc_cobro where IdEmpresa=@IdEmpresa
	delete from dbo.cxc_EstadoCobro
	--delete from dbo.cxc_cobro_tipo

end