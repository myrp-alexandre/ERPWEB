
-- exec [dbo].[spINV_Rpt010] 1,1,9999,1,9999,1,99999,'01/10/2016','31/05/2017','admin',0,1
CREATE PROCEDURE [dbo].[spINV_Rpt010] 	
@IdEmpresa int,
@IdSucursal_ini int,
@IdSucursal_fin int,
@IdBodega_ini int,
@IdBodega_fin int,
@IdProducto_ini numeric,
@IdProducto_fin numeric,
@Fecha_ini datetime,
@Fecha_fin datetime,
@IdUsuario varchar(20),
@No_Mostrar_valores_en_0 bit,
@Mostrar_detallado bit
AS
BEGIN

--ELIMINO REGISTROS DE LA TABLA DEL REPORTE
DELETE in_INV_Rpt010 WHERE IdUsuario = @IdUsuario

--INSERTO REGISTROS CON MOVIMIENTOS 
			INSERT INTO [dbo].[in_INV_Rpt010]
           ([IdEmpresa]           ,[IdSucursal]           ,[IdBodega]           ,[IdProducto]		,[IdUsuario]
		   ,[Saldo_ini_cant]      ,[Saldo_ini_cost]       ,[Saldo_fin_cant]     ,[Saldo_fin_cost]
		   ,[mov_ing_cant]		  ,[mov_ing_cost]		  ,[mov_egr_cant]		,[mov_egr_cost])
			SELECT		det.IdEmpresa	      ,det.IdSucursal		  ,det.IdBodega		    ,det.IdProducto 	,@IdUsuario
			,0					  ,0					  ,0					,0
			,0					  ,0					  ,0					,0
			FROM		in_movi_inve cab inner join in_movi_inve_detalle det
			on cab.IdEmpresa = det.IdEmpresa and cab.IdSucursal = det.IdSucursal
			and cab.IdBodega = det.IdBodega and cab.IdMovi_inven_tipo = det.IdMovi_inven_tipo
			and cab.IdNumMovi = det.IdNumMovi
			WHERE cab.IdEmpresa = @IdEmpresa
			and cab.IdSucursal between @IdSucursal_ini and @IdSucursal_fin
			and cab.IdBodega between @IdBodega_ini and @IdBodega_fin
			and det.IdProducto between @IdProducto_ini and @IdProducto_fin
			and cab.cm_fecha <= @Fecha_fin
			group by det.IdEmpresa, det.IdSucursal, det.IdBodega, det.IdProducto

--SI NO DEBE MOSTRAR ITEMS SIN MOVIMIENTOS BORRO LOS ITEMS QUE NO TUVIERON MOVIMIENTO EN ESE RANGO DE FECHAS
		if(@No_Mostrar_valores_en_0 = 1)
		begin
			DELETE [dbo].[in_INV_Rpt010]
			WHERE NOT EXISTS(
				SELECT det.IdEmpresa, det.IdSucursal, det.IdBodega, det.IdProducto
				FROM in_movi_inve cab inner join in_movi_inve_detalle det
				on cab.IdEmpresa = det.IdEmpresa and cab.IdSucursal = det.IdSucursal
				and cab.IdBodega = det.IdBodega and cab.IdMovi_inven_tipo = det.IdMovi_inven_tipo
				and cab.IdNumMovi = det.IdNumMovi
				WHERE cab.IdEmpresa = @IdEmpresa
				and cab.IdSucursal between @IdSucursal_ini and @IdSucursal_fin
				and cab.IdBodega between @IdBodega_ini and @IdBodega_fin
				and det.IdProducto between @IdProducto_ini and @IdProducto_fin
				and cab.cm_fecha BETWEEN @Fecha_ini AND @Fecha_fin
			
				and cab.IdEmpresa = [in_INV_Rpt010].[IdEmpresa]
				and cab.IdSucursal = [in_INV_Rpt010].[IdSucursal]
				and cab.IdBodega = [in_INV_Rpt010].[IdBodega]
				and det.IdProducto = [in_INV_Rpt010].[IdProducto]
			
				group by det.IdEmpresa, det.IdSucursal, det.IdBodega, det.IdProducto
				) AND IdUsuario = @IdUsuario
		end

--ACTUALIZO SALDO INICIAL
UPDATE [dbo].[in_INV_Rpt010]
   SET [Saldo_ini_cant] = A.Saldo_ini_cant
      ,[Saldo_ini_cost] = A.Saldo_ini_cost
FROM(
			SELECT        det.IdEmpresa, det.IdSucursal, det.IdBodega, det.IdProducto, sum(det.dm_cantidad) Saldo_ini_cant, sum(det.dm_cantidad * mv_costo) Saldo_ini_cost
			FROM            in_movi_inve AS cab INNER JOIN
							in_movi_inve_detalle AS det ON cab.IdEmpresa = det.IdEmpresa AND cab.IdSucursal = det.IdSucursal AND cab.IdBodega = det.IdBodega AND 
							cab.IdMovi_inven_tipo = det.IdMovi_inven_tipo AND cab.IdNumMovi = det.IdNumMovi
							WHERE cab.IdEmpresa = @IdEmpresa
							and cab.IdSucursal between @IdSucursal_ini and @IdSucursal_fin
							and cab.IdBodega between @IdBodega_ini and @IdBodega_fin
							and det.IdProducto between @IdProducto_ini and @IdProducto_fin
							and cab.cm_fecha < @Fecha_ini
							group by det.IdEmpresa, det.IdSucursal, det.IdBodega, det.IdProducto
) A
where A.IdEmpresa = [dbo].[in_INV_Rpt010].IdEmpresa
and A.IdSucursal = [dbo].[in_INV_Rpt010].IdSucursal
AND A.IdBodega = [dbo].[in_INV_Rpt010].IdBodega
AND A.IdProducto = [dbo].[in_INV_Rpt010].IdProducto
AND [dbo].[in_INV_Rpt010].[IdUsuario] = @IdUsuario

--ACTUALIZO SALDO FINAL
UPDATE [dbo].[in_INV_Rpt010]
   SET [Saldo_fin_cant] = A.Saldo_fin_cant
      ,[Saldo_fin_cost] = A.Saldo_fin_cost
FROM(
			SELECT        det.IdEmpresa, det.IdSucursal, det.IdBodega, det.IdProducto, sum(det.dm_cantidad) Saldo_fin_cant, sum(det.dm_cantidad * mv_costo) Saldo_fin_cost
			FROM            in_movi_inve AS cab INNER JOIN
							in_movi_inve_detalle AS det ON cab.IdEmpresa = det.IdEmpresa AND cab.IdSucursal = det.IdSucursal AND cab.IdBodega = det.IdBodega AND 
							cab.IdMovi_inven_tipo = det.IdMovi_inven_tipo AND cab.IdNumMovi = det.IdNumMovi
							WHERE cab.IdEmpresa = @IdEmpresa
							and cab.IdSucursal between @IdSucursal_ini and @IdSucursal_fin
							and cab.IdBodega between @IdBodega_ini and @IdBodega_fin
							and det.IdProducto between @IdProducto_ini and @IdProducto_fin
							and cab.cm_fecha <= @Fecha_fin
							group by det.IdEmpresa, det.IdSucursal, det.IdBodega, det.IdProducto
) A
where A.IdEmpresa = [dbo].[in_INV_Rpt010].IdEmpresa
and A.IdSucursal = [dbo].[in_INV_Rpt010].IdSucursal
AND A.IdBodega = [dbo].[in_INV_Rpt010].IdBodega
AND A.IdProducto = [dbo].[in_INV_Rpt010].IdProducto
AND [dbo].[in_INV_Rpt010].[IdUsuario] = @IdUsuario

IF(@Mostrar_detallado = 0)
BEGIN
--ACTUALIZO LOS INGRESOS Y EGRESOS QUE TUVIERON LOS REGISTROS DURANTE EL RANGO DE FECHAS
		UPDATE in_INV_Rpt010 
		SET mov_egr_cant = ABS(A.cant_egr)
		,mov_egr_cost = ABS(A.cost_total_egr)
		,mov_ing_cant = ABS(A.cant_ing)
		,mov_ing_cost = ABS(A.cos_total_ing)
		FROM(
				SELECT        in_movi_inve_detalle.IdEmpresa, in_movi_inve_detalle.IdSucursal, in_movi_inve_detalle.IdBodega, in_movi_inve_detalle.IdProducto, 
						sum(iif(in_movi_inve_detalle.dm_cantidad > 0,in_movi_inve_detalle.dm_cantidad,0)) cant_ing ,
						sum(iif(in_movi_inve_detalle.dm_cantidad > 0,in_movi_inve_detalle.dm_cantidad,0) * iif(in_movi_inve_detalle.dm_cantidad > 0,in_movi_inve_detalle.mv_costo,0)) cos_total_ing,
						sum(iif(in_movi_inve_detalle.dm_cantidad < 0,in_movi_inve_detalle.dm_cantidad,0)) cant_egr ,
						sum(iif(in_movi_inve_detalle.dm_cantidad < 0,in_movi_inve_detalle.dm_cantidad,0) * iif(in_movi_inve_detalle.dm_cantidad < 0,in_movi_inve_detalle.mv_costo,0)) cost_total_egr							
				FROM            in_movi_inve INNER JOIN
						in_movi_inve_detalle ON in_movi_inve.IdEmpresa = in_movi_inve_detalle.IdEmpresa AND in_movi_inve.IdSucursal = in_movi_inve_detalle.IdSucursal AND 
						in_movi_inve.IdBodega = in_movi_inve_detalle.IdBodega AND in_movi_inve.IdMovi_inven_tipo = in_movi_inve_detalle.IdMovi_inven_tipo AND 
						in_movi_inve.IdNumMovi = in_movi_inve_detalle.IdNumMovi
				WHERE	in_movi_inve.cm_fecha between @Fecha_ini and @Fecha_fin
				group by in_movi_inve_detalle.IdEmpresa, in_movi_inve_detalle.IdSucursal, in_movi_inve_detalle.IdBodega, in_movi_inve_detalle.IdProducto
		) A
		WHERE A.IdEmpresa = in_INV_Rpt010.IdEmpresa
		and A.IdSucursal = in_INV_Rpt010.IdSucursal
		and A.IdBodega = in_INV_Rpt010.IdBodega
		and A.IdProducto = in_INV_Rpt010.IdProducto
		and in_INV_Rpt010.IdUsuario = @IdUsuario
END



--VISTA FINAL
SELECT * FROM (
				SELECT        det.IdEmpresa, det.IdSucursal, det.IdBodega, det.IdMovi_inven_tipo, in_Ing_Egr_Inven_det.IdNumMovi, det.Secuencia, det.IdProducto
						,in_INV_Rpt010.Saldo_ini_cant,(in_INV_Rpt010.Saldo_ini_cost / iif(in_INV_Rpt010.Saldo_ini_cant=0,1,in_INV_Rpt010.Saldo_ini_cant)) Cost_prom_ini, in_INV_Rpt010.Saldo_ini_cost
						
						,isnull(iif(det.dm_cantidad > 0,abs(det.dm_cantidad),0),0) cant_ing
						,isnull(iif(det.dm_cantidad > 0,abs(det.mv_costo),0),0) cost_ing
						,isnull(iif(det.dm_cantidad > 0,abs(det.dm_cantidad * det.mv_costo),0),0) total_ing
						,isnull(iif(det.dm_cantidad < 0,abs(det.dm_cantidad),0),0) cant_egr
						,isnull(iif(det.dm_cantidad < 0,abs(det.mv_costo),0),0) cost_egr				
						,isnull(iif(det.dm_cantidad < 0,abs(det.dm_cantidad * det.mv_costo),0),0) total_egr
						,in_INV_Rpt010.Saldo_ini_cant + sum(isnull(det.dm_cantidad,0))
						over(partition by 
						det.IdEmpresa, det.IdSucursal,det.IdBodega, det.IdProducto
						order by det.IdEmpresa asc, det.IdSucursal asc ,det.IdBodega asc, det.IdProducto asc,cab.cm_fecha asc,det.dm_cantidad desc, det.IdNumMovi ASC,det.Secuencia ASC
						rows unbounded preceding) as Saldo_cant
						,
						(in_INV_Rpt010.Saldo_ini_cost + sum(isnull(det.mv_costo*det.dm_cantidad,0))
						over(partition by 
						det.IdEmpresa, det.IdSucursal,det.IdBodega, det.IdProducto
						order by det.IdEmpresa asc, det.IdSucursal asc ,det.IdBodega asc, det.IdProducto asc,cab.cm_fecha asc,det.dm_cantidad desc, det.IdNumMovi ASC,det.Secuencia ASC
						rows unbounded preceding))
						/iif(
						(in_INV_Rpt010.Saldo_ini_cant + sum(isnull(det.dm_cantidad,0))
						over(partition by 
						det.IdEmpresa, det.IdSucursal,det.IdBodega, det.IdProducto
						order by det.IdEmpresa asc, det.IdSucursal asc ,det.IdBodega asc, det.IdProducto asc,cab.cm_fecha asc,det.dm_cantidad desc, det.IdNumMovi ASC,det.Secuencia ASC
						rows unbounded preceding)) = 0 , 1 ,
						(in_INV_Rpt010.Saldo_ini_cant + sum(isnull(det.dm_cantidad,0))
						over(partition by 
						det.IdEmpresa, det.IdSucursal,det.IdBodega, det.IdProducto
						order by det.IdEmpresa asc, det.IdSucursal asc ,det.IdBodega asc, det.IdProducto asc,cab.cm_fecha asc,det.dm_cantidad desc, det.IdNumMovi ASC,det.Secuencia ASC
						rows unbounded preceding)))
						 as Saldo_cost_prom
						,in_INV_Rpt010.Saldo_ini_cost + sum(isnull(det.mv_costo*det.dm_cantidad,0))
						over(partition by 
						det.IdEmpresa, det.IdSucursal,det.IdBodega, det.IdProducto
						order by det.IdEmpresa asc, det.IdSucursal asc ,det.IdBodega asc, det.IdProducto asc,cab.cm_fecha asc,det.dm_cantidad desc, det.IdNumMovi ASC,det.Secuencia ASC
						rows unbounded preceding) as Saldo_cost
						
						 ,in_INV_Rpt010.Saldo_fin_cant,(in_INV_Rpt010.Saldo_fin_cost / iif(in_INV_Rpt010.Saldo_fin_cant=0,1,in_INV_Rpt010.Saldo_fin_cant)) Cost_prom_fin, in_INV_Rpt010.Saldo_fin_cost
						, in_INV_Rpt010.IdUsuario, det.dm_observacion, cab.cm_fecha, in_movi_inven_tipo.cm_descripcionCorta as tipo_movi, tb_bodega.cod_bodega, tb_bodega.bo_Descripcion AS nom_bodega, 
						tb_sucursal.codigo AS cod_sucursal, tb_sucursal.Su_Descripcion AS nom_sucursal, in_Ing_Egr_Inven_det.IdEmpresa_oc, in_Ing_Egr_Inven_det.IdSucursal_oc, 
						in_Ing_Egr_Inven_det.IdOrdenCompra, cast(cast(isnull(cp_orden_giro.co_factura,fac.vt_NumFactura) as numeric) as varchar) AS num_factura, isnull(tb_persona.pe_nombreCompleto,fac.pe_nombreCompleto) AS nom_proveedor, in_Producto.pr_codigo, 
						in_Producto.pr_descripcion, in_UnidadMedida.IdUnidadMedida, in_UnidadMedida.Descripcion as nom_unidad_consumo, in_UnidadMedida.cod_alterno as cod_unidad_consumo
FROM            tb_persona INNER JOIN
                         cp_proveedor ON tb_persona.IdPersona = cp_proveedor.IdPersona INNER JOIN
                         com_ordencompra_local ON cp_proveedor.IdEmpresa = com_ordencompra_local.IdEmpresa AND 
                         cp_proveedor.IdProveedor = com_ordencompra_local.IdProveedor RIGHT OUTER JOIN
                         in_movi_inve AS cab INNER JOIN
                         in_movi_inve_detalle AS det ON cab.IdEmpresa = det.IdEmpresa AND cab.IdSucursal = det.IdSucursal AND cab.IdBodega = det.IdBodega AND 
                         cab.IdMovi_inven_tipo = det.IdMovi_inven_tipo AND cab.IdNumMovi = det.IdNumMovi INNER JOIN
                         in_movi_inven_tipo ON cab.IdEmpresa = in_movi_inven_tipo.IdEmpresa AND cab.IdMovi_inven_tipo = in_movi_inven_tipo.IdMovi_inven_tipo INNER JOIN
                         tb_bodega ON cab.IdEmpresa = tb_bodega.IdEmpresa AND cab.IdSucursal = tb_bodega.IdSucursal AND cab.IdBodega = tb_bodega.IdBodega INNER JOIN
                         tb_sucursal ON tb_bodega.IdEmpresa = tb_sucursal.IdEmpresa AND tb_bodega.IdSucursal = tb_sucursal.IdSucursal INNER JOIN
                         in_Ing_Egr_Inven_det ON det.IdEmpresa = in_Ing_Egr_Inven_det.IdEmpresa_inv AND det.IdSucursal = in_Ing_Egr_Inven_det.IdSucursal_inv AND 
                         det.IdBodega = in_Ing_Egr_Inven_det.IdBodega_inv AND det.IdMovi_inven_tipo = in_Ing_Egr_Inven_det.IdMovi_inven_tipo_inv AND 
                         det.IdNumMovi = in_Ing_Egr_Inven_det.IdNumMovi_inv AND det.Secuencia = in_Ing_Egr_Inven_det.secuencia_inv RIGHT OUTER JOIN
                         in_Producto INNER JOIN
                         in_INV_Rpt010 ON in_Producto.IdEmpresa = in_INV_Rpt010.IdEmpresa AND in_Producto.IdProducto = in_INV_Rpt010.IdProducto ON 
                         det.IdEmpresa = in_INV_Rpt010.IdEmpresa AND det.IdSucursal = in_INV_Rpt010.IdSucursal AND det.IdBodega = in_INV_Rpt010.IdBodega AND 
                         det.IdProducto = in_INV_Rpt010.IdProducto INNER JOIN
                         in_UnidadMedida ON in_UnidadMedida.IdUnidadMedida = in_Producto.IdUnidadMedida_Consumo ON 
                         com_ordencompra_local.IdEmpresa = in_Ing_Egr_Inven_det.IdEmpresa_oc AND com_ordencompra_local.IdSucursal = in_Ing_Egr_Inven_det.IdSucursal_oc AND 
                         com_ordencompra_local.IdOrdenCompra = in_Ing_Egr_Inven_det.IdOrdenCompra LEFT OUTER JOIN
                         cp_Aprobacion_Ing_Bod_x_OC INNER JOIN
                         cp_Aprobacion_Ing_Bod_x_OC_det ON cp_Aprobacion_Ing_Bod_x_OC.IdEmpresa = cp_Aprobacion_Ing_Bod_x_OC_det.IdEmpresa AND 
                         cp_Aprobacion_Ing_Bod_x_OC.IdAprobacion = cp_Aprobacion_Ing_Bod_x_OC_det.IdAprobacion INNER JOIN
                         cp_orden_giro ON cp_Aprobacion_Ing_Bod_x_OC.IdEmpresa_Ogiro = cp_orden_giro.IdEmpresa AND 
                         cp_Aprobacion_Ing_Bod_x_OC.IdCbteCble_Ogiro = cp_orden_giro.IdCbteCble_Ogiro AND 
                         cp_Aprobacion_Ing_Bod_x_OC.IdTipoCbte_Ogiro = cp_orden_giro.IdTipoCbte_Ogiro ON 
                         in_Ing_Egr_Inven_det.IdEmpresa = cp_Aprobacion_Ing_Bod_x_OC_det.IdEmpresa_Ing_Egr_Inv AND 
                         in_Ing_Egr_Inven_det.IdSucursal = cp_Aprobacion_Ing_Bod_x_OC_det.IdSucursal_Ing_Egr_Inv AND 
                         in_Ing_Egr_Inven_det.IdMovi_inven_tipo = cp_Aprobacion_Ing_Bod_x_OC_det.IdMovi_inven_tipo_Ing_Egr_Inv AND 
                         in_Ing_Egr_Inven_det.IdNumMovi = cp_Aprobacion_Ing_Bod_x_OC_det.IdNumMovi_Ing_Egr_Inv AND 
                         in_Ing_Egr_Inven_det.Secuencia = cp_Aprobacion_Ing_Bod_x_OC_det.Secuencia_Ing_Egr_Inv
						 LEFT JOIN (
							SELECT fa_factura_x_in_Ing_Egr_Inven.IdEmpresa_in_eg_x_inv, fa_factura_x_in_Ing_Egr_Inven.IdSucursal_in_eg_x_inv, fa_factura_x_in_Ing_Egr_Inven.IdMovi_inven_tipo_in_eg_x_inv, fa_factura_x_in_Ing_Egr_Inven.IdNumMovi_in_eg_x_inv, 
							fa_factura.vt_NumFactura, per_cli.pe_nombreCompleto
							FROM     fa_factura INNER JOIN
							fa_factura_x_in_Ing_Egr_Inven ON fa_factura.IdEmpresa = fa_factura_x_in_Ing_Egr_Inven.IdEmpresa_fa AND fa_factura.IdSucursal = fa_factura_x_in_Ing_Egr_Inven.IdSucursal_fa AND 
							fa_factura.IdBodega = fa_factura_x_in_Ing_Egr_Inven.IdBodega_fa AND fa_factura.IdCbteVta = fa_factura_x_in_Ing_Egr_Inven.IdCbteVta_fa INNER JOIN
							fa_cliente ON fa_factura.IdEmpresa = fa_cliente.IdEmpresa AND fa_factura.IdCliente = fa_cliente.IdCliente INNER JOIN
							tb_persona AS per_cli ON fa_cliente.IdPersona = per_cli.IdPersona
						 ) fac on fac.IdEmpresa_in_eg_x_inv = in_Ing_Egr_Inven_det.IdEmpresa
						 and in_Ing_Egr_Inven_det.IdSucursal = fac.IdSucursal_in_eg_x_inv
						 and in_Ing_Egr_Inven_det.IdMovi_inven_tipo = fac.IdMovi_inven_tipo_in_eg_x_inv
						 and in_Ing_Egr_Inven_det.IdNumMovi = fac.IdNumMovi_in_eg_x_inv
						WHERE 
						det.IdEmpresa=@IdEmpresa
						and det.IdSucursal between @IdSucursal_ini and @IdSucursal_fin
						and	det.IdBodega between @IdBodega_ini and @IdBodega_fin

						
						and in_INV_Rpt010.IdUsuario = @IdUsuario 
						and cab.cm_fecha between @Fecha_ini and @Fecha_fin
						AND @Mostrar_detallado = 1
						


				UNION
						SELECT        in_INV_Rpt010.IdEmpresa, in_INV_Rpt010.IdSucursal, in_INV_Rpt010.IdBodega, null, null, null, in_INV_Rpt010.IdProducto
						,in_INV_Rpt010.Saldo_ini_cant
						,(in_INV_Rpt010.Saldo_ini_cost / iif(in_INV_Rpt010.Saldo_ini_cant=0,1,in_INV_Rpt010.Saldo_ini_cant)) Cost_prom_ini, in_INV_Rpt010.Saldo_ini_cost
						,0 cant_ing
						,0 cost_ing
						,0 total_ing
						,0 cant_egr
						,0 cost_egr				
						,0 total_egr
						,in_INV_Rpt010.Saldo_ini_cant Saldo_cant
						,(in_INV_Rpt010.Saldo_ini_cost / iif(in_INV_Rpt010.Saldo_ini_cant=0,1,in_INV_Rpt010.Saldo_ini_cant)) as Saldo_cost_prom
						,in_INV_Rpt010.Saldo_ini_cost Saldo_cost
						,in_INV_Rpt010.Saldo_fin_cant,(in_INV_Rpt010.Saldo_fin_cost / iif(in_INV_Rpt010.Saldo_fin_cant=0,1,in_INV_Rpt010.Saldo_fin_cant)) Cost_prom_fin, in_INV_Rpt010.Saldo_fin_cost
						,in_INV_Rpt010.IdUsuario, '', @Fecha_ini, '' as tipo_movi, tb_bodega.cod_bodega, tb_bodega.bo_Descripcion AS nom_bodega, 
						tb_sucursal.codigo AS cod_sucursal, tb_sucursal.Su_Descripcion AS nom_sucursal, null, null, 
						null, null AS num_factura, null AS nom_proveedor, in_Producto.pr_codigo, 
						in_Producto.pr_descripcion, in_UnidadMedida.IdUnidadMedida, in_UnidadMedida.Descripcion as nom_unidad_consumo, in_UnidadMedida.cod_alterno as cod_unidad_consumo
						FROM            in_Producto INNER JOIN
						in_INV_Rpt010 ON in_Producto.IdEmpresa = in_INV_Rpt010.IdEmpresa AND in_Producto.IdProducto = in_INV_Rpt010.IdProducto INNER JOIN
						tb_sucursal INNER JOIN
						tb_bodega ON tb_sucursal.IdEmpresa = tb_bodega.IdEmpresa AND tb_sucursal.IdSucursal = tb_bodega.IdSucursal ON 
						in_INV_Rpt010.IdEmpresa = tb_bodega.IdEmpresa AND in_INV_Rpt010.IdSucursal = tb_bodega.IdSucursal AND in_INV_Rpt010.IdBodega = tb_bodega.IdBodega
						inner join in_UnidadMedida on in_UnidadMedida.IdUnidadMedida = in_Producto.IdUnidadMedida_Consumo
						WHERE NOT EXISTS(
						SELECT cab.IdEmpresa FROM in_movi_inve cab inner join in_movi_inve_detalle det
						on cab.IdEmpresa = det.IdEmpresa
						and cab.IdSucursal = det.IdSucursal
						and cab.IdBodega = det.IdBodega
						and cab.IdMovi_inven_tipo = det.IdMovi_inven_tipo
						and cab.IdNumMovi = det.IdNumMovi
						where cab.cm_fecha between @Fecha_ini and @Fecha_fin
						and det.IdEmpresa = in_INV_Rpt010.IdEmpresa
						and det.IdSucursal = in_INV_Rpt010.IdSucursal
						and det.IdBodega = in_INV_Rpt010.IdBodega
						and det.IdProducto = in_INV_Rpt010.IdProducto
						)
						and @IdUsuario =in_INV_Rpt010.IdUsuario and @Mostrar_detallado = 1
						UNION						
						SELECT       in_INV_Rpt010.IdEmpresa, in_INV_Rpt010.IdSucursal, in_INV_Rpt010.IdBodega, null, null, null, in_INV_Rpt010.IdProducto
									,in_INV_Rpt010.Saldo_ini_cant
									,(in_INV_Rpt010.Saldo_ini_cost / iif(in_INV_Rpt010.Saldo_ini_cant=0,1,in_INV_Rpt010.Saldo_ini_cant)) Cost_prom_ini, in_INV_Rpt010.Saldo_ini_cost
									,in_INV_Rpt010.mov_ing_cant cant_ing
									,in_INV_Rpt010.mov_ing_cost / iif(in_INV_Rpt010.mov_ing_cant = 0 , 1,in_INV_Rpt010.mov_ing_cant) cost_ing
									,in_INV_Rpt010.mov_ing_cost  total_ing
									,in_INV_Rpt010.mov_egr_cant cant_egr
									,in_INV_Rpt010.mov_egr_cost / iif(in_INV_Rpt010.mov_egr_cant = 0 , 1,in_INV_Rpt010.mov_egr_cant) cost_egr				
									,in_INV_Rpt010.mov_egr_cost total_egr
									,in_INV_Rpt010.Saldo_ini_cant Saldo_cant
									,(in_INV_Rpt010.Saldo_ini_cost / iif(in_INV_Rpt010.Saldo_ini_cant=0,1,in_INV_Rpt010.Saldo_ini_cant)) as Saldo_cost_prom
									,in_INV_Rpt010.Saldo_ini_cost Saldo_cost
									,in_INV_Rpt010.Saldo_fin_cant,(in_INV_Rpt010.Saldo_fin_cost / iif(in_INV_Rpt010.Saldo_fin_cant=0,1,in_INV_Rpt010.Saldo_fin_cant)) Cost_prom_fin, in_INV_Rpt010.Saldo_fin_cost
									,in_INV_Rpt010.IdUsuario, '', @Fecha_ini, '' as tipo_movi, tb_bodega.cod_bodega, tb_bodega.bo_Descripcion AS nom_bodega, 
									tb_sucursal.codigo AS cod_sucursal, tb_sucursal.Su_Descripcion AS nom_sucursal, null, null, 
									null, null AS num_factura, null AS nom_proveedor, in_Producto.pr_codigo, 
									in_Producto.pr_descripcion, in_UnidadMedida.IdUnidadMedida, in_UnidadMedida.Descripcion as nom_unidad_consumo, in_UnidadMedida.cod_alterno as cod_unidad_consumo
						FROM            in_INV_Rpt010 INNER JOIN
								in_Producto ON in_INV_Rpt010.IdEmpresa = in_Producto.IdEmpresa AND in_INV_Rpt010.IdProducto = in_Producto.IdProducto INNER JOIN
								tb_sucursal INNER JOIN
								tb_bodega ON tb_sucursal.IdEmpresa = tb_bodega.IdEmpresa AND tb_sucursal.IdSucursal = tb_bodega.IdSucursal ON 
								in_INV_Rpt010.IdEmpresa = tb_bodega.IdEmpresa AND in_INV_Rpt010.IdSucursal = tb_bodega.IdSucursal AND in_INV_Rpt010.IdBodega = tb_bodega.IdBodega
								inner join in_UnidadMedida on in_UnidadMedida.IdUnidadMedida = in_Producto.IdUnidadMedida_Consumo
						WHERE in_INV_Rpt010.IdUsuario = @IdUsuario 
						and @Mostrar_detallado = 0
						and tb_bodega.IdEmpresa=@IdEmpresa
						and tb_bodega.IdSucursal between @IdSucursal_ini and @IdSucursal_fin
						and tb_bodega.IdBodega between @IdBodega_ini and @IdBodega_fin
	


		) A ORDER BY A.IdEmpresa,A.IdSucursal,A.IdBodega,A.IdProducto,A.cm_fecha,A.cant_ing desc , A.cant_egr 


END