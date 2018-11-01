-- exec [dbo].[spSys_cp_Eliminar_ND_NC] 1,10,156,0
CREATE PROCEDURE [dbo].[spSys_cp_Eliminar_ND_NC]
(
@IdEmpresa int,
@IdTipoCbte int,
@IdCbteCble numeric,
@Borrar bit
)
AS
BEGIN

DECLARE @Contador numeric
/*
if(@Borrar = 0)
	BEGIN
	select @Contador = count(IdEmpresa) from cp_orden_pago_det where IdEmpresa_cxp = @IdEmpresa and IdTipoCbte_cxp = @IdTipoCbte and IdCbteCble_cxp = @IdCbteCble
	set @Contador = isnull(@Contador,0)
		if(@Contador > 0)
		BEGIN
			SELECT 'LA ND#'+ cast( @IdCbteCble as varchar(20))+' TIENE OP RELACIONADA'
		END
		ELSE
		BEGIN
			select * from vwcp_nota_DebCre_total_saldo where IdEmpresa = @IdEmpresa and IdTipoCbte_Nota = @IdTipoCbte and IdCbteCble_Nota = @IdCbteCble
			select cp_proveedor.pr_nombre, cp_nota_DebCre.* from  cp_nota_DebCre inner join cp_proveedor on cp_nota_DebCre.IdEmpresa = cp_proveedor.IdEmpresa
			and cp_nota_DebCre.IdProveedor = cp_proveedor.IdProveedor
			where cp_nota_DebCre.IdEmpresa = @IdEmpresa and IdTipoCbte_Nota = @IdTipoCbte and IdCbteCble_Nota = @IdCbteCble
			select * from ct_cbtecble_det where IdEmpresa = @IdEmpresa and IdTipoCbte = @IdTipoCbte and IdCbteCble = @IdCbteCble
			select * from ct_cbtecble where IdEmpresa = @IdEmpresa and IdTipoCbte = @IdTipoCbte and IdCbteCble = @IdCbteCble
		END
	END
ELSE
	BEGIN	
	select @Contador = count(IdEmpresa) from cp_orden_pago_det where IdEmpresa_cxp = @IdEmpresa and IdTipoCbte_cxp = @IdTipoCbte and IdCbteCble_cxp = @IdCbteCble
	set @Contador = isnull(@Contador,0)
	IF(@Contador = 0)
	BEGIN
		delete cp_nota_DebCre where IdEmpresa = @IdEmpresa and IdTipoCbte_Nota = @IdTipoCbte and IdCbteCble_Nota = @IdCbteCble
		delete ct_cbtecble_det where IdEmpresa = @IdEmpresa and IdTipoCbte = @IdTipoCbte and IdCbteCble = @IdCbteCble
		delete ct_cbtecble where IdEmpresa = @IdEmpresa and IdTipoCbte = @IdTipoCbte and IdCbteCble = @IdCbteCble
	END
	END
	*/
END