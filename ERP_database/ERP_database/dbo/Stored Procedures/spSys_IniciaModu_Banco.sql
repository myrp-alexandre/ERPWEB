
--exec [dbo].[sp_IniciaModu_Banco] @IdEmpresa =6

CREATE procedure [dbo].[spSys_IniciaModu_Banco] @IdEmpresa int
as
begin

	delete from dbo.ba_parametros where IdEmpresa=@IdEmpresa
	delete from dbo.ba_transferencia where IdEmpresa_origen=@IdEmpresa
	delete from dbo.ba_Config_Diseno_Cheque where IdEmpresa=@IdEmpresa
	delete from dbo.ba_IngrEgre_x_Cbte_depos where IdEmpresa=@IdEmpresa
	delete from dbo.ba_Conciliacion_det_no_conciliado where IdEmpresa=@IdEmpresa
	delete from dbo.ba_Conciliacion_det_IngEgr where IdEmpresa=@IdEmpresa
	delete from dbo.ba_Conciliacion where IdEmpresa=@IdEmpresa
	delete from dbo.ba_Cbte_Ban_tipo_x_ct_CbteCble_tipo where IdEmpresa=@IdEmpresa
	delete from dbo.ba_Caja_Movimiento_x_Cbte_Ban_x_Deposito where mcj_IdEmpresa =@IdEmpresa
	delete from dbo.ba_Cbte_Ban where IdEmpresa=@IdEmpresa
end