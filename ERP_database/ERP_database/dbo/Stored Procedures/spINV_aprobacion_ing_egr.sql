CREATE PROCEDURE [dbo].[spINV_aprobacion_ing_egr]
(
@IdEmpresa int,
@IdSucursal int,
@IdBodega int,
@IdMovi_inven_tipo int,
@IdNumMovi numeric
)
AS
BEGIN

BEGIN --VARIABLES
PRINT 'VARIABLES'
DECLARE @IdNumMovi_apro numeric,
@Genera_Diario_Contable varchar(1),
@Cuenta_costo_de varchar(30),
@Cuenta_inventario_de varchar(30),
@IdTipoCbte int,
@IdCbteCble numeric,
@signo varchar(1),
@fecha date
END

BEGIN --GET ID IN_MOVI_INVE
PRINT 'GET ID IN_MOVI_INVE'
select @IdNumMovi_apro = MAX(IdNumMovi)+1 from in_movi_inve 
where IdEmpresa = @IdEmpresa
AND IdSucursal = @IdSucursal
AND IdBodega = @IdBodega
AND IdMovi_inven_tipo = @IdMovi_inven_tipo

SET @IdNumMovi_apro = ISNULL(@IdNumMovi_apro,1)
END
/*
BEGIN --CORRECCION DE COSTO
PRINT 'CORRECCION DE COSTO'
SELECT @signo = signo, @fecha = cm_fecha
FROM in_Ing_Egr_Inven
where IdEmpresa = @IdEmpresa
and IdSucursal = @IdSucursal
and IdMovi_inven_tipo = @IdMovi_inven_tipo
and IdNumMovi = @IdNumMovi

IF(@signo = '-')
	BEGIN
		update in_Ing_Egr_Inven_det set mv_costo_sinConversion = C.costo
		from(
			SELECT det.IdEmpresa, det.IdSucursal, det.IdMovi_inven_tipo, det.IdNumMovi, det.Secuencia, ISNULL(costo_prom.costo,0) costo
			FROM in_Ing_Egr_Inven_det det left join (
			select fila, IdEmpresa,IdSucursal,IdBodega,IdProducto, costo from (
			SELECT ROW_NUMBER() over(partition by IdEmpresa,IdSucursal,IdBodega,IdProducto order by IdEmpresa,IdSucursal,IdBodega,IdProducto,fecha DESC, Secuencia desc) as fila, IdEmpresa,IdSucursal,IdBodega,IdProducto, costo 
			FROM in_producto_x_tb_bodega_Costo_Historico							
			WHERE IdEmpresa = @IdEmpresa and IdSucursal = @IdSucursal and IdBodega = @IdBodega and fecha <= @fecha
			) A where a.fila = 1
			) costo_prom on det.IdEmpresa = costo_prom.IdEmpresa and costo_prom.IdSucursal = det.IdSucursal and det.IdBodega = costo_prom.IdBodega and det.IdProducto = costo_prom.IdProducto
		) C where in_Ing_Egr_Inven_det.IdEmpresa = c.IdEmpresa and in_Ing_Egr_Inven_det.IdSucursal = C.IdSucursal and in_Ing_Egr_Inven_det.IdMovi_inven_tipo = c.IdMovi_inven_tipo and in_Ing_Egr_Inven_det.IdNumMovi = c.IdNumMovi and in_Ing_Egr_Inven_det.Secuencia = c.Secuencia
	END
END
*/
BEGIN --CONVERSION DE UNIDAD DE MEDIDA
PRINT 'CONVERSION DE UNIDAD DE MEDIDA'
update in_Ing_Egr_Inven_det set mv_costo = C.costo_convertido, dm_cantidad = C.cantidad_convertida
FROM(
SELECT        det.IdEmpresa, det.IdSucursal, det.IdMovi_inven_tipo, det.IdNumMovi, det.Secuencia, 
equiv.valor_equiv * det.mv_costo_sinConversion costo_convertido, equiv.valor_equiv * det.dm_cantidad_sinConversion as cantidad_convertida
FROM            in_Ing_Egr_Inven_det AS det INNER JOIN
            in_Producto AS p ON det.IdEmpresa = p.IdEmpresa AND det.IdProducto = p.IdProducto INNER JOIN
            in_UnidadMedida_Equiv_conversion AS equiv ON det.IdUnidadMedida_sinConversion = equiv.IdUnidadMedida AND p.IdUnidadMedida_Consumo = equiv.IdUnidadMedida_equiva
			WHERE det.IdEmpresa = @IdEmpresa and det.IdSucursal = @IdSucursal and det.IdBodega = @IdBodega and IdMovi_inven_tipo = @IdMovi_inven_tipo and IdNumMovi = @IdNumMovi
) C where in_Ing_Egr_Inven_det.IdEmpresa = c.IdEmpresa and in_Ing_Egr_Inven_det.IdSucursal = C.IdSucursal and in_Ing_Egr_Inven_det.IdMovi_inven_tipo = c.IdMovi_inven_tipo and in_Ing_Egr_Inven_det.IdNumMovi = c.IdNumMovi and in_Ing_Egr_Inven_det.Secuencia = c.Secuencia
END

BEGIN --GENERAR IN_MOVI_INVE
PRINT 'GENERAR IN_MOVI_INVE'
INSERT INTO [dbo].[in_movi_inve]           
([IdEmpresa]				,[IdSucursal]           ,[IdBodega]							,[IdMovi_inven_tipo]				,[IdNumMovi]
,[CodMoviInven]				,[cm_tipo]              ,[cm_observacion]					,[cm_fecha]							,[Fecha_Transac]			
,[Estado]					,[IdCentroCosto]		,[IdCentroCosto_sub_centro_costo]   ,[IdMotivo_Inv])
SELECT        
det.IdEmpresa				,det.IdSucursal			,det.IdBodega			,det.IdMovi_inven_tipo				,@IdNumMovi_apro
,cab.CodMoviInven			,cab.signo				,cab.cm_observacion		,cab.cm_fecha						,GETDATE()
,'A'						,DET.IdCentroCosto		,DET.IdCentroCosto_sub_centro_costo	,cab.IdMotivo_Inv
FROM            in_Ing_Egr_Inven AS cab INNER JOIN in_Ing_Egr_Inven_det AS det 
				ON cab.IdEmpresa = det.IdEmpresa AND cab.IdSucursal = det.IdSucursal 
				AND cab.IdMovi_inven_tipo = det.IdMovi_inven_tipo AND cab.IdNumMovi = det.IdNumMovi
WHERE det.IdEmpresa = @IdEmpresa
and det.IdSucursal = @IdSucursal
and det.IdBodega = @IdBodega
and det.IdMovi_inven_tipo = @IdMovi_inven_tipo
and det.IdNumMovi = @IdNumMovi
GROUP BY det.IdEmpresa				,det.IdSucursal			,det.IdBodega			,det.IdMovi_inven_tipo				
,cab.CodMoviInven			,cab.signo				,cab.cm_observacion		,cab.cm_fecha				
,DET.IdCentroCosto		,DET.IdCentroCosto_sub_centro_costo	,cab.IdMotivo_Inv
END

BEGIN --GENERAR IN_MOVI_INVE_DETALLE
PRINT 'GENERAR IN_MOVI_INVE_DETALLE'
INSERT INTO [dbo].[in_movi_inve_detalle]
([IdEmpresa]              ,[IdSucursal]					,[IdBodega]						,[IdMovi_inven_tipo]           ,[IdNumMovi]           ,[Secuencia]
,[mv_tipo_movi]           ,[IdProducto]					,[dm_cantidad]					
,[dm_observacion]         ,[mv_costo]											,[IdCentroCosto]               ,[IdCentroCosto_sub_centro_costo]
,[IdUnidadMedida]         ,[dm_cantidad_sinConversion]  ,[IdUnidadMedida_sinConversion] ,[mv_costo_sinConversion]      ,[IdPunto_cargo]
,[IdPunto_cargo_grupo]    ,[IdMotivo_Inv]	            ,[Costeado])
SELECT        
det.IdEmpresa			  ,det.IdSucursal				,det.IdBodega					,det.IdMovi_inven_tipo			,@IdNumMovi_apro	 ,det.Secuencia
,cab.signo				  ,det.IdProducto				,det.dm_cantidad				
,det.dm_observacion		  ,det.mv_costo													,det.IdCentroCosto				,det.IdCentroCosto_sub_centro_costo
,det.IdUnidadMedida		  ,det.dm_cantidad_sinConversion,det.IdUnidadMedida_sinConversion,det.mv_costo_sinConversion	,det.IdPunto_cargo
,det.IdPunto_cargo_grupo  ,det.IdMotivo_Inv				,0
FROM            in_Ing_Egr_Inven AS cab INNER JOIN in_Ing_Egr_Inven_det AS det 
				ON cab.IdEmpresa = det.IdEmpresa AND cab.IdSucursal = det.IdSucursal 
				AND cab.IdMovi_inven_tipo = det.IdMovi_inven_tipo AND cab.IdNumMovi = det.IdNumMovi
WHERE det.IdEmpresa = @IdEmpresa
and det.IdSucursal = @IdSucursal
and det.IdBodega = @IdBodega
and det.IdMovi_inven_tipo = @IdMovi_inven_tipo
and det.IdNumMovi = @IdNumMovi
END

BEGIN --ACTUALIZAR IN_ING_EGR CON PK DE IN_MOVI_INVE_DETALLE
PRINT 'ACTUALIZAR IN_ING_EGR CON PK DE IN_MOVI_INVE_DETALLE'
UPDATE in_Ing_Egr_Inven_det
set IdEmpresa_inv = A.IdEmpresa,
IdSucursal_inv = A.IdSucursal,
IdBodega_inv = A.IdBodega,
IdMovi_inven_tipo_inv = A.IdMovi_inven_tipo,
IdNumMovi_inv = A.IdNumMovi,
secuencia_inv = A.Secuencia,
IdEstadoAproba = 'APRO'
FROM (
SELECT det.IdEmpresa, det.IdSucursal, det.IdBodega, det.IdMovi_inven_tipo, det.IdNumMovi, det.Secuencia
FROM in_movi_inve_detalle det
WHERE det.IdEmpresa = @IdEmpresa
and det.IdSucursal = @IdSucursal
and det.IdBodega = @IdBodega
and det.IdMovi_inven_tipo = @IdMovi_inven_tipo
and det.IdNumMovi = @IdNumMovi_apro
) A
WHERE in_Ing_Egr_Inven_det.IdEmpresa = @IdEmpresa
and in_Ing_Egr_Inven_det.IdSucursal = @IdSucursal
and in_Ing_Egr_Inven_det.IdBodega = @IdBodega
and in_Ing_Egr_Inven_det.IdMovi_inven_tipo = @IdMovi_inven_tipo
and in_Ing_Egr_Inven_det.IdNumMovi = @IdNumMovi
and in_Ing_Egr_Inven_det.Secuencia = A.Secuencia
END

BEGIN --SI ES INGRESO REGISTRO COSTO HISTORICO
IF(@signo = '+')
	BEGIN
		INSERT INTO [dbo].[in_producto_x_tb_bodega_Costo_Historico]
				([IdEmpresa]           ,[IdSucursal]           ,[IdBodega]           ,[IdProducto]			     ,[IdFecha]
				,[Secuencia]           ,[fecha]                ,[costo]              ,[Stock_a_la_fecha]          ,[Observacion]
				,[fecha_trans])

		SELECT det.IdEmpresa, det.IdSucursal, det.IdBodega, det.IdProducto, CAST(year(cm_fecha) AS VARCHAR(4)) + RIGHT('00' + CAST(month(cm_fecha) as varchar(2)), 2) + RIGHT('00' + CAST(day(cm_fecha) as varchar(2)), 2),
		isnull(ROW_NUMBER() over(partition by det.IdEmpresa, det.IdSucursal, det.IdBodega, det.IdProducto order by det.IdEmpresa, det.IdSucursal, det.IdBodega, det.IdProducto),0) + ISNULL(costo_prom.Secuencia,0) secuencia_pro
		,cm_fecha, mv_costo, 0, '' , GETDATE()
				FROM 
				in_Ing_Egr_Inven cab inner join
				in_Ing_Egr_Inven_det det 
				on cab.IdEmpresa = det.IdEmpresa and cab.IdSucursal = det.IdSucursal
				and cab.IdMovi_inven_tipo = det.IdMovi_inven_tipo
				and cab.IdNumMovi = det.IdNumMovi left join (
				select fila, IdEmpresa,IdSucursal,IdBodega,IdProducto, Secuencia, costo from (
				SELECT ROW_NUMBER() over(partition by IdEmpresa,IdSucursal,IdBodega,IdProducto order by IdEmpresa,IdSucursal,IdBodega,IdProducto,fecha DESC, Secuencia desc) as fila, IdEmpresa,IdSucursal,IdBodega,IdProducto, Secuencia, costo 
				FROM in_producto_x_tb_bodega_Costo_Historico
				WHERE IdEmpresa = @IdEmpresa and IdSucursal = @IdSucursal and IdBodega = @IdBodega and fecha = @fecha
				) A where a.fila = 1
				) costo_prom on det.IdEmpresa = costo_prom.IdEmpresa and costo_prom.IdSucursal = det.IdSucursal and det.IdBodega = costo_prom.IdBodega and det.IdProducto = costo_prom.IdProducto
		where cab.IdEmpresa = @IdEmpresa and cab.IdSucursal = @IdSucursal and cab.IdMovi_inven_tipo = @IdMovi_inven_tipo and cab.IdNumMovi = @IdNumMovi and det.IdBodega = @IdBodega
	END
END

BEGIN --VALIDO PARAMETROS PARA CONTABILIZACION
PRINT 'VALIDO PARAMETROS PARA CONTABILIZACION'
SELECT @Genera_Diario_Contable = Genera_Diario_Contable, @IdTipoCbte = IdTipoCbte FROM in_movi_inven_tipo
WHERE IdEmpresa = @IdEmpresa AND IdMovi_inven_tipo = @IdMovi_inven_tipo

IF(@Genera_Diario_Contable = '0')
	RETURN @IdNumMovi_apro

SELECT @Cuenta_costo_de = P_Al_Conta_CtaCosto_Buscar_en, @Cuenta_inventario_de = P_Al_Conta_CtaInven_Buscar_en 
FROM in_parametro
where IdEmpresa = @IdEmpresa
END

BEGIN --GET ID CT_CBTECBLE
PRINT 'GET ID CT_CBTECBLE'
SELECT @IdCbteCble = MAX(IdCbteCble) + 1 FROM ct_cbtecble
WHERE IdEmpresa = @IdEmpresa
and IdTipoCbte = @IdTipoCbte

set @IdCbteCble = isnull(@IdCbteCble,1)
END

BEGIN --GENERA CT_CBTECBLE
PRINT 'GENERA CT_CBTECBLE'
INSERT INTO [dbo].[ct_cbtecble]
           ([IdEmpresa]           ,[IdTipoCbte]           ,[IdCbteCble]           ,[CodCbteCble]							,[IdPeriodo]
           ,[cb_Fecha]            ,[cb_Valor]             ,[cb_Observacion]       ,[cb_Estado]								,[cb_Anio]
           ,[cb_mes]              ,[IdUsuario]            ,[cb_FechaTransac])
SELECT		@IdEmpresa			  ,@IdTipoCbte			  ,@IdCbteCble			  ,'INV -'+CAST(@IdNumMovi AS VARCHAR(20))	,CAST(year(cm_fecha) AS VARCHAR(4)) + RIGHT('00' + CAST(month(cm_fecha) as varchar(2)) , 2) 
			,cm_fecha			  ,0					  ,cm_observacion		  ,'A'										,year(cm_fecha)
			,MONTH(cm_fecha)	  ,'admin'				  ,GETDATE()
FROM	in_Ing_Egr_Inven 
WHERE IdEmpresa = @IdEmpresa
AND IdSucursal = @IdSucursal
AND IdMovi_inven_tipo = @IdMovi_inven_tipo
AND IdNumMovi = @IdNumMovi
END

BEGIN --CREA TABLA TEMPORAL PARA RELACIONAR
PRINT 'CREA TABLA TEMPORAL PARA RELACIONAR'
CREATE TABLE #in_movi_inven_x_cbte_cble  
(
ID int Primary Key Identity(1,1),
--Campos inv
IdEmpresa int,
IdSucursal int,
IdBodega int,
IdMovi_inven_tipo int,
IdNumMovi numeric,
secuencia_inv int,
--Campos ct
IdEmpresa_ct int,
IdTipoCbte int,
IdCbteCble numeric,
--Campos para detalle ct
IdCtaCble varchar(30),
dc_valor float
)
END

BEGIN --GENERA DETALLE DE DIARIO EN TABLA TEMPORAL
PRINT 'GENERA DETALLE DE DIARIO EN TABLA TEMPORAL'
IF(@Cuenta_costo_de = 'CONT_X_CAT_LIN')
	BEGIN
		INSERT INTO #in_movi_inven_x_cbte_cble(IdEmpresa, IdSucursal, IdBodega, IdMovi_inven_tipo, IdNumMovi, secuencia_inv, IdEmpresa_ct, IdTipoCbte, IdCbteCble,  IdCtaCble, dc_valor)
		SELECT        A.IdEmpresa, A.IdSucursal, A.IdBodega, A.IdMovi_inven_tipo, A.IdNumMovi, A.Secuencia, @IdEmpresa, @IdTipoCbte, @IdCbteCble, C.IdCtaCtble_Costo, ABS(ROUND(A.dm_cantidad * A.mv_costo,2))
		FROM            in_movi_inve_detalle AS A INNER JOIN
					in_Producto AS B ON A.IdEmpresa = B.IdEmpresa AND A.IdProducto = B.IdProducto INNER JOIN
					in_categorias AS C ON B.IdEmpresa = C.IdEmpresa AND B.IdCategoria = C.IdCategoria
		WHERE        (A.IdEmpresa = @IdEmpresa) AND (A.IdSucursal = @IdSucursal) AND (A.IdBodega = @IdBodega) AND (A.IdMovi_inven_tipo = @IdMovi_inven_tipo) AND (A.IdNumMovi = @IdNumMovi_apro)
		AND A.mv_costo != 0
	END
IF(@Cuenta_inventario_de = 'CONT_X_CAT_LIN')
	BEGIN
		INSERT INTO #in_movi_inven_x_cbte_cble(IdEmpresa, IdSucursal, IdBodega, IdMovi_inven_tipo, IdNumMovi, secuencia_inv, IdEmpresa_ct, IdTipoCbte, IdCbteCble,  IdCtaCble, dc_valor)
		SELECT        A.IdEmpresa, A.IdSucursal, A.IdBodega, A.IdMovi_inven_tipo, A.IdNumMovi, A.Secuencia, @IdEmpresa, @IdTipoCbte, @IdCbteCble, C.IdCtaCtble_Inve, ABS(ROUND(A.dm_cantidad * A.mv_costo,2))*-1
		FROM            in_movi_inve_detalle AS A INNER JOIN
					in_Producto AS B ON A.IdEmpresa = B.IdEmpresa AND A.IdProducto = B.IdProducto INNER JOIN
					in_categorias AS C ON B.IdEmpresa = C.IdEmpresa AND B.IdCategoria = C.IdCategoria
		WHERE        (A.IdEmpresa = @IdEmpresa) AND (A.IdSucursal = @IdSucursal) AND (A.IdBodega = @IdBodega) AND (A.IdMovi_inven_tipo = @IdMovi_inven_tipo) AND (A.IdNumMovi = @IdNumMovi_apro)
		AND A.mv_costo != 0
	END
END

BEGIN --VALIDO ANTES DE INSERTAR CT_DET
PRINT 'VALIDO ANTES DE INSERTAR CT_DET'
DECLARE @VALIDADOR FLOAT
SELECT @VALIDADOR = ROUND(SUM(dc_valor),2) FROM #in_movi_inven_x_cbte_cble
IF(@VALIDADOR IS NULL)
	BEGIN
		DELETE ct_cbtecble WHERE IdEmpresa = @IdEmpresa AND IdTipoCbte = @IdTipoCbte AND IdCbteCble = @IdCbteCble
		RETURN @IdNumMovi_apro
	END
IF(@VALIDADOR != 0)
	BEGIN
		DELETE ct_cbtecble WHERE IdEmpresa = @IdEmpresa AND IdTipoCbte = @IdTipoCbte AND IdCbteCble = @IdCbteCble
		RETURN @IdNumMovi_apro
	END
END

BEGIN --INSERTO REGISTROS EN CT_CBTECBLE_DET
PRINT 'INSERTO REGISTROS EN CT_CBTECBLE_DET'
INSERT INTO [dbo].[ct_cbtecble_det]
           ([IdEmpresa]           ,[IdTipoCbte]           ,[IdCbteCble]           ,[secuencia]           ,[IdCtaCble]           ,[IdCentroCosto]           ,[IdCentroCosto_sub_centro_costo]
           ,[dc_Valor]           ,[dc_Observacion]           ,[IdPunto_cargo]           ,[IdPunto_cargo_grupo]           ,[dc_para_conciliar])
SELECT IdEmpresa_ct, IdTipoCbte, IdCbteCble, ID, IdCtaCble,	null, null,
		dc_valor				,null,			null,	null,	0
 FROM #in_movi_inven_x_cbte_cble
END

BEGIN --INSERTO REGISTROS EN TABLAS INTERMEDIAS
PRINT 'INSERTO REGISTROS EN TABLAS INTERMEDIAS'
INSERT INTO [dbo].[in_movi_inve_x_ct_cbteCble]
           ([IdEmpresa]           ,[IdSucursal]           ,[IdBodega]           ,[IdMovi_inven_tipo]           ,[IdNumMovi]        ,[IdEmpresa_ct]   ,[IdTipoCbte]           ,[IdCbteCble]
           ,[Observacion])
SELECT IdEmpresa,IdSucursal,IdBodega,IdMovi_inven_tipo,IdNumMovi,IdEmpresa_ct,IdTipoCbte,IdCbteCble,'' 
FROM #in_movi_inven_x_cbte_cble
GROUP BY IdEmpresa,IdSucursal,IdBodega,IdMovi_inven_tipo,IdNumMovi,IdEmpresa_ct,IdTipoCbte,IdCbteCble

INSERT INTO [dbo].[in_movi_inve_detalle_x_ct_cbtecble_det]
           ([IdEmpresa_inv]           ,[IdSucursal_inv]           ,[IdBodega_inv]           ,[IdMovi_inven_tipo_inv]           ,[IdNumMovi_inv]           ,[Secuencia_inv]
           ,[IdEmpresa_ct]           ,[IdTipoCbte_ct]           ,[IdCbteCble_ct]           ,[secuencia_ct]           ,[Secuencial_reg]           ,[observacion])
SELECT IdEmpresa,IdSucursal,IdBodega,IdMovi_inven_tipo,IdNumMovi,secuencia_inv,IdEmpresa_ct,IdTipoCbte,IdCbteCble,ID, ID, '' 
FROM #in_movi_inven_x_cbte_cble
END

DROP TABLE #in_movi_inven_x_cbte_cble

RETURN @IdNumMovi_apro
END