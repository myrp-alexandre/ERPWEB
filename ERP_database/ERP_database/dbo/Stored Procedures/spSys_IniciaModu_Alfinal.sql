
-- exec sp_IniciaModu_Alfinal @IdEmpresa=1

CREATE procedure [dbo].[spSys_IniciaModu_Alfinal]
 @IdEmpresa int
as
begin

	delete from tb_sis_Param_Cont_x_Proceso_x_Parametro_x_Sucu 	where IdEmpresa =@IdEmpresa
	delete from dbo.tb_sis_Param_Cont_x_Proceso_x_Parametro_x_Sucu_x_Categoria where IdEmpresa =@IdEmpresa
	delete from dbo.ba_Banco_Cuenta where IdEmpresa=@IdEmpresa
	delete from dbo.caj_Caja_Movimiento where IdEmpresa=@IdEmpresa
	delete from dbo.caj_Caja where IdEmpresa=@IdEmpresa
	delete from dbo.cp_proveedor where IdEmpresa=@IdEmpresa
	delete from dbo.ct_centro_costo where IdEmpresa=@IdEmpresa
	delete from dbo.ct_centro_costo_nivel where IdEmpresa=@IdEmpresa
	delete from dbo.ct_plancta where IdEmpresa=@IdEmpresa
	delete from dbo.ct_plancta_nivel where IdEmpresa=@IdEmpresa
	delete from dbo.ct_centro_costo where IdEmpresa=@IdEmpresa
	delete from dbo.ct_centro_costo_nivel where IdEmpresa=@IdEmpresa
	delete from dbo.tb_transportista where IdEmpresa=@IdEmpresa
	delete from dbo.tb_usuarioxempresa where IdEmpresa =@IdEmpresa
	delete from dbo.tb_bodega where IdEmpresa=@IdEmpresa
	delete from dbo.tb_sucursal  where IdEmpresa=@IdEmpresa
	
	
	
	


end