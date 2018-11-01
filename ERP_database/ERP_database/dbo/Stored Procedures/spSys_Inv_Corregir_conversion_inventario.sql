--EXEC [dbo].[spSys_Inv_Corregir_conversion_inventario] 3,774,0
CREATE PROC [dbo].[spSys_Inv_Corregir_conversion_inventario]
(
@IdEmpresa int,
@IdProducto numeric,
@Corregir bit
)
AS
BEGIN
--SE DEBE PRIMERO CORREGIR DE LA TABLA in_Ing_Egr_Inven_det:
	--IdUnidadMedida_sinConversion
	--dm_cantidad_sinConversion

--EN CASO DE QUE VENGA EL PROBLEMA DESDE LA OC, SE DEBE CORREGIR DE LA TABLA com_ordencompra_local_det:
	--IdUnidadMedida

--SI SE DESEA ACTUALIZAR SOLO EL REGISTRO DESDE LA ORDEN DE COMPRA DESCOMENTAR 
DECLARE @IdSucursal_oc int
DECLARE @IdOrdenCompra numeric

SET @IdSucursal_oc = 1
SET @IdOrdenCompra = 436

IF(@Corregir = 1)
BEGIN
					--update com_ordencompra_local_det set IdUnidadMedida = 'KLG' where IdEmpresa = 3 and IdOrdenCompra = 372 and IdProducto = 1259
					/*
					UPDATE in_Ing_Egr_Inven_det 
					set IdUnidadMedida_sinConversion = 'KLG', dm_cantidad_sinConversion = -200  
					where IdEmpresa = 3 AND IdMovi_inven_tipo = 7 AND IdNumMovi = 13 AND Secuencia = 1--and IdOrdenCompra =372
					*/
					update in_Ing_Egr_Inven_det set IdUnidadMedida = a.IdUnidadMedida_equiva, dm_cantidad = a.cantidad_equiv, mv_costo = a.costo_equiv
					FROM(
					SELECT        in_Ing_Egr_Inven_det.IdEmpresa, in_Ing_Egr_Inven_det.IdSucursal, in_Ing_Egr_Inven_det.IdMovi_inven_tipo, in_Ing_Egr_Inven_det.IdNumMovi, 
											 in_Ing_Egr_Inven_det.Secuencia, in_Ing_Egr_Inven_det.IdProducto, in_Ing_Egr_Inven_det.IdUnidadMedida_sinConversion, 
											 in_Ing_Egr_Inven_det.dm_cantidad_sinConversion, in_Ing_Egr_Inven_det.mv_costo_sinConversion, in_Producto.pr_codigo, in_Producto.pr_descripcion, 
											 in_UnidadMedida_Equiv_conversion.IdUnidadMedida_equiva, in_UnidadMedida_Equiv_conversion.valor_equiv, 
											 in_UnidadMedida_Equiv_conversion.interpretacion, in_Ing_Egr_Inven_det.dm_cantidad_sinConversion * in_UnidadMedida_Equiv_conversion.valor_equiv as cantidad_equiv,
											 in_Ing_Egr_Inven_det.mv_costo_sinConversion * in_UnidadMedida_Equiv_conversion.valor_equiv as costo_equiv
					FROM            in_Ing_Egr_Inven_det INNER JOIN
											 in_Producto ON in_Ing_Egr_Inven_det.IdEmpresa = in_Producto.IdEmpresa AND in_Ing_Egr_Inven_det.IdProducto = in_Producto.IdProducto INNER JOIN
											 in_UnidadMedida_Equiv_conversion ON in_Ing_Egr_Inven_det.IdUnidadMedida_sinConversion = in_UnidadMedida_Equiv_conversion.IdUnidadMedida AND 
											 in_Producto.IdUnidadMedida_Consumo = in_UnidadMedida_Equiv_conversion.IdUnidadMedida_equiva
					where in_Producto.IdProducto = @IdProducto and in_Ing_Egr_Inven_det.IdEmpresa = @IdEmpresa
					and IdSucursal_oc = @IdSucursal_oc
					AND IdOrdenCompra = @IdOrdenCompra
					) A
					where in_Ing_Egr_Inven_det.IdEmpresa = A.IdEmpresa
					AND in_Ing_Egr_Inven_det.IdSucursal = A.IdSucursal
					AND in_Ing_Egr_Inven_det.IdMovi_inven_tipo = A.IdMovi_inven_tipo
					AND in_Ing_Egr_Inven_det.IdNumMovi = A.IdNumMovi
					AND in_Ing_Egr_Inven_det.Secuencia = A.Secuencia


					update in_movi_inve_detalle set IdUnidadMedida = a.IdUnidadMedida_equiva, dm_cantidad = a.cantidad_equiv, mv_costo = a.costo_equiv,
													IdUnidadMedida_sinConversion = a.IdUnidadMedida_sinConversion, dm_cantidad_sinConversion = a.dm_cantidad_sinConversion, mv_costo_sinConversion = a.mv_costo_sinConversion,
													Costeado = 0
					FROM(
					SELECT        in_Ing_Egr_Inven_det.IdEmpresa_inv, in_Ing_Egr_Inven_det.IdSucursal_inv, in_Ing_Egr_Inven_det.IdBodega_inv, in_Ing_Egr_Inven_det.IdMovi_inven_tipo_inv, in_Ing_Egr_Inven_det.IdNumMovi_inv, 
											 in_Ing_Egr_Inven_det.secuencia_inv, in_Ing_Egr_Inven_det.IdProducto, in_Ing_Egr_Inven_det.IdUnidadMedida_sinConversion, 
											 in_Ing_Egr_Inven_det.dm_cantidad_sinConversion, in_Ing_Egr_Inven_det.mv_costo_sinConversion, in_Producto.pr_codigo, in_Producto.pr_descripcion, 
											 in_UnidadMedida_Equiv_conversion.IdUnidadMedida_equiva, in_UnidadMedida_Equiv_conversion.valor_equiv, 
											 in_UnidadMedida_Equiv_conversion.interpretacion, in_Ing_Egr_Inven_det.dm_cantidad_sinConversion * in_UnidadMedida_Equiv_conversion.valor_equiv as cantidad_equiv,
											 in_Ing_Egr_Inven_det.mv_costo_sinConversion * in_UnidadMedida_Equiv_conversion.valor_equiv as costo_equiv
					FROM            in_Ing_Egr_Inven_det INNER JOIN
											 in_Producto ON in_Ing_Egr_Inven_det.IdEmpresa = in_Producto.IdEmpresa AND in_Ing_Egr_Inven_det.IdProducto = in_Producto.IdProducto INNER JOIN
											 in_UnidadMedida_Equiv_conversion ON in_Ing_Egr_Inven_det.IdUnidadMedida_sinConversion = in_UnidadMedida_Equiv_conversion.IdUnidadMedida AND 
											 in_Producto.IdUnidadMedida_Consumo = in_UnidadMedida_Equiv_conversion.IdUnidadMedida_equiva
					where in_Producto.IdProducto = @IdProducto  and in_Ing_Egr_Inven_det.IdEmpresa = @IdEmpresa
					and IdSucursal_oc = @IdSucursal_oc
					AND IdOrdenCompra = @IdOrdenCompra
					) A
					where in_movi_inve_detalle.IdEmpresa = A.IdEmpresa_inv
					AND in_movi_inve_detalle.IdSucursal = A.IdSucursal_inv
					and in_movi_inve_detalle.IdBodega = a.IdBodega_inv
					AND in_movi_inve_detalle.IdMovi_inven_tipo = A.IdMovi_inven_tipo_inv
					AND in_movi_inve_detalle.IdNumMovi = A.IdNumMovi_inv
					AND in_movi_inve_detalle.Secuencia = A.secuencia_inv
END
ELSE
BEGIN
				SELECT        in_Ing_Egr_Inven_det.IdEmpresa, in_Ing_Egr_Inven_det.IdSucursal, in_Ing_Egr_Inven_det.IdMovi_inven_tipo, in_Ing_Egr_Inven_det.IdNumMovi, 
							in_Ing_Egr_Inven_det.Secuencia, in_Ing_Egr_Inven_det.IdProducto, in_Ing_Egr_Inven_det.IdUnidadMedida_sinConversion, 
							in_Ing_Egr_Inven_det.dm_cantidad_sinConversion, in_Ing_Egr_Inven_det.mv_costo_sinConversion, in_Producto.pr_codigo, in_Producto.pr_descripcion, 
							in_UnidadMedida_Equiv_conversion.IdUnidadMedida_equiva, in_UnidadMedida_Equiv_conversion.valor_equiv, 
							in_UnidadMedida_Equiv_conversion.interpretacion, in_Ing_Egr_Inven_det.dm_cantidad_sinConversion * in_UnidadMedida_Equiv_conversion.valor_equiv as cantidad_equiv,
							in_Ing_Egr_Inven_det.mv_costo_sinConversion * in_UnidadMedida_Equiv_conversion.valor_equiv as costo_equiv,
							--ACTUAL
							in_Ing_Egr_Inven_det.IdUnidadMedida, in_Ing_Egr_Inven_det.dm_cantidad, in_Ing_Egr_Inven_det.mv_costo
				FROM            in_Ing_Egr_Inven_det INNER JOIN
							in_Producto ON in_Ing_Egr_Inven_det.IdEmpresa = in_Producto.IdEmpresa AND in_Ing_Egr_Inven_det.IdProducto = in_Producto.IdProducto INNER JOIN
							in_UnidadMedida_Equiv_conversion ON in_Ing_Egr_Inven_det.IdUnidadMedida_sinConversion = in_UnidadMedida_Equiv_conversion.IdUnidadMedida AND 
							in_Producto.IdUnidadMedida_Consumo = in_UnidadMedida_Equiv_conversion.IdUnidadMedida_equiva
				where in_Producto.IdProducto = @IdProducto and in_Ing_Egr_Inven_det.IdEmpresa = @IdEmpresa
						and IdSucursal_oc = @IdSucursal_oc
						AND IdOrdenCompra = @IdOrdenCompra

				SELECT        in_Ing_Egr_Inven_det.IdEmpresa_inv, in_Ing_Egr_Inven_det.IdSucursal_inv, in_Ing_Egr_Inven_det.IdBodega_inv, in_Ing_Egr_Inven_det.IdMovi_inven_tipo_inv, in_Ing_Egr_Inven_det.IdNumMovi_inv, 
							in_Ing_Egr_Inven_det.secuencia_inv, in_Ing_Egr_Inven_det.IdProducto, in_Ing_Egr_Inven_det.IdUnidadMedida_sinConversion, 
							in_Ing_Egr_Inven_det.dm_cantidad_sinConversion, in_Ing_Egr_Inven_det.mv_costo_sinConversion, in_Producto.pr_codigo, in_Producto.pr_descripcion, 
							in_UnidadMedida_Equiv_conversion.IdUnidadMedida_equiva, in_UnidadMedida_Equiv_conversion.valor_equiv, 
							in_UnidadMedida_Equiv_conversion.interpretacion, in_Ing_Egr_Inven_det.dm_cantidad_sinConversion * in_UnidadMedida_Equiv_conversion.valor_equiv as cantidad_equiv,
							in_Ing_Egr_Inven_det.mv_costo_sinConversion * in_UnidadMedida_Equiv_conversion.valor_equiv as costo_equiv,
							--ACTUAL
							in_Ing_Egr_Inven_det.IdUnidadMedida, in_Ing_Egr_Inven_det.dm_cantidad, in_Ing_Egr_Inven_det.mv_costo
				FROM            in_Ing_Egr_Inven_det INNER JOIN
							in_Producto ON in_Ing_Egr_Inven_det.IdEmpresa = in_Producto.IdEmpresa AND in_Ing_Egr_Inven_det.IdProducto = in_Producto.IdProducto INNER JOIN
							in_UnidadMedida_Equiv_conversion ON in_Ing_Egr_Inven_det.IdUnidadMedida_sinConversion = in_UnidadMedida_Equiv_conversion.IdUnidadMedida AND 
							in_Producto.IdUnidadMedida_Consumo = in_UnidadMedida_Equiv_conversion.IdUnidadMedida_equiva
				where in_Producto.IdProducto = @IdProducto  and in_Ing_Egr_Inven_det.IdEmpresa = @IdEmpresa
						and IdSucursal_oc = @IdSucursal_oc
						AND IdOrdenCompra = @IdOrdenCompra

END

END