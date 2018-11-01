
-- exec [dbo].[sp_IniciaModu_pre] @IdEmpresa=1
CREATE  procedure [dbo].[spSys_IniciaModu_pre]
 @IdEmpresa int
as
begin

	delete from dbo.pre_presupuestoData where IdEmpresa=@IdEmpresa
	delete from dbo.pre_ordencompra_local_det where IdEmpresa=@IdEmpresa
	delete from dbo.pre_ordencompra_local where IdEmpresa=@IdEmpresa
	delete from dbo.pre_PedidoXPresupuesto_det where IdEmpresa=@IdEmpresa
	delete from dbo.pre_PedidoXPresupuesto where IdEmpresa=@IdEmpresa
	delete from dbo.pre_presupuesto where IdEmpresa=@IdEmpresa
	delete from dbo.pre_presupuestoData where IdEmpresa=@IdEmpresa
	


end