--exec [dbo].[spINV_aprobacion_ing_egr] 2,8,1,7,11
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
and cab.Estado = 'A'
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
,cab.signo				  ,det.IdProducto				,isnull(det.dm_cantidad_sinConversion,0)				
,det.dm_observacion		  ,isnull(det.mv_costo_sinConversion,0)													,det.IdCentroCosto				,det.IdCentroCosto_sub_centro_costo
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

RETURN @IdNumMovi_apro
END