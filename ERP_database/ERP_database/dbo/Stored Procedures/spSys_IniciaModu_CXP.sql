-- EXEC [dbo].[sp_IniciaModu_CXP] 3
CREATE  procedure [dbo].[spSys_IniciaModu_CXP]
 @IdEmpresa int
as
begin

	
	delete from dbo.cp_codigo_SRI_x_CtaCble where IdEmpresa=@IdEmpresa
	delete from dbo.cp_Conciliacion_Caja where IdEmpresa=@IdEmpresa
	delete from dbo.cp_nota_credito where IdEmpresa=@IdEmpresa
	delete from dbo.cp_orden_giro_pagos where IdEmpresa_Og =@IdEmpresa
	delete from dbo.cp_orden_giro_x_imp_ordencompra_ext where og_IdEmpresa=@IdEmpresa
	delete from dbo.cp_parametros where IdEmpresa=@IdEmpresa
	delete from dbo.cp_proveedor_Autorizacion where IdEmpresa=@IdEmpresa
	delete from dbo.cp_proveedor_codigo_SRI where IdEmpresa=@IdEmpresa
	delete from dbo.cp_retencion where IdEmpresa=@IdEmpresa
	delete from dbo.cp_orden_giro where IdEmpresa=@IdEmpresa
	--delete from dbo.cp_proveedor where IdEmpresa=@IdEmpresa

end