-- =============================================
-- Author:		<Luis Aguiño>
-- Create date: <04/05/2015>
-- Description:	<Detalle de Dias x vencer >
-- =============================================
CREATE PROCEDURE [dbo].[spCXC_Rpt010]
	@IdEmpresa as int,	
	@SucursalIni as int,
	@SucursalFin as int,	
	@fechaCorte as datetime    
AS
BEGIN

	SET NOCOUNT ON;
	



	If(OBJECT_ID('tempdb..#tmp_Cobros_fecha_corte_SP010') Is Not Null)
	Begin
		Drop Table #tmp_Cobros_fecha_corte_SP010
	End

	If(OBJECT_ID('tempdb..#tmp_Factu_ND_NC_Cobro_SP010') Is Not Null)
	Begin
		Drop Table #tmp_Factu_ND_NC_Cobro_SP010
	End

	If(OBJECT_ID('tempdb..#tmp_Rango_Factu_x_Cliente_SP010') Is Not Null)
	Begin
		Drop Table #tmp_Rango_Factu_x_Cliente_SP010
	End

	--creo una tabla temporal de los cobros
	select DISTINCT B.IdEmpresa, B.IdSucursal, B.IdBodega , B.IdCbteVta, B.vt_tipoDoc, B.IdCobro, B.IdCobro_tipo,  B.dc_TipoDocumento , B.vt_total
	into #tmp_Cobros_fecha_corte_SP010
	from vwCXC_Rpt007 B WHERE B.TIPO = 'Cobro' AND B.vt_fech_venc <= @fechaCorte 
		AND B.IdEmpresa = @IdEmpresa AND B.IdSucursal >= @SucursalIni AND B.IdSucursal <= @SucursalFin



	 SELECT *  INTO #tmp_Factu_ND_NC_Cobro_SP010 FROM
	(select 1 as Orden, A.IdEmpresa, A.IdSucursal, A.IdBodega , A.IdCbteVta, A.vt_tipoDoc, A.IdCobro_tipo, A.Su_Descripcion, A.pe_nombreCompleto, A.pe_cedulaRuc , A.numDocumento,						 
			   A.IdCliente, A.vt_fecha,  A.vt_fech_venc,  DATEDIFF(day,A.vt_fech_venc, @fechaCorte ) AS DiasVencidos,  A.IdEstadoCobro,
				sum(A.vt_total) as Monto ,

				(SELECT (CASE WHEN SUM(B.vt_total) IS NULL THEN 0 ELSE SUM(B.vt_total) END) FROM #tmp_Cobros_fecha_corte_SP010 B WHERE B.IdEmpresa = A.IdEmpresa AND B.IdSucursal = A.IdSucursal
			   AND B.IdBodega = IdBodega AND B.IdCbteVta = A.IdCbteVta AND B.vt_tipoDoc = A.vt_tipoDoc ) AS TotalCobrado ,

			   (CASE WHEN DATEDIFF(day,A.vt_fech_venc, @fechaCorte ) > 0 THEN sum(A.vt_total) - (SELECT (CASE WHEN SUM(C.vt_total) IS NULL THEN 0 ELSE SUM(C.vt_total) END) FROM #tmp_Cobros_fecha_corte_SP010 C WHERE C.IdEmpresa = A.IdEmpresa AND C.IdSucursal = A.IdSucursal
			   AND C.IdBodega = IdBodega AND C.IdCbteVta = A.IdCbteVta AND C.vt_tipoDoc = A.vt_tipoDoc ) ELSE 0  END) Valor_Vencido,

				(CASE WHEN DATEDIFF(day,A.vt_fech_venc, @fechaCorte ) <= 0 THEN sum(A.vt_total) - (SELECT (CASE WHEN SUM(D.vt_total) IS NULL THEN 0 ELSE SUM(D.vt_total) END) FROM #tmp_Cobros_fecha_corte_SP010 D WHERE D.IdEmpresa = A.IdEmpresa AND D.IdSucursal = A.IdSucursal
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

			  (CASE WHEN SUM(notCxc.Valor_cobro) IS NULL THEN 0 ELSE SUM(notCxc.Valor_cobro) END)  + (SELECT (CASE WHEN SUM(B.vt_total) IS NULL THEN 0 ELSE SUM(B.vt_total) END) FROM #tmp_Cobros_fecha_corte_SP010 B WHERE B.IdEmpresa = A.IdEmpresa AND B.IdSucursal = A.IdSucursal
			   AND B.IdBodega = IdBodega AND B.IdCbteVta = A.IdCbteVta AND B.vt_tipoDoc = A.vt_tipoDoc ) AS TotalCobrado ,
			   --0 AS TotalCobrado,

			   (CASE WHEN DATEDIFF(day,A.vt_fech_venc, @fechaCorte ) > 0 THEN sum(A.vt_total) - ((SELECT (CASE WHEN SUM(C.vt_total) IS NULL THEN 0 ELSE SUM(C.vt_total) END) FROM #tmp_Cobros_fecha_corte_SP010 C WHERE C.IdEmpresa = A.IdEmpresa AND C.IdSucursal = A.IdSucursal
			   AND C.IdBodega = IdBodega AND C.IdCbteVta = A.IdCbteVta AND C.vt_tipoDoc = A.vt_tipoDoc ) + (CASE WHEN SUM(notCxc.Valor_cobro) IS NULL THEN 0 ELSE SUM(notCxc.Valor_cobro) END) ) ELSE 0  END) Valor_Vencido,

				(CASE WHEN DATEDIFF(day,A.vt_fech_venc, @fechaCorte ) <= 0 THEN sum(A.vt_total) - ((SELECT (CASE WHEN SUM(D.vt_total) IS NULL THEN 0 ELSE SUM(D.vt_total) END) FROM #tmp_Cobros_fecha_corte_SP010 D WHERE D.IdEmpresa = A.IdEmpresa AND D.IdSucursal = A.IdSucursal
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


		

	select IdEmpresa, IdSucursal, IdCliente , Su_Descripcion ,  replace(rtrim(ltrim(pe_nombreCompleto)), char(9) , '') as pe_nombreCompleto
			, replace(rtrim(ltrim(pe_cedulaRuc)), char(9) , '') as pe_cedulaRuc	, Id_Rango
			, ROUND(SUM(ISNULL(Monto, 0)), 2) AS Monto, ROUND(SUM(ISNULL(TotalCobrado, 0)), 2) AS TotalCobrado 
			, ROUND(SUM(ISNULL(Valor_Vencido, 0)), 2 ) AS Valor_Vencido, ROUND(SUM(ISNULL(Valor_x_Vencer, 0)), 2) AS Valor_x_Vencer
	INTO #tmp_Rango_Factu_x_Cliente_SP010
	 from (
	select fac.IdEmpresa, fac.IdSucursal, fac.IdCliente , fac.Su_Descripcion , fac.pe_nombreCompleto, fac.pe_cedulaRuc, fac.DiasVencidos
			,( CASE WHEN fac.DiasVencidos > 0 THEN (select distinct ran.Id_Rango from cxc_Rango_dias_x_Vencimiento ran 
			where fac.DiasVencidos >=  ran.Valor_Ini  and fac.DiasVencidos <= ran.Valor_Fin) ELSE (select distinct ran.Id_Rango from cxc_Rango_dias_x_Vencimiento ran 
			where fac.DiasVencidos <=  ran.Valor_Ini  and fac.DiasVencidos >= ran.Valor_Fin) END) AS Id_Rango
			, ROUND((Monto), 2) AS Monto, ROUND((TotalCobrado), 2) AS TotalCobrado 
			, ROUND((Valor_Vencido), 2 )AS Valor_Vencido, ROUND((Valor_x_Vencer), 2) AS Valor_x_Vencer
	from #tmp_Factu_ND_NC_Cobro_SP010 fac	
	) as q
	GROUP BY IdEmpresa, IdSucursal, IdCliente , Su_Descripcion ,  replace(rtrim(ltrim(pe_nombreCompleto)), char(9) , '')
			, replace(rtrim(ltrim(pe_cedulaRuc)), char(9) , ''), Id_Rango	


						

	SELECT
		IdEmpresa, IdSucursal, IdCliente ,Su_Descripcion , pe_nombreCompleto, pe_cedulaRuc, 
		SUM(ISNULL(Monto, 0)) AS Monto , sum(TotalCobrado) AS TotalCobrado, sum(Valor_Vencido) AS Valor_Vencido,
		SUM(ISNULL(x_Ven_0_30, 0)) as x_Ven_0_30, 
		SUM(ISNULL(x_Ven_31_60, 0)) as x_Ven_31_60, 
		SUM(ISNULL(x_Ven_61_90, 0)) as x_Ven_61_90, 
		SUM(ISNULL(x_Ven_91_180, 0)) as x_Ven_91_180,
		SUM(ISNULL(x_Ven_181_999, 0)) as x_Ven_181_999	
	FROM 
		(
	(SELECT IdEmpresa, IdSucursal, IdCliente ,Su_Descripcion , pe_nombreCompleto, pe_cedulaRuc, Id_Rango
			, Monto , TotalCobrado, Valor_Vencido,  Valor_x_Vencer
			 
	FROM #tmp_Rango_Factu_x_Cliente_SP010		
	)
		) SOURCE
	PIVOT
		(
			SUM(Valor_x_Vencer) FOR Id_Rango IN (x_Ven_0_30, x_Ven_31_60, x_Ven_61_90, x_Ven_91_180, x_Ven_181_999)
		) AS PIVOTABLE

	GROUP BY IdEmpresa, IdSucursal, IdCliente ,Su_Descripcion ,  pe_nombreCompleto, pe_cedulaRuc
	ORDER BY IdEmpresa, IdSucursal, pe_nombreCompleto




END