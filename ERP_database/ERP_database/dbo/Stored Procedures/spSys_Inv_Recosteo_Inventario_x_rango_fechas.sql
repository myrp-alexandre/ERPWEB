--exec [dbo].[spSys_Inv_Recosteo_Inventario_x_rango_fechas] 1,2,3,'01/01/2016','31/12/2016',5
CREATE proc [dbo].[spSys_Inv_Recosteo_Inventario_x_rango_fechas] 
(
@IdEmpresa int,
@IdSucursal int,
@IdBodega int,
@Fecha_ini datetime,
@Fecha_fin datetime,
@cant_Decimales int
)
AS
BEGIN
/*
DECLARE @IdEmpresa int
DECLARE @IdSucursal int
DECLARE @IdBodega int
DECLARE @Fecha_ini datetime
DECLARE @Fecha_fin datetime
DECLARE @cant_Decimales int

SET @IdEmpresa = 1
SET @IdSucursal = 2
SET @IdBodega = 3
SET @Fecha_ini = '01/01/2016'
SET @Fecha_fin = '31/12/2016'
SET @cant_Decimales = 5
*/
--VARIABLES PARA CURSOR X SUCURSAL X BODEGA X PRODUCTO
	declare @C_IdEmpresa int 
	declare @C_IdSucursal int 
	declare @C_IdBodega int
	declare @C_IdProducto numeric

 --VARIABLES PARA CURSOR X MOVIMIENTO
	declare @C2_IdEmpresa int 
	declare @C2_IdSucursal int 
	declare @C2_IdBodega int 
	declare @C2_cm_fecha datetime
	declare @C2_IdProducto numeric	
	declare @C2_IdMovi_inven_tipo int 
	declare @C2_IdNumMovi numeric
	declare @C2_Secuencia int 
	declare @C2_dm_cantidad float
	declare @C2_mv_costo float

 -- VARIABLES PARA COSTEO
	DECLARE @W_Cantidad_compra float
	DECLARE @W_Costo_compra float
	DECLARE @W_Cantidad_a_la_fecha float
	DECLARE @W_Costo_total_a_la_fecha float
	DECLARE @W_Costo_promedio float
	DECLARE @W_Ult_Costo_promedio float
	DECLARE @W_IdFecha int
	DECLARE @W_Secuencia int

 --ELIMINO LA TABLA DE IN_PRODUCTO_X_TB_BODEGA_COSTO_HISTORICO LOS REGISTROS DE LA SUCURSAL Y BODEGA QUE VOY A RECOSTEAR
	PRINT 'LIMPIAR TABLA'
	DELETE in_producto_x_tb_bodega_Costo_Historico
	where IdEmpresa = @IdEmpresa
	and IdSucursal = @IdSucursal
	and IdBodega = @IdBodega
	and fecha >= @Fecha_ini

	PRINT 'ELIMINO TABLA DE RECOSTEO'
	--LIMPIO LA TABLA DE RECOSTEO 
	delete in_Recosteo_Productos_x_movi_inve_detalle

--RESETEO CAMPOS DE RECOSTEO
	PRINT 'RESETEO CAMPO DE RECOSTEO EN IN_MOVI_INVE'
UPDATE in_movi_inve_detalle set Costeado = 0
where exists(
	SELECT det.IdEmpresa,det.IdSucursal,det.IdBodega,det.IdProducto,cab.cm_fecha, det.dm_cantidad, det.mv_costo FROM in_movi_inve cab inner join in_movi_inve_detalle det
	on cab.IdEmpresa = det.IdEmpresa and cab.IdSucursal = det.IdSucursal and cab.IdBodega = det.IdBodega
	and cab.IdMovi_inven_tipo = det.IdMovi_inven_tipo and cab.IdNumMovi = det.IdNumMovi
	WHERE det.IdEmpresa = @IdEmpresa
	and det.IdSucursal = @IdSucursal
	and det.IdBodega = @IdBodega
	and cab.cm_fecha >= @Fecha_ini
	and in_movi_inve_detalle.IdEmpresa = det.IdEmpresa
	and in_movi_inve_detalle.IdSucursal = det.IdSucursal
	and in_movi_inve_detalle.IdBodega = det.IdBodega
	and in_movi_inve_detalle.IdMovi_inven_tipo = det.IdMovi_inven_tipo
	and in_movi_inve_detalle.IdNumMovi = det.IdNumMovi
	and in_movi_inve_detalle.Secuencia = det.Secuencia
)

--INSERTO EN UNA TABLA TEMPORAL LOS REGISTROS QUE VOY A RECOSTEAR
	PRINT 'INSERTO EN TABLA TEMPORAL LOS REGISTROS QUE VOY A RECOSTEAR'
	insert into in_Recosteo_Productos_x_movi_inve_detalle
	(IdEmpresa,IdSucursal,IdBodega,IdProducto)
	select cab.IdEmpresa,cab.IdSucursal,cab.IdBodega,det.IdProducto 
	from in_movi_inve_detalle det inner join
	in_movi_inve cab on 
	cab.IdEmpresa = det.IdEmpresa 
	and cab.IdSucursal = det.IdSucursal 
	and cab.IdBodega = det.IdBodega 
	and cab.IdMovi_inven_tipo = det.IdMovi_inven_tipo 
	and cab.IdNumMovi = det.IdNumMovi
	where cab.IdEmpresa = @IdEmpresa
	and cab.IdSucursal = @IdSucursal
	and cab.IdBodega = @IdBodega
	and cab.cm_fecha between @Fecha_ini and @Fecha_fin
	group by cab.IdEmpresa,cab.IdSucursal,cab.IdBodega,det.IdProducto


--DECLARO CURSOR POR PRODUCTO
		DECLARE product_cursor CURSOR FOR   
		SELECT  IdEmpresa, IdSucursal, IdBodega, IdProducto
		FROM    in_Recosteo_Productos_x_movi_inve_detalle
		
		OPEN			product_cursor  --ABRO CURSOR
		FETCH NEXT FROM product_cursor 
		INTO			@C_IdEmpresa, @C_IdSucursal, @C_IdBodega, @C_IdProducto

		IF @@FETCH_STATUS <> 0   
		PRINT 'NO HAY DATOS PARA CONTINUAR'       
  
		WHILE @@FETCH_STATUS = 0  
		BEGIN  --DECLARO CURSOR POR MOVIMIENTO DE EL PRODUCTO EN EL PRIMER CURSOR
				DECLARE Movi_Inven_x_product_cursor CURSOR FOR   
					select cab.IdEmpresa,cab.IdSucursal,cab.IdBodega,cab.cm_fecha,det.IdProducto,
					cab.IdMovi_inven_tipo,cab.IdNumMovi,det.Secuencia,dm_cantidad,mv_costo
					from in_movi_inve_detalle det inner join
					in_movi_inve cab on cab.IdEmpresa = det.IdEmpresa and cab.IdSucursal = det.IdSucursal 
					and cab.IdBodega = det.IdBodega and cab.IdMovi_inven_tipo = det.IdMovi_inven_tipo and cab.IdNumMovi = det.IdNumMovi 
					where cab.IdEmpresa = @C_IdEmpresa and cab.IdSucursal = @C_IdSucursal and cab.IdBodega = @C_IdBodega 
					and det.IdProducto = @C_IdProducto and cab.cm_fecha between @Fecha_ini and @Fecha_fin
					ORDER BY cab.IdEmpresa,cab.IdSucursal,cab.IdBodega,det.IdProducto,cab.cm_fecha, det.dm_cantidad desc
				OPEN Movi_Inven_x_product_cursor  
				FETCH NEXT FROM Movi_Inven_x_product_cursor 
				into @C2_IdEmpresa			,@C2_IdSucursal			,@C2_IdBodega		,@C2_cm_fecha			,@C2_IdProducto 
					,@C2_IdMovi_inven_tipo	,@C2_IdNumMovi			,@C2_Secuencia		,@C2_dm_cantidad		,@C2_mv_costo 

				IF @@FETCH_STATUS <> 0   
				PRINT 'NO EXISTE MOVIMIENTO PARA EL PRODUCTO'

				WHILE @@FETCH_STATUS = 0  
				BEGIN 
					SET @W_Cantidad_compra = 0
							SET @W_Costo_compra = 0
							SET @W_Cantidad_a_la_fecha = 0
							SET @W_Ult_Costo_promedio = 0
							SET @W_Secuencia = 0
							SET @W_Costo_promedio = 0
							SET @W_Costo_total_a_la_fecha = 0

					IF(@C2_dm_cantidad > 0) -- SI MOVIMIENTO ES POSITIVO INSERTO EN TABLA DE COSTO HISTORICO
					BEGIN
					
						--CANTIDAD COMPRA
							set @W_Cantidad_compra = @C2_dm_cantidad 
						--COSTO COMPRA
							set @W_Costo_compra = ROUND(@C2_mv_costo ,5)
							PRINT 'OBTENGO STOCK'
						--CANTIDAD Y COSTO A LA FECHA
							SELECT @W_Cantidad_a_la_fecha = SUM(det.dm_cantidad)
							, @W_Costo_total_a_la_fecha = SUM(det.dm_cantidad * det.mv_costo)
							FROM in_movi_inve cab inner join in_movi_inve_detalle det
							on cab.IdEmpresa = det.IdEmpresa and cab.IdSucursal = det.IdSucursal and cab.IdBodega = det.IdBodega
							and cab.IdMovi_inven_tipo = det.IdMovi_inven_tipo and cab.IdNumMovi = det.IdNumMovi
							WHERE det.IdEmpresa = @C2_IdEmpresa and det.IdSucursal = @C2_IdSucursal and det.IdBodega = @C2_IdBodega
							and det.IdProducto = @C2_IdProducto and cab.cm_fecha <= @C2_cm_fecha and Costeado = 1 
							GROUP BY det.IdEmpresa, det.IdSucursal, det.IdBodega, det.IdProducto								
							PRINT 'COSTO PROMEDIO'
						--COSTO PROMEDIO
							SET @W_Ult_Costo_promedio = 
							(
								SELECT top 1 costo FROM in_producto_x_tb_bodega_Costo_Historico
								WHERE IdEmpresa = @C2_IdEmpresa
								and IdSucursal = @C2_IdSucursal
								and IdBodega = @C2_IdBodega
								and IdProducto = @C2_IdProducto
								and fecha <= @C2_cm_fecha
								ORDER BY IdEmpresa,IdSucursal,IdBodega,IdProducto,fecha DESC, Secuencia desc
							)			
							PRINT'CREO IDFECHA'			
						--CREAR IDFECHA
							SET @W_IdFecha = CAST(CAST(YEAR(@C2_cm_fecha) AS VARCHAR) + (REPLICATE('0',2-LEN(MONTH(@C2_cm_fecha))) + CAST(MONTH(@C2_cm_fecha) AS VARCHAR)) + (REPLICATE('0',2-LEN(DAY(@C2_cm_fecha))) + CAST(DAY(@C2_cm_fecha) AS VARCHAR)) AS INT)
						--OBTENER SECUENCIA
							PRINT 'OBTENGO SECUENCIA'
							SELECT @W_Secuencia = max(Secuencia)+1 FROM in_producto_x_tb_bodega_Costo_Historico
							WHERE IdEmpresa = @C2_IdEmpresa
								and IdSucursal = @C2_IdSucursal
								and IdBodega = @C2_IdBodega
								and IdProducto = @C2_IdProducto
								and fecha = @C2_cm_fecha															
						--CORRECCION DE DATA Y CALCULO DE COSTO PROMEDIO
							SET @W_Cantidad_compra = ISNULL(@W_Cantidad_compra,0)
							SET @W_Costo_compra = ISNULL(@W_Costo_compra,0)
							SET @W_Cantidad_a_la_fecha = isnull(@W_Cantidad_a_la_fecha,0)
							SET @W_Ult_Costo_promedio = ISNULL(@W_Ult_Costo_promedio,0)
							SET @W_Secuencia = isnull(@W_Secuencia,1)
							
								BEGIN TRY
							SET @W_Costo_promedio = ((@W_Cantidad_compra * @W_Costo_compra) + @W_Costo_total_a_la_fecha)/ (@W_Cantidad_compra + @W_Cantidad_a_la_fecha)
								END TRY
								BEGIN CATCH
							SET @W_Costo_promedio = @W_Ult_Costo_promedio
								END CATCH

							SET @W_Costo_promedio = abs(@W_Costo_promedio)

						--INSERTO NUEVO COSTO 
						PRINT 'INSERTO NUEVO COSTO'
							INSERT INTO [dbo].[in_producto_x_tb_bodega_Costo_Historico]
							([IdEmpresa]            ,[IdSucursal]           ,[IdBodega]           ,[IdProducto]
							,[IdFecha]	            ,[Secuencia]	        ,[fecha]		
							,[costo]				,[Stock_a_la_fecha]     
							,[Observacion]			,[fecha_trans])
							VALUES
							(
							@C2_IdEmpresa			,@C2_IdSucursal			,@C2_IdBodega			,@C2_IdProducto
							,@W_IdFecha				,@W_Secuencia			,@C2_cm_fecha			
							,@W_Costo_promedio		,@W_Cantidad_a_la_fecha + @C2_dm_cantidad
							,'SU'+CAST(@C2_IdSucursal AS VARCHAR) + ' BO'+CAST( @C2_IdBodega AS VARCHAR) + 'TM'+CAST(@C2_IdMovi_inven_tipo AS VARCHAR)+ 'NM'+CAST(@C2_IdNumMovi AS VARCHAR)
							,GETDATE()
							)
							PRINT 'ACTUALIZO CAMPO DE RECOSTEO'
						--ACTUALIZO CAMPO DE PROCESO DE RECOSTEO
							UPDATE in_movi_inve_detalle set Costeado = 1
							where IdEmpresa = @C2_IdEmpresa
							and IdSucursal = @C2_IdSucursal
							and IdBodega = @C2_IdBodega
							and IdMovi_inven_tipo = @C2_IdMovi_inven_tipo
							and IdNumMovi = @C2_IdNumMovi
							and Secuencia = @C2_Secuencia
							PRINT 'CORRECCION CONTABLE'
/*						--CORRECCION CONTABLE
							UPDATE ct_cbtecble_det set dc_Valor = A.valor_inv
							FROM(
									SELECT        in_movi_inve_detalle_x_ct_cbtecble_det.IdEmpresa_inv, in_movi_inve_detalle_x_ct_cbtecble_det.IdSucursal_inv, 
									in_movi_inve_detalle_x_ct_cbtecble_det.IdBodega_inv, in_movi_inve_detalle_x_ct_cbtecble_det.IdMovi_inven_tipo_inv, 
									in_movi_inve_detalle_x_ct_cbtecble_det.IdNumMovi_inv, in_movi_inve_detalle_x_ct_cbtecble_det.Secuencia_inv, 
									in_movi_inve_detalle_x_ct_cbtecble_det.IdEmpresa_ct, in_movi_inve_detalle_x_ct_cbtecble_det.IdTipoCbte_ct, 
									in_movi_inve_detalle_x_ct_cbtecble_det.IdCbteCble_ct, in_movi_inve_detalle_x_ct_cbtecble_det.secuencia_ct, 
									in_movi_inve_detalle_x_ct_cbtecble_det.Secuencial_reg, ct_cbtecble_det.dc_Valor, 
									ROUND(iif(ct_cbtecble_det.dc_Valor >0 ,
									abs((in_movi_inve_detalle.dm_cantidad * in_movi_inve_detalle.mv_costo)),
									abs((in_movi_inve_detalle.dm_cantidad * in_movi_inve_detalle.mv_costo))*-1),2) valor_inv
									FROM            in_movi_inve_detalle INNER JOIN
									in_movi_inve_detalle_x_ct_cbtecble_det ON in_movi_inve_detalle.IdEmpresa = in_movi_inve_detalle_x_ct_cbtecble_det.IdEmpresa_inv AND 
									in_movi_inve_detalle.IdSucursal = in_movi_inve_detalle_x_ct_cbtecble_det.IdSucursal_inv AND 
									in_movi_inve_detalle.IdBodega = in_movi_inve_detalle_x_ct_cbtecble_det.IdBodega_inv AND 
									in_movi_inve_detalle.IdMovi_inven_tipo = in_movi_inve_detalle_x_ct_cbtecble_det.IdMovi_inven_tipo_inv AND 
									in_movi_inve_detalle.IdNumMovi = in_movi_inve_detalle_x_ct_cbtecble_det.IdNumMovi_inv AND 
									in_movi_inve_detalle.Secuencia = in_movi_inve_detalle_x_ct_cbtecble_det.Secuencia_inv INNER JOIN
									ct_cbtecble_det ON in_movi_inve_detalle_x_ct_cbtecble_det.IdEmpresa_ct = ct_cbtecble_det.IdEmpresa AND 
									in_movi_inve_detalle_x_ct_cbtecble_det.IdTipoCbte_ct = ct_cbtecble_det.IdTipoCbte AND 
									in_movi_inve_detalle_x_ct_cbtecble_det.IdCbteCble_ct = ct_cbtecble_det.IdCbteCble AND 
									in_movi_inve_detalle_x_ct_cbtecble_det.secuencia_ct = ct_cbtecble_det.secuencia
									WHERE in_movi_inve_detalle_x_ct_cbtecble_det.IdEmpresa_inv = @C2_IdEmpresa
									and in_movi_inve_detalle_x_ct_cbtecble_det.IdSucursal_inv = @C2_IdSucursal
									and in_movi_inve_detalle_x_ct_cbtecble_det.IdBodega_inv = @C2_IdBodega
									and in_movi_inve_detalle_x_ct_cbtecble_det.IdMovi_inven_tipo_inv = @C2_IdMovi_inven_tipo
									and in_movi_inve_detalle_x_ct_cbtecble_det.IdNumMovi_inv = @C2_IdNumMovi
									and in_movi_inve_detalle_x_ct_cbtecble_det.Secuencia_inv = @C2_Secuencia) A
								WHERE ct_cbtecble_det.IdEmpresa = a.IdEmpresa_ct
								and ct_cbtecble_det.IdTipoCbte = a.IdTipoCbte_ct
								and ct_cbtecble_det.IdCbteCble = a.IdCbteCble_ct
								and ct_cbtecble_det.secuencia = a.secuencia_ct*/
					END
					ELSE
					BEGIN							
						PRINT 'GET ULTIMO COSTO PROMEDIO'
						--COSTO PROMEDIO
							SET @W_Ult_Costo_promedio = 
							(
								SELECT top 1 costo FROM in_producto_x_tb_bodega_Costo_Historico
								WHERE IdEmpresa = @C2_IdEmpresa
								and IdSucursal = @C2_IdSucursal
								and IdBodega = @C2_IdBodega
								and IdProducto = @C2_IdProducto
								and fecha <= @C2_cm_fecha
								ORDER BY IdEmpresa,IdSucursal,IdBodega,IdProducto,fecha DESC, Secuencia desc
							)		
						--CORRECCION DE DATA Y CALCULO DE COSTO PROMEDIO
								SET @W_Cantidad_compra = ISNULL(@W_Cantidad_compra,0)
								SET @W_Costo_compra = ISNULL(@W_Costo_compra,0)
								SET @W_Cantidad_a_la_fecha = isnull(@W_Cantidad_a_la_fecha,0)
								SET @W_Ult_Costo_promedio = ISNULL(@W_Ult_Costo_promedio,0)		
						--ACTUALIZO CAMPO DE PROCESO DE RECOSTEO
								UPDATE in_movi_inve_detalle  set mv_costo = @W_Ult_Costo_promedio, Costeado = 1
								where IdEmpresa = @C2_IdEmpresa
								and IdSucursal = @C2_IdSucursal
								and IdBodega = @C2_IdBodega
								and IdMovi_inven_tipo = @C2_IdMovi_inven_tipo
								and IdNumMovi = @C2_IdNumMovi
								and Secuencia = @C2_Secuencia



								UPDATE in_Ing_Egr_Inven_det set mv_costo = @W_Ult_Costo_promedio
								where IdEmpresa_inv = @C2_IdEmpresa
								and IdSucursal_inv = @C2_IdSucursal
								and IdBodega_inv = @C2_IdBodega
								and IdMovi_inven_tipo_inv = @C2_IdMovi_inven_tipo
								and IdNumMovi_inv = @C2_IdNumMovi
								and secuencia_inv = @C2_Secuencia

						--CORRECCION CONTABLE
						PRINT 'CORRECCION CONTABLE'
								/*UPDATE ct_cbtecble_det set dc_Valor = A.valor_inv
								FROM(
										SELECT        in_movi_inve_detalle_x_ct_cbtecble_det.IdEmpresa_inv, in_movi_inve_detalle_x_ct_cbtecble_det.IdSucursal_inv, 
										in_movi_inve_detalle_x_ct_cbtecble_det.IdBodega_inv, in_movi_inve_detalle_x_ct_cbtecble_det.IdMovi_inven_tipo_inv, 
										in_movi_inve_detalle_x_ct_cbtecble_det.IdNumMovi_inv, in_movi_inve_detalle_x_ct_cbtecble_det.Secuencia_inv, 
										in_movi_inve_detalle_x_ct_cbtecble_det.IdEmpresa_ct, in_movi_inve_detalle_x_ct_cbtecble_det.IdTipoCbte_ct, 
										in_movi_inve_detalle_x_ct_cbtecble_det.IdCbteCble_ct, in_movi_inve_detalle_x_ct_cbtecble_det.secuencia_ct, 
										in_movi_inve_detalle_x_ct_cbtecble_det.Secuencial_reg, ct_cbtecble_det.dc_Valor, 
										ROUND(iif(ct_cbtecble_det.dc_Valor >0 ,
										abs((in_movi_inve_detalle.dm_cantidad * in_movi_inve_detalle.mv_costo)),
										abs((in_movi_inve_detalle.dm_cantidad * in_movi_inve_detalle.mv_costo))*-1),2) valor_inv
										FROM            in_movi_inve_detalle INNER JOIN
										in_movi_inve_detalle_x_ct_cbtecble_det ON in_movi_inve_detalle.IdEmpresa = in_movi_inve_detalle_x_ct_cbtecble_det.IdEmpresa_inv AND 
										in_movi_inve_detalle.IdSucursal = in_movi_inve_detalle_x_ct_cbtecble_det.IdSucursal_inv AND 
										in_movi_inve_detalle.IdBodega = in_movi_inve_detalle_x_ct_cbtecble_det.IdBodega_inv AND 
										in_movi_inve_detalle.IdMovi_inven_tipo = in_movi_inve_detalle_x_ct_cbtecble_det.IdMovi_inven_tipo_inv AND 
										in_movi_inve_detalle.IdNumMovi = in_movi_inve_detalle_x_ct_cbtecble_det.IdNumMovi_inv AND 
										in_movi_inve_detalle.Secuencia = in_movi_inve_detalle_x_ct_cbtecble_det.Secuencia_inv INNER JOIN
										ct_cbtecble_det ON in_movi_inve_detalle_x_ct_cbtecble_det.IdEmpresa_ct = ct_cbtecble_det.IdEmpresa AND 
										in_movi_inve_detalle_x_ct_cbtecble_det.IdTipoCbte_ct = ct_cbtecble_det.IdTipoCbte AND 
										in_movi_inve_detalle_x_ct_cbtecble_det.IdCbteCble_ct = ct_cbtecble_det.IdCbteCble AND 
										in_movi_inve_detalle_x_ct_cbtecble_det.secuencia_ct = ct_cbtecble_det.secuencia
										WHERE in_movi_inve_detalle_x_ct_cbtecble_det.IdEmpresa_inv = @C2_IdEmpresa
										and in_movi_inve_detalle_x_ct_cbtecble_det.IdSucursal_inv = @C2_IdSucursal
										and in_movi_inve_detalle_x_ct_cbtecble_det.IdBodega_inv = @C2_IdBodega
										and in_movi_inve_detalle_x_ct_cbtecble_det.IdMovi_inven_tipo_inv = @C2_IdMovi_inven_tipo
										and in_movi_inve_detalle_x_ct_cbtecble_det.IdNumMovi_inv = @C2_IdNumMovi
										and in_movi_inve_detalle_x_ct_cbtecble_det.Secuencia_inv = @C2_Secuencia) A
									WHERE ct_cbtecble_det.IdEmpresa = a.IdEmpresa_ct
									and ct_cbtecble_det.IdTipoCbte = a.IdTipoCbte_ct
									and ct_cbtecble_det.IdCbteCble = a.IdCbteCble_ct
									and ct_cbtecble_det.secuencia = a.secuencia_ct
						*/
						--ACTUALIZO EL COSTO DEL INGRESO EN CASO DE QUE ESTE AMARRADO A UNA TRANSFERENCIA
						UPDATE in_movi_inve_detalle set mv_costo = @W_Ult_Costo_promedio
						from(
								SELECT        Egr.IdEmpresa AS IdEmpresa_egr, Egr.IdSucursal AS IdSucursal_egr, Egr.IdBodega AS IdBodega_egr, Egr.IdMovi_inven_tipo AS IdMovi_inven_tipo_egr, Egr.IdNumMovi AS IdNumMovi_egr, 
											Egr.Secuencia AS Secuencia_egr, Egr.IdProducto AS IdProducto_egr, Egr.dm_cantidad AS dm_cantidad_egr, Ing.IdEmpresa AS IdEmpresa_ing, Ing.IdSucursal AS IdSucursal_ing, Ing.IdBodega AS IdBodega_ing, 
											Ing.IdMovi_inven_tipo AS IdMovi_inven_tipo_ing, Ing.IdNumMovi AS IdNumMovi_ing, Ing.Secuencia AS Secuencia_ing, Ing.IdProducto AS IdProducto_ing, Ing.dm_cantidad AS dm_cantidad_ing, 
											in_transferencia.IdEmpresa, in_transferencia.IdSucursalOrigen, in_transferencia.IdBodegaOrigen, in_transferencia.IdTransferencia
								FROM            in_movi_inve_detalle AS Ing INNER JOIN
											in_transferencia INNER JOIN
											in_Ing_Egr_Inven_det AS in_Ing_Egr_Inven_det_1 ON in_transferencia.IdEmpresa_Ing_Egr_Inven_Destino = in_Ing_Egr_Inven_det_1.IdEmpresa AND 
											in_transferencia.IdSucursal_Ing_Egr_Inven_Destino = in_Ing_Egr_Inven_det_1.IdSucursal AND in_transferencia.IdMovi_inven_tipo_SucuDest = in_Ing_Egr_Inven_det_1.IdMovi_inven_tipo AND 
											in_transferencia.IdNumMovi_Ing_Egr_Inven_Destino = in_Ing_Egr_Inven_det_1.IdNumMovi INNER JOIN
											in_Ing_Egr_Inven_det ON in_transferencia.IdEmpresa_Ing_Egr_Inven_Origen = in_Ing_Egr_Inven_det.IdEmpresa AND in_transferencia.IdSucursal_Ing_Egr_Inven_Origen = in_Ing_Egr_Inven_det.IdSucursal AND 
											in_transferencia.IdMovi_inven_tipo_SucuOrig = in_Ing_Egr_Inven_det.IdMovi_inven_tipo AND in_transferencia.IdNumMovi_Ing_Egr_Inven_Origen = in_Ing_Egr_Inven_det.IdNumMovi INNER JOIN
											in_movi_inve_detalle AS Egr ON in_Ing_Egr_Inven_det.IdEmpresa_inv = Egr.IdEmpresa AND in_Ing_Egr_Inven_det.IdSucursal_inv = Egr.IdSucursal AND in_Ing_Egr_Inven_det.IdBodega_inv = Egr.IdBodega AND 
											in_Ing_Egr_Inven_det.IdMovi_inven_tipo_inv = Egr.IdMovi_inven_tipo AND in_Ing_Egr_Inven_det.IdNumMovi_inv = Egr.IdNumMovi AND in_Ing_Egr_Inven_det.secuencia_inv = Egr.Secuencia ON 
											Ing.IdEmpresa = in_Ing_Egr_Inven_det_1.IdEmpresa_inv AND Ing.IdSucursal = in_Ing_Egr_Inven_det_1.IdSucursal_inv AND Ing.IdBodega = in_Ing_Egr_Inven_det_1.IdBodega_inv AND 
											Ing.IdMovi_inven_tipo = in_Ing_Egr_Inven_det_1.IdMovi_inven_tipo_inv AND Ing.IdNumMovi = in_Ing_Egr_Inven_det_1.IdNumMovi_inv AND Ing.Secuencia = in_Ing_Egr_Inven_det_1.secuencia_inv AND 
											Ing.Secuencia = Egr.Secuencia AND Ing.IdProducto = Egr.IdProducto AND Ing.IdEmpresa = Egr.IdEmpresa
								WHERE		Egr.IdEmpresa = @C2_IdEmpresa and Egr.IdSucursal = @C2_IdSucursal and Egr.IdBodega = @C2_IdBodega and egr.IdMovi_inven_tipo = @C2_IdMovi_inven_tipo
											and egr.IdNumMovi = @C2_IdNumMovi and egr.Secuencia = @C2_Secuencia and egr.IdProducto = @C2_IdProducto
								) A
								WHERE A.IdEmpresa_ing = in_movi_inve_detalle.IdEmpresa
								AND A.IdSucursal_ing = in_movi_inve_detalle.IdSucursal
								AND A.IdBodega_ing = in_movi_inve_detalle.IdBodega
								AND A.IdMovi_inven_tipo_ing = in_movi_inve_detalle.IdMovi_inven_tipo
								AND A.IdNumMovi_ing = in_movi_inve_detalle.IdNumMovi
								AND A.Secuencia_ing = in_movi_inve_detalle.Secuencia
								AND A.IdProducto_ing = in_movi_inve_detalle.IdProducto
					END
				FETCH NEXT FROM Movi_Inven_x_product_cursor 
					into @C2_IdEmpresa		,@C2_IdSucursal			,@C2_IdBodega	,@C2_cm_fecha		,@C2_IdProducto 
					,@C2_IdMovi_inven_tipo	,@C2_IdNumMovi	,@C2_Secuencia		,@C2_dm_cantidad 
					,@C2_mv_costo 
				END  
				CLOSE Movi_Inven_x_product_cursor  
				DEALLOCATE Movi_Inven_x_product_cursor
				
		FETCH NEXT FROM product_cursor 
		INTO @C_IdEmpresa, @C_IdSucursal, @C_IdBodega, @C_IdProducto
		END  
		CLOSE product_cursor  --CIERRO CURSOR
		DEALLOCATE product_cursor  
/*
SELECT        IdEmpresa, IdSucursal, IdBodega, IdProducto, IdFecha, Secuencia, fecha, costo, Stock_a_la_fecha, Observacion, fecha_trans
FROM            in_producto_x_tb_bodega_Costo_Historico
WHERE IdEmpresa = @IdEmpresa
AND IdSucursal = @IdSucursal
AND IdBodega = @IdBodega
*/
/*
SELECT det.IdEmpresa,det.IdSucursal,det.IdBodega,det.IdProducto,cab.cm_fecha, det.dm_cantidad, det.mv_costo FROM in_movi_inve cab inner join in_movi_inve_detalle det
on cab.IdEmpresa = det.IdEmpresa and cab.IdSucursal = det.IdSucursal and cab.IdBodega = det.IdBodega
and cab.IdMovi_inven_tipo = det.IdMovi_inven_tipo and cab.IdNumMovi = det.IdNumMovi
WHERE det.IdEmpresa = @IdEmpresa
and det.IdSucursal = @IdSucursal
and det.IdBodega = @IdBodega
and cab.cm_fecha >= @Fecha_ini
order by det.IdEmpresa,det.IdSucursal,det.IdBodega,det.IdProducto,cab.cm_fecha , det.dm_cantidad desc
*/
END