CREATE  procedure [dbo].[spSys_IniciaModu_Caja] @IdEmpresa int
as
begin

	
	delete from dbo.caj_parametro where IdEmpresa=@IdEmpresa
	delete from dbo.caj_Caja_Movimiento_Tipo_x_CtaCble where IdEmpresa=@IdEmpresa
	delete from dbo.caj_Caja_Movimiento_det where IdEmpresa=@IdEmpresa
	--delete from dbo.caj_Caja_Movimiento where IdEmpresa=@IdEmpresa
	--delete from dbo.caj_Caja_Movimiento_Tipo 
	--delete from dbo.caj_Caja where IdEmpresa=@IdEmpresa

end