
-- exec [dbo].[sp_IniciaModu_imp] @IdEmpresa =1

CREATE procedure [dbo].[spSys_IniciaModu_imp] @IdEmpresa int
as
begin
	
	delete from dbo.imp_gastosxImport_x_Empresa where IdEmpresa=@IdEmpresa
	
	
	-- 
	delete from dbo.imp_ordencompra_ext_det where IdEmpresa=@IdEmpresa
	delete from dbo.imp_ordencompra_ext_x_imp_gastosxImport_det where IdEmpresa=@IdEmpresa
	delete from dbo.imp_ordencompra_ext_x_Condiciones_Pago where IdEmpresa=@IdEmpresa
	delete from dbo.imp_ordencompra_ext_x_ct_cbtecble where imp_IdEmpresa=@IdEmpresa
	delete from dbo.imp_ordencompra_ext_x_imp_gastosxImport where IdEmpresa=@IdEmpresa
	delete from dbo.imp_DatosEmbarque where IdEmpresa=@IdEmpresa
	delete from dbo.imp_Tipo_docu_pago_x_Empresa_x_tipocbte where IdEmpresa=@IdEmpresa

	delete from dbo.imp_ordencompra_ext where IdEmpresa=@IdEmpresa
	delete from dbo.imp_Parametros where IdEmpresa=@IdEmpresa
	delete from dbo.imp_Tipo_docu_pago
	delete from dbo.imp_Embarcador
	

end