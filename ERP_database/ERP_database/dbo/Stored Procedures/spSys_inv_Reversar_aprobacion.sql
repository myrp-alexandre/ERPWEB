--exec  [dbo].[spSys_inv_Reversar_aprobacion] 1,2,1,62,1
CREATE PROCEDURE [dbo].[spSys_inv_Reversar_aprobacion]
(
@IdEmpresa int,
@IdSucursal int,
@IdMovi_inven_tipo int,
@IdNumMovi numeric,
@Borar bit
)
AS
BEGIN
DECLARE @IdEmpresa_inv int
DECLARE @IdSucursal_inv int
DECLARE @IdBodega_inv int
DECLARE @IdMovi_inven_tipo_inv int
DECLARE @IdNumMovi_inv numeric

--BORRO TABLAS PARA REVERSO DE APROBACION
DELETE [dbo].[in_spSys_inv_Reversar_aprobacion_in_movi_inven]
DELETE [dbo].[in_spSys_inv_Reversar_aprobacion_ct_cbtecble]

DECLARE @Contador_in_movi_inven numeric

--PREGUNTO SI LA CONSULTA TRAE FILAS
SELECT  @Contador_in_movi_inven = COUNT(IdEmpresa_inv)
FROM in_Ing_Egr_Inven_det 
WHERE IdEmpresa = @IdEmpresa and  IdSucursal = @IdSucursal  AND IdMovi_inven_tipo = @IdMovi_inven_tipo AND IdNumMovi = @IdNumMovi

--SI ES NULL LO PONGO EN 0
SET @Contador_in_movi_inven = ISNULL(@Contador_in_movi_inven ,0)
IF(@Contador_in_movi_inven > 0)
BEGIN

	--OBTENGO LOS ID DEL MOVIMIENTO
	INSERT INTO [dbo].[in_spSys_inv_Reversar_aprobacion_in_movi_inven]

	SELECT IdEmpresa_inv,IdSucursal_inv,IdBodega_inv,IdMovi_inven_tipo_inv,IdNumMovi_inv,secuencia_inv 
	FROM in_Ing_Egr_Inven_det 
	WHERE IdEmpresa = @IdEmpresa and  IdSucursal = @IdSucursal  AND IdMovi_inven_tipo = @IdMovi_inven_tipo AND IdNumMovi = @IdNumMovi

			IF(@Borar = 1)
						BEGIN
								UPDATE in_Ing_Egr_Inven_det SET IdEmpresa_inv = null, IdSucursal_inv = null, IdBodega_inv  = null, IdMovi_inven_tipo_inv = null, IdNumMovi_inv = null,
								secuencia_inv = null, IdEstadoAproba = 'PEND'
								WHERE IdEmpresa = @IdEmpresa and  IdSucursal = @IdSucursal  AND IdMovi_inven_tipo = @IdMovi_inven_tipo AND IdNumMovi = @IdNumMovi
														
								DECLARE @Contador_ct_cbtecble numeric
								--VERIFICO SI TIENE RELACIONES CON DIARIOS
								SELECT @Contador_ct_cbtecble = count(IdEmpresa_ct) FROM in_movi_inve_x_ct_cbteCble ct
								where exists(
										SELECT REV.IdEmpresa_inv FROM in_spSys_inv_Reversar_aprobacion_in_movi_inven REV
										WHERE REV.IdEmpresa_inv = ct.IdEmpresa
										AND REV.IdSucursal_inv = ct.IdSucursal
										AND REV.IdBodega_inv = ct.IdBodega
										AND REV.IdMovi_inven_tipo_inv = ct.IdMovi_inven_tipo
										AND REV.IdNumMovi_inv = ct.IdNumMovi
								)
												--SI VIENE NULL LE PONGO 0
												SET @Contador_ct_cbtecble = ISNULL(@Contador_ct_cbtecble,0)
												--SI TIENE RELACION CON DIARIOS, GRABO LOS ID PARA ELIMINARLOS
												IF(@Contador_ct_cbtecble > 0)
												BEGIN
															--GRABO LOS ID DE LOS DIARIOS A BORRAR
															INSERT INTO [dbo].[in_spSys_inv_Reversar_aprobacion_ct_cbtecble]
																	([IdEmpresa] ,[IdTipoCbte] ,[IdCbteCble])
															SELECT IdEmpresa_ct, IdTipoCbte, IdCbteCble FROM in_movi_inve_x_ct_cbteCble ct
															where exists(
																	SELECT REV.IdEmpresa_inv FROM in_spSys_inv_Reversar_aprobacion_in_movi_inven REV
																	WHERE REV.IdEmpresa_inv = ct.IdEmpresa
																	AND REV.IdSucursal_inv = ct.IdSucursal
																	AND REV.IdBodega_inv = ct.IdBodega
																	AND REV.IdMovi_inven_tipo_inv = ct.IdMovi_inven_tipo
																	AND REV.IdNumMovi_inv = ct.IdNumMovi
															)
															--ELIMINO RELACION DE DETALLE DE DIARIOS CON DETALLE INVENTARIO
															DELETE in_movi_inve_detalle_x_ct_cbtecble_det 
															WHERE EXISTS(
															SELECT ct.IdEmpresa from in_spSys_inv_Reversar_aprobacion_ct_cbtecble ct
															where ct.IdEmpresa = in_movi_inve_detalle_x_ct_cbtecble_det.IdEmpresa_ct
															and ct.IdTipoCbte = in_movi_inve_detalle_x_ct_cbtecble_det.IdTipoCbte_ct
															and ct.IdCbteCble = in_movi_inve_detalle_x_ct_cbtecble_det.IdCbteCble_ct
															)
															--ELIMINO RELACION DE CABECERA DE DIARIOS CON CABECERA DE INVENTARIO
															DELETE in_movi_inve_x_ct_cbteCble 
															WHERE EXISTS(
															SELECT ct.IdEmpresa from in_spSys_inv_Reversar_aprobacion_ct_cbtecble ct
															where ct.IdEmpresa = in_movi_inve_x_ct_cbteCble.IdEmpresa_ct
															and ct.IdTipoCbte = in_movi_inve_x_ct_cbteCble.IdTipoCbte
															and ct.IdCbteCble = in_movi_inve_x_ct_cbteCble.IdCbteCble
															)
															--ELIMINO DETALLE DE DIARIOS
															DELETE ct_cbtecble_det
															WHERE EXISTS(
															SELECT ct.IdEmpresa from in_spSys_inv_Reversar_aprobacion_ct_cbtecble ct
															where ct.IdEmpresa = ct_cbtecble_det.IdEmpresa
															and ct.IdTipoCbte = ct_cbtecble_det.IdTipoCbte
															and ct.IdCbteCble = ct_cbtecble_det.IdCbteCble
															)
															--ELIMINO CABECERA DE DIARIOS
															DELETE ct_cbtecble
															WHERE EXISTS(
															SELECT ct.IdEmpresa from in_spSys_inv_Reversar_aprobacion_ct_cbtecble ct
															where ct.IdEmpresa = ct_cbtecble.IdEmpresa
															and ct.IdTipoCbte = ct_cbtecble.IdTipoCbte
															and ct.IdCbteCble = ct_cbtecble.IdCbteCble
															)
												END
								--BORRO DETALLE DE MOVIMIENTO
								DELETE in_movi_inve_detalle 
								WHERE EXISTS(
									SELECT REV.IdEmpresa_inv FROM in_spSys_inv_Reversar_aprobacion_in_movi_inven REV
									WHERE REV.IdEmpresa_inv = in_movi_inve_detalle.IdEmpresa
									AND REV.IdSucursal_inv = in_movi_inve_detalle.IdSucursal
									AND REV.IdBodega_inv = in_movi_inve_detalle.IdBodega
									AND REV.IdMovi_inven_tipo_inv = in_movi_inve_detalle.IdMovi_inven_tipo
									AND REV.IdNumMovi_inv = in_movi_inve_detalle.IdNumMovi
								)
								--BORRO CABECERA DE MOVIMIENTO
								DELETE fa_factura_x_in_movi_inve
								WHERE EXISTS(
									SELECT REV.IdEmpresa_inv FROM in_spSys_inv_Reversar_aprobacion_in_movi_inven REV
									WHERE REV.IdEmpresa_inv = fa_factura_x_in_movi_inve.inv_IdEmpresa
									AND REV.IdSucursal_inv = fa_factura_x_in_movi_inve.inv_IdSucursal
									AND REV.IdBodega_inv = fa_factura_x_in_movi_inve.inv_IdBodega
									AND REV.IdMovi_inven_tipo_inv = fa_factura_x_in_movi_inve.inv_IdMovi_inven_tipo
									AND REV.IdNumMovi_inv = fa_factura_x_in_movi_inve.inv_IdNumMovi
								)
								--BORRO CABECERA DE MOVIMIENTO
								DELETE in_movi_inve
								WHERE EXISTS(
									SELECT REV.IdEmpresa_inv FROM in_spSys_inv_Reversar_aprobacion_in_movi_inven REV
									WHERE REV.IdEmpresa_inv = in_movi_inve.IdEmpresa
									AND REV.IdSucursal_inv = in_movi_inve.IdSucursal
									AND REV.IdBodega_inv = in_movi_inve.IdBodega
									AND REV.IdMovi_inven_tipo_inv = in_movi_inve.IdMovi_inven_tipo
									AND REV.IdNumMovi_inv = in_movi_inve.IdNumMovi
								)
								--SELECT PARA EL ENTITY
							SELECT * FROM in_Ing_Egr_Inven_det WHERE IdEmpresa = @IdEmpresa and  IdSucursal = @IdSucursal  AND IdMovi_inven_tipo = @IdMovi_inven_tipo AND IdNumMovi = @IdNumMovi
						END
			ELSE
						BEGIN
							SELECT * FROM in_Ing_Egr_Inven_det WHERE IdEmpresa = @IdEmpresa and  IdSucursal = @IdSucursal  AND IdMovi_inven_tipo = @IdMovi_inven_tipo AND IdNumMovi = @IdNumMovi							
				END
END
ELSE
SELECT * FROM in_Ing_Egr_Inven_det WHERE IdEmpresa = @IdEmpresa and  IdSucursal = @IdSucursal  AND IdMovi_inven_tipo = @IdMovi_inven_tipo AND IdNumMovi = @IdNumMovi
END