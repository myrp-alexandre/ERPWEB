--exec [spCXP_eliminar_factura_vale_conciliacion_caja] 2,7,6,'FACTURA',1
CREATE PROCEDURE [dbo].[spCXP_eliminar_factura_vale_conciliacion_caja]
@IdEmpresa int,
@IdTipoCbte int,
@IdCbteCble numeric,
@TipoCbte_conci varchar(20), --VALE O FACTURA
@Borrar_o_desvincular bit --1 para borrar 0 para desvincular
AS
BEGIN
DECLARE @Mensaje_respuesta varchar(200)
/*
SET @IdEmpresa = 1
SET @IdTipoCbte = 24
SET @IdCbteCble = 1
SET @Borrar_o_desvincular = 1
SET @TipoCbte_conci = 'VALE'
*/
IF(@TipoCbte_conci = 'FACTURA')
	BEGIN
		IF(@Borrar_o_desvincular = 1)
			BEGIN
				DECLARE @Pago_retencion int
				SELECT @Pago_retencion = count(*) FROM cp_orden_pago_cancelaciones where IdEmpresa_cxp =  @IdEmpresa and IdTipoCbte_cxp = @IdTipoCbte and IdCbteCble_cxp = @IdCbteCble

				IF(@Pago_retencion > 0)
					BEGIN
						SET @Mensaje_respuesta = 'LA FACTURA TIENE PAGOS'
					END
				ELSE
					BEGIN
						SELECT @Pago_retencion = count(*) FROM cp_retencion where IdEmpresa_Ogiro = @IdEmpresa and IdTipoCbte_Ogiro = @IdTipoCbte and IdCbteCble_Ogiro = @IdCbteCble
						IF(@Pago_retencion > 0)
							BEGIN
								SET @Mensaje_respuesta = 'LA FACTURA TIENE RETENCION'
							END
						ELSE
							BEGIN

								delete cp_conciliacion_Caja_det where IdEmpresa_OGiro = @IdEmpresa and IdTipoCbte_Ogiro = @IdTipoCbte and IdCbteCble_Ogiro = @IdCbteCble
								delete cp_orden_giro where IdEmpresa = @IdEmpresa and IdTipoCbte_Ogiro = @IdTipoCbte and IdCbteCble_Ogiro = @IdCbteCble
								DELETE cp_orden_giro_pagos_sri WHERE IdEmpresa = @IdEmpresa AND IdTipoCbte_Ogiro = @IdTipoCbte AND IdCbteCble_Ogiro = @IdCbteCble
								delete ct_cbtecble_det where IdEmpresa = @IdEmpresa and IdTipoCbte = @IdTipoCbte and IdCbteCble = @IdCbteCble
								delete ct_cbtecble where IdEmpresa = @IdEmpresa and IdTipoCbte = @IdTipoCbte and IdCbteCble = @IdCbteCble

								SET @Mensaje_respuesta = 'factura # '+ cast(@IdCbteCble as varchar(20))+' eliminada exitosamente'
							END
					END
			END
		ELSE
			BEGIN
				delete cp_conciliacion_Caja_det where IdEmpresa_OGiro = @IdEmpresa and IdTipoCbte_Ogiro = @IdTipoCbte and IdCbteCble_Ogiro = @IdCbteCble
				SET @Mensaje_respuesta = 'factura # '+cast(@IdCbteCble as varchar(20))+' desvinculada exitosamente'
			END
	END
ELSE
	IF(@TipoCbte_conci = 'VALE')
	BEGIN
		IF(@Borrar_o_desvincular = 1)
			BEGIN
				DELETE cp_conciliacion_Caja_det_x_ValeCaja where IdEmpresa_movcaja = @IdEmpresa and IdTipocbte_movcaja = @IdTipoCbte and IdCbteCble_movcaja = @IdCbteCble
				DELETE caj_Caja_Movimiento_det where IdEmpresa = @IdEmpresa and IdTipoCbte = @IdTipoCbte and IdCbteCble = @IdCbteCble
				DELETE caj_Caja_Movimiento where IdEmpresa = @IdEmpresa and IdTipoCbte = @IdTipoCbte and IdCbteCble = @IdCbteCble
				DELETE ct_cbtecble_det where IdEmpresa = @IdEmpresa and IdTipoCbte = @IdTipoCbte and IdCbteCble = @IdCbteCble
				DELETE ct_cbtecble where IdEmpresa = @IdEmpresa and IdTipoCbte = @IdTipoCbte and IdCbteCble = @IdCbteCble
				SET @Mensaje_respuesta = 'Vale de caja # '+cast(@IdCbteCble as varchar(20))+' eliminado exitosamente'
			END
		ELSE
			BEGIN
				DELETE cp_conciliacion_Caja_det_x_ValeCaja where IdEmpresa_movcaja = @IdEmpresa and IdTipocbte_movcaja = @IdTipoCbte and IdCbteCble_movcaja = @IdCbteCble
				SET @Mensaje_respuesta = 'Vale de caja # '+cast(@IdCbteCble as varchar(20))+' desvinculado exitosamente'
			END
	END

SELECT @Mensaje_respuesta AS Respuesta from tb_empresa
END