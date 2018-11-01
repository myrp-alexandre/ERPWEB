
-- exec [dbo].[sp_IniciaModu_Cot] @IdEmpresa =6


CREATE procedure [dbo].[spSys_IniciaModu_Conta] @IdEmpresa int
as
begin

	delete from dbo.ct_cbtecble_det where IdEmpresa=@IdEmpresa
	delete from dbo.ct_cbtecble where IdEmpresa=@IdEmpresa
	delete from dbo.ct_cbtecble_Plantilla_det where IdEmpresa=@IdEmpresa
	delete from dbo.ct_cbtecble_Plantilla where IdEmpresa=@IdEmpresa
	delete from dbo.ct_cbtecble_Reversado where IdEmpresa=@IdEmpresa
	--delete from dbo.ct_cbtecble_tipo_x_empresa where IdEmpresa=@IdEmpresa
	
	
	
	
	delete from dbo.ct_GrupoEmpresarial_plancta_x_ct_plancta where IdEmpresa=@IdEmpresa
	delete from dbo.ct_GrupoEmpresarial_plancta_nivel
	delete from dbo.ct_GrupoEmpresarial_grupocble
	delete from dbo.ct_GrupoEmpresarial_plancta
	delete from dbo.ct_GrupoEmpresarial
	delete from dbo.ct_rpt_Empresas_A_mostrar where IdEmpresa=@IdEmpresa
	delete from dbo.ct_rpt_MovxCta where IdEmpresa=@IdEmpresa
	delete from dbo.ct_rpt_SaldoxCta where IdEmpresa=@IdEmpresa
	delete from dbo.ct_saldoxCuentas where IdEmpresa=@IdEmpresa
	delete from dbo.ct_saldoxCuentas_Movi where IdEmpresa=@IdEmpresa

	
	
	delete from dbo.ct_centro_costo where IdEmpresa=@IdEmpresa
	delete from dbo.ct_centro_costo_nivel where IdEmpresa=@IdEmpresa
	delete from dbo.ct_plancta where IdEmpresa=@IdEmpresa
	delete from dbo.ct_plancta_nivel where IdEmpresa=@IdEmpresa
	
	
	
end