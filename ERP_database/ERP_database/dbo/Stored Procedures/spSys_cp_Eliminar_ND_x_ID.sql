--EXEC [dbo].[spSys_cp_Eliminar_ND_x_ID] 1,10,49,0
CREATE PROCEDURE [dbo].[spSys_cp_Eliminar_ND_x_ID]
(
@IdEmpresa int, @IdTipoCbte int, @IdCbteCble numeric, @Borrar bit
)
AS
BEGIN
/*
SET @IdEmpresa = 1
SET @IdTipoCbte = 10
SET @IdCbteCble = 8
SET @Borrar = 0
*/
DECLARE @IdOrdenPago numeric
DECLARE @Contador int

SELECT  @Contador = count(IdEmpresa) FROM cp_nota_DebCre where IdEmpresa = @IdEmpresa and IdTipoCbte_Nota = @IdTipoCbte and IdCbteCble_Nota = @IdCbteCble
SET @Contador = ISNULL(@Contador,0)
IF(@Contador = 0)
	BEGIN
		SELECT 'NO EXISTE EL DOCUMENTO INGRESADO'	
	END
ELSE
	BEGIN
		SELECT @Contador = COUNT(IdEmpresa) FROM cp_orden_pago_cancelaciones WHERE IdEmpresa_cxp = @IdEmpresa AND IdTipoCbte_cxp = @IdTipoCbte AND IdCbteCble_cxp = @IdCbteCble
		SET @Contador = ISNULL(@Contador,0)
		IF(@Contador = 0)
			BEGIN
				SELECT @Contador = COUNT(IdEmpresa) FROM cp_orden_pago_det where IdEmpresa_cxp = @IdEmpresa and IdTipoCbte_cxp = @IdTipoCbte and IdCbteCble_cxp = @IdCbteCble
				SET @Contador = ISNULL(@Contador,0)
				IF(@Contador <= 1)
					BEGIN						
						SELECT @Contador = count(IdEmpresa) FROM ct_cbtecble_Reversado where IdEmpresa = @IdEmpresa and IdTipoCbte = @IdTipoCbte and IdCbteCble = @IdCbteCble
						SET @Contador = ISNULL(@Contador,0)
						IF(@Contador = 0)
							BEGIN
								IF(@Borrar = 0)
									BEGIN
										SELECT * FROM cp_nota_DebCre WHERE IdEmpresa = @IdEmpresa AND IdTipoCbte_Nota = @IdTipoCbte AND IdCbteCble_Nota = @IdCbteCble
										SELECT @IdOrdenPago = IdOrdenPago FROM cp_orden_pago_det where IdEmpresa_cxp = @IdEmpresa and IdTipoCbte_cxp = @IdTipoCbte and IdCbteCble_cxp = @IdCbteCble
										SELECT * FROM cp_Aprobacion_Orden_pago_det where IdEmpresa_OP = @IdEmpresa and IdOrdenPago_OP = @IdOrdenPago
										SELECT * FROM cp_orden_pago_det where IdEmpresa_cxp = @IdEmpresa and IdTipoCbte_cxp = @IdTipoCbte and IdCbteCble_cxp = @IdCbteCble
										SELECT * FROM cp_orden_pago where IdEmpresa = @IdEmpresa and IdOrdenPago = @IdOrdenPago
										SELECT * FROM ct_cbtecble_det where IdEmpresa = @IdEmpresa and IdTipoCbte = @IdTipoCbte and IdCbteCble = @IdCbteCble
										SELECT * FROM ct_cbtecble where IdEmpresa = @IdEmpresa and IdTipoCbte = @IdTipoCbte and IdCbteCble = @IdCbteCble
									END
								ELSE
									BEGIN								
										DELETE cp_nota_DebCre WHERE IdEmpresa = @IdEmpresa AND IdTipoCbte_Nota = @IdTipoCbte AND IdCbteCble_Nota = @IdCbteCble								
										SELECT @IdOrdenPago = IdOrdenPago FROM cp_orden_pago_det where IdEmpresa_cxp = @IdEmpresa and IdTipoCbte_cxp = @IdTipoCbte and IdCbteCble_cxp = @IdCbteCble
										DELETE cp_Aprobacion_Orden_pago_det where IdEmpresa_OP = @IdEmpresa and IdOrdenPago_OP = @IdOrdenPago
										DELETE cp_orden_pago_det where IdEmpresa_cxp = @IdEmpresa and IdTipoCbte_cxp = @IdTipoCbte and IdCbteCble_cxp = @IdCbteCble
										DELETE cp_orden_pago where IdEmpresa = @IdEmpresa and IdOrdenPago = @IdOrdenPago
										DELETE ct_cbtecble_det where IdEmpresa = @IdEmpresa and IdTipoCbte = @IdTipoCbte and IdCbteCble = @IdCbteCble
										DELETE ct_cbtecble where IdEmpresa = @IdEmpresa and IdTipoCbte = @IdTipoCbte and IdCbteCble = @IdCbteCble
									END
							END
						ELSE
							BEGIN
								SELECT 'EL DOCUMENTO TIENE ANULACIONES'
							END
					END
				ELSE
					BEGIN
						SELECT 'EL DOCUMENTO TIENE VARIAS OP VINCULADAS'
					END
			END
		ELSE
			BEGIN
				SELECT 'EL DOCUMENTO TIENE CANCELACIONES'
			END
	END

END