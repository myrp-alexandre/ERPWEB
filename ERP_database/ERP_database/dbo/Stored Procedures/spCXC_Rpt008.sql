-- =============================================
-- Author:		<Luis Aguiño>
-- Create date: <28/04/2015>
-- Description:	<Estado de Cartera Vencida y x Vencer>
-- =============================================
CREATE PROCEDURE [dbo].[spCXC_Rpt008] 
	@IdEmpresa as int,	
	@SucursalIni as int,
	@SucursalFin as int,	
	@fechaCorte as datetime    
AS
BEGIN

	SET NOCOUNT ON;
	
	If(OBJECT_ID('tempdb..#tmp_Cobros_fecha_corte') Is Not Null)
	Begin
		Drop Table #tmp_Cobros_fecha_corte
	End

	If(OBJECT_ID('tempdb..#tmp_Factu_ND_NC_Cobro') Is Not Null)
	Begin
		Drop Table #tmp_Factu_ND_NC_Cobro
	End

	--creo una tabla temporal de los cobros
	select DISTINCT B.IdEmpresa, B.IdSucursal, B.IdBodega , B.IdCbteVta, B.vt_tipoDoc, B.IdCobro, B.IdCobro_tipo,  B.dc_TipoDocumento , B.vt_total
	into #tmp_Cobros_fecha_corte
	from vwCXC_Rpt007 B WHERE B.TIPO = 'Cobro' AND B.vt_fech_venc <= @fechaCorte 
		AND B.IdEmpresa = @IdEmpresa AND B.IdSucursal >= @SucursalIni AND B.IdSucursal <= @SucursalFin



 SELECT *  INTO #tmp_Factu_ND_NC_Cobro FROM
(select 1 as Orden, A.IdEmpresa, A.IdSucursal, A.IdBodega , A.IdCbteVta, A.vt_tipoDoc, A.IdCobro_tipo, A.Su_Descripcion, A.pe_nombreCompleto, A.pe_cedulaRuc , A.numDocumento,						 
		   A.IdCliente, A.vt_fecha,  A.vt_fech_venc,  DATEDIFF(day,A.vt_fech_venc, @fechaCorte ) AS DiasVencidos,  A.IdEstadoCobro,
			sum(A.vt_total) as Monto ,

			(SELECT (CASE WHEN SUM(B.vt_total) IS NULL THEN 0 ELSE SUM(B.vt_total) END) FROM #tmp_Cobros_fecha_corte B WHERE B.IdEmpresa = A.IdEmpresa AND B.IdSucursal = A.IdSucursal
		   AND B.IdBodega = IdBodega AND B.IdCbteVta = A.IdCbteVta AND B.vt_tipoDoc = A.vt_tipoDoc ) AS TotalCobrado ,

		   (CASE WHEN DATEDIFF(day,A.vt_fech_venc, @fechaCorte ) > 0 THEN sum(A.vt_total) - (SELECT (CASE WHEN SUM(C.vt_total) IS NULL THEN 0 ELSE SUM(C.vt_total) END) FROM #tmp_Cobros_fecha_corte C WHERE C.IdEmpresa = A.IdEmpresa AND C.IdSucursal = A.IdSucursal
		   AND C.IdBodega = IdBodega AND C.IdCbteVta = A.IdCbteVta AND C.vt_tipoDoc = A.vt_tipoDoc ) ELSE 0  END) Valor_Vencido,

			(CASE WHEN DATEDIFF(day,A.vt_fech_venc, @fechaCorte ) <= 0 THEN sum(A.vt_total) - (SELECT (CASE WHEN SUM(D.vt_total) IS NULL THEN 0 ELSE SUM(D.vt_total) END) FROM #tmp_Cobros_fecha_corte D WHERE D.IdEmpresa = A.IdEmpresa AND D.IdSucursal = A.IdSucursal
		   AND D.IdBodega = IdBodega AND D.IdCbteVta = A.IdCbteVta AND D.vt_tipoDoc = A.vt_tipoDoc ) ELSE 0  END) Valor_x_Vencer,

			A.Tipo    	
	FROM vwCXC_Rpt007 A
	WHERE A.TIPO = 'Cbte_Vta'  AND A.IdEmpresa = @IdEmpresa
	      AND A.IdSucursal >= @SucursalIni AND A.IdSucursal <= @SucursalFin
		  AND A.vt_fecha <= @fechaCorte
	group by A.IdEmpresa, A.IdSucursal, A.IdBodega , A.IdCbteVta, A.vt_tipoDoc, A.numDocumento,						 
		   A.IdCliente, A.vt_fecha, A.vt_fech_venc, 
		   A.Su_Descripcion, A.pe_nombreCompleto, A.pe_cedulaRuc ,    
		   A.Tipo , A.IdEstadoCobro , A.IdCobro_tipo
UNION
(	SELECT 2 as Orden,  A.IdEmpresa, A.IdSucursal, A.IdBodega , A.IdCbteVta, A.vt_tipoDoc, A.IdCobro_Tipo, A.Su_Descripcion, A.pe_nombreCompleto, A.pe_cedulaRuc , A.numDocumento,						 
		   A.IdCliente, A.vt_fecha, A.vt_fech_venc,  DATEDIFF(day,A.vt_fech_venc, @fechaCorte ) AS DiasVencidos, IdEstadoCobro,
		   0 AS Monto , 0 AS TotalCobrado ,
		   (CASE WHEN DATEDIFF(day,A.vt_fech_venc, @fechaCorte ) > 0 THEN sum(A.vt_total)  ELSE 0 END ) AS Valor_Vencido, 
		   (CASE WHEN DATEDIFF(day,A.vt_fech_venc, @fechaCorte ) <= 0 THEN sum(A.vt_total)  ELSE 0 END ) AS Valor_x_Vencer,
		   A.Tipo
	FROM vwCXC_Rpt007 A
	WHERE A.TIPO = 'Cobro'  AND A.IdEmpresa = @IdEmpresa AND A.IdSucursal >= @SucursalIni AND A.IdSucursal <= @SucursalFin
	AND A.vt_fech_venc <= @fechaCorte  AND A.IdEstadoCobro = 'PORC' AND NOT EXISTS  (SELECT B.IdCobro FROM  vwCXC_Rpt007 B WHERE A.IdEmpresa = B.IdEmpresa AND A.IdSucursal = B.IdSucursal 
	AND A.IdCobro = B.IdCobro AND A.IdCobro_tipo = B.IdCobro_tipo AND B.IdEstadoCobro = 'COBR'  ) 
	 GROUP BY  A.IdEmpresa, A.IdSucursal, A.IdBodega , A.IdCbteVta, A.vt_tipoDoc, A.IdCobro_Tipo, A.Su_Descripcion, A.pe_nombreCompleto, A.pe_cedulaRuc , A.numDocumento,						 
		   A.IdCliente, A.vt_fecha, A.vt_fech_venc, IdEstadoCobro, A.Tipo
	UNION ALL
	SELECT 3 as Orden, A.IdEmpresa, A.IdSucursal, A.IdBodega , A.IdCbteVta, A.vt_tipoDoc, A.IdCobro_Tipo, A.Su_Descripcion, A.pe_nombreCompleto, A.pe_cedulaRuc , A.numDocumento,						 
		   A.IdCliente, A.vt_fecha, A.vt_fech_venc,  DATEDIFF(day,A.vt_fech_venc, @fechaCorte ) AS DiasVencidos, IdEstadoCobro,
		   0 as Monto , 0 AS TotalCobrado,   0 AS Valor_Vencido, 0 AS Valor_x_Vencer, A.Tipo
	FROM vwCXC_Rpt007 A
	WHERE A.TIPO = 'Cobro'  AND A.IdEmpresa = @IdEmpresa AND A.IdSucursal >= @SucursalIni AND A.IdSucursal <= @SucursalFin
	AND A.vt_fech_venc <= @fechaCorte AND A.IdEstadoCobro = 'COBR'
	 GROUP BY  A.IdEmpresa, A.IdSucursal, A.IdBodega , A.IdCbteVta, A.vt_tipoDoc, A.IdCobro_Tipo, A.Su_Descripcion, A.pe_nombreCompleto, A.pe_cedulaRuc , A.numDocumento,						 
		   A.IdCliente, A.vt_fecha, A.vt_fech_venc, IdEstadoCobro, A.Tipo
) 
UNION
	select 1 as Orden, A.IdEmpresa, A.IdSucursal, A.IdBodega , A.IdCbteVta, A.vt_tipoDoc, A.IdCobro_tipo, A.Su_Descripcion, A.pe_nombreCompleto, A.pe_cedulaRuc , A.numDocumento,						 
		   A.IdCliente, A.vt_fecha,  A.vt_fech_venc,  DATEDIFF(day,A.vt_fech_venc, @fechaCorte ) AS DiasVencidos,  A.IdEstadoCobro,
		 	sum(A.vt_total) as Monto ,

		  (CASE WHEN SUM(notCxc.Valor_cobro) IS NULL THEN 0 ELSE SUM(notCxc.Valor_cobro) END)  + (SELECT (CASE WHEN SUM(B.vt_total) IS NULL THEN 0 ELSE SUM(B.vt_total) END) FROM #tmp_Cobros_fecha_corte B WHERE B.IdEmpresa = A.IdEmpresa AND B.IdSucursal = A.IdSucursal
		   AND B.IdBodega = IdBodega AND B.IdCbteVta = A.IdCbteVta AND B.vt_tipoDoc = A.vt_tipoDoc ) AS TotalCobrado ,
		   --0 AS TotalCobrado,

		   (CASE WHEN DATEDIFF(day,A.vt_fech_venc, @fechaCorte ) > 0 THEN sum(A.vt_total) - ((SELECT (CASE WHEN SUM(C.vt_total) IS NULL THEN 0 ELSE SUM(C.vt_total) END) FROM #tmp_Cobros_fecha_corte C WHERE C.IdEmpresa = A.IdEmpresa AND C.IdSucursal = A.IdSucursal
		   AND C.IdBodega = IdBodega AND C.IdCbteVta = A.IdCbteVta AND C.vt_tipoDoc = A.vt_tipoDoc ) + (CASE WHEN SUM(notCxc.Valor_cobro) IS NULL THEN 0 ELSE SUM(notCxc.Valor_cobro) END) ) ELSE 0  END) Valor_Vencido,

			(CASE WHEN DATEDIFF(day,A.vt_fech_venc, @fechaCorte ) <= 0 THEN sum(A.vt_total) - ((SELECT (CASE WHEN SUM(D.vt_total) IS NULL THEN 0 ELSE SUM(D.vt_total) END) FROM #tmp_Cobros_fecha_corte D WHERE D.IdEmpresa = A.IdEmpresa AND D.IdSucursal = A.IdSucursal
		   AND D.IdBodega = IdBodega AND D.IdCbteVta = A.IdCbteVta AND D.vt_tipoDoc = A.vt_tipoDoc ) + (CASE WHEN SUM(notCxc.Valor_cobro) IS NULL THEN 0 ELSE SUM(notCxc.Valor_cobro) END) ) ELSE 0  END) Valor_x_Vencer,

			A.Tipo 	
	FROM vwCXC_Rpt007 A LEFT OUTER JOIN
			 dbo.fa_notaCreDeb_x_cxc_cobro AS notCxc ON notCxc.IdEmpresa_nt = A.IdEmpresa AND 
			 notCxc.IdSucursal_nt = A.IdSucursal AND notCxc.IdNota_nt = A.IdCbteVta AND 
			 notCxc.IdBodega_nt = A.IdBodega			 
	WHERE A.TIPO = 'Cbte_Nd_Nc'  AND A.IdEmpresa = @IdEmpresa
	      AND A.IdSucursal >= @SucursalIni AND A.IdSucursal <= @SucursalFin
		  AND A.vt_fecha <= @fechaCorte 
	group by A.IdEmpresa, A.IdSucursal, A.IdBodega , A.IdCbteVta, A.vt_tipoDoc, A.numDocumento,						 
		   A.IdCliente, A.vt_fecha, A.vt_fech_venc, 
		   A.Su_Descripcion, A.pe_nombreCompleto, A.pe_cedulaRuc ,    
		   A.Tipo , A.IdEstadoCobro , A.IdCobro_tipo
) AS q


SELECT IdEmpresa, IdSucursal, IdCliente ,Su_Descripcion , pe_nombreCompleto, pe_cedulaRuc
		, ROUND(SUM(Monto), 2) AS Monto, ROUND(SUM(TotalCobrado), 2) AS TotalCobrado 
		, ROUND(SUM(Valor_Vencido), 2 )AS Valor_Vencido, ROUND(SUM(Valor_x_Vencer), 2) AS Valor_x_Vencer
FROM #tmp_Factu_ND_NC_Cobro
GROUP BY IdEmpresa, IdSucursal, IdCliente ,Su_Descripcion , pe_nombreCompleto, pe_cedulaRuc
order by 1,2,5



END