-- exec spCXC_Rpt007  1,1,1,778,'27/07/2016',1

CREATE PROCEDURE [dbo].[spCXC_Rpt007] 
	@IdEmpresa as int,	
	@SucursalIni as int,
	@SucursalFin as int,
	@IdCliente as decimal, 
	@fechaCorte as datetime,
	@i_solo_cbtes_con_saldo bit

AS
BEGIN

/*

declare		@IdEmpresa as int
declare 	@SucursalIni as int
declare 	@SucursalFin as int
declare 	@IdCliente as decimal
declare 	@fechaCorte as datetime    
declare		@i_solo_cbtes_con_saldo bit

set @IdEmpresa =1
set @SucursalIni =1
set @SucursalFin =1
set @IdCliente =705
set @fechaCorte =GETDATE()
set @i_solo_cbtes_con_saldo =1
*/
	
SET NOCOUNT ON;




declare @w_sin_o_con_saldo varchar(50)
set @w_sin_o_con_saldo =''

set @w_sin_o_con_saldo=iif(@i_solo_cbtes_con_saldo=1,'con_saldo','')

delete tbCXC_Rpt007_cbts_vtas

--==================================================================
insert into tbCXC_Rpt007_cbts_vtas
(IdEmpresa	,IdSucursal	,IdBodega	,IdCbteVta	,vt_tipoDoc	,Monto	,TotalCobrado)
select IdEmpresa	,IdSucursal	,IdBodega	,IdCbteVta	,vt_tipoDoc	,Monto	,TotalCobrado
from 
(
		select  A.IdEmpresa, A.IdSucursal, A.IdBodega , A.IdCbteVta, A.vt_tipoDoc,
					sum(A.vt_total) as Monto ,
					( SELECT (CASE WHEN SUM(B.vt_total) IS NULL THEN 0 ELSE SUM(B.vt_total) END) 
					  FROM vwCXC_Rpt007 B 
					  WHERE B.IdEmpresa = A.IdEmpresa 
					  AND B.IdSucursal = A.IdSucursal
					  AND B.IdBodega = IdBodega 
					  AND B.IdCbteVta = A.IdCbteVta 
					  AND B.vt_tipoDoc = A.vt_tipoDoc 
					  and B.Tipo='Cobro'
					  and B.IdEstadoCobro='COBR'
					 ) 
					 AS TotalCobrado 
			FROM vwCXC_Rpt007 A
			WHERE A.TIPO = 'Cbte_Vta'  AND A.IdEmpresa = @IdEmpresa
				  AND A.IdSucursal >= @SucursalIni AND A.IdSucursal <= @SucursalFin
				  AND A.vt_fecha <= @fechaCorte
				  AND A.IdCliente = @IdCliente
			group by A.IdEmpresa, A.IdSucursal, A.IdBodega , A.IdCbteVta, A.vt_tipoDoc

		union

		select  A.IdEmpresa, A.IdSucursal, A.IdBodega , A.IdCbteVta, A.vt_tipoDoc,
					sum(A.vt_total) as Monto ,
					( SELECT (CASE WHEN SUM(B.vt_total) IS NULL THEN 0 ELSE SUM(B.vt_total) END) 
					  FROM vwCXC_Rpt007 B 
					  WHERE B.IdEmpresa = A.IdEmpresa AND B.IdSucursal = A.IdSucursal
					  AND B.IdBodega = IdBodega 
					  AND B.IdCbteVta = A.IdCbteVta 
					  AND B.vt_tipoDoc = A.vt_tipoDoc 
					  and B.Tipo='Cobro'
					  and B.IdEstadoCobro='COBR'
					 ) 
					 AS TotalCobrado 
			FROM vwCXC_Rpt007 A
			WHERE A.TIPO = 'Cbte_Nd_Nc'  AND A.IdEmpresa = @IdEmpresa
				  AND A.IdSucursal >= @SucursalIni AND A.IdSucursal <= @SucursalFin
				  AND A.vt_fecha <= @fechaCorte
				  AND A.IdCliente = @IdCliente
				  and A.dc_TipoDocumento='NTDB'
			group by A.IdEmpresa, A.IdSucursal, A.IdBodega , A.IdCbteVta, A.vt_tipoDoc
) as A
where iif(round(ROUND(A.Monto,2)-round(A.TotalCobrado,2),2)=0,'sin_saldo','con_saldo') like '%' + @w_sin_o_con_saldo + '%'


--==================================================================


--select * from tbCXC_Rpt007_cbts_vtas

--return

	
	delete tbCXC_Rpt007_x_COBROS 

	
	
	
		insert into tbCXC_Rpt007_x_COBROS 
		(IdEmpresa, IdSucursal, IdBodega , IdCbteVta, vt_tipoDoc, IdCobro, IdCobro_tipo,  dc_TipoDocumento , vt_total)
		select DISTINCT B.IdEmpresa, B.IdSucursal, B.IdBodega , B.IdCbteVta, B.vt_tipoDoc, B.IdCobro, B.IdCobro_tipo,  B.dc_TipoDocumento , B.vt_total
		from vwCXC_Rpt007 B ,tbCXC_Rpt007_cbts_vtas C 
		WHERE 
			B.IdEmpresa=C.IdEmpresa
		and B.IdSucursal=C.IdSucursal
		and B.IdBodega=C.IdBodega
		and B.IdCbteVta=C.IdCbteVta
		and B.vt_tipoDoc=C.vt_tipoDoc
		and B.TIPO = 'Cobro' AND B.vt_fech_venc <= @fechaCorte 
		AND B.IdEmpresa = @IdEmpresa AND B.IdSucursal >= @SucursalIni AND B.IdSucursal <= @SucursalFin
		AND B.IdCliente = @IdCliente


	
	--saco todas las facturas con sus valores
	
	select 1 as Orden, A.IdEmpresa, A.IdSucursal, A.IdBodega , A.IdCbteVta, A.vt_tipoDoc, A.IdCobro_tipo, A.Su_Descripcion, A.pe_nombreCompleto, A.pe_cedulaRuc , A.numDocumento ,						 
		   A.IdCliente, A.vt_fecha,  A.vt_fech_venc,  DATEDIFF(day,A.vt_fech_venc, @fechaCorte ) AS DiasVencidos,  A.IdEstadoCobro,
			sum(A.vt_total) as Monto ,

			( SELECT (CASE WHEN SUM(B.vt_total) IS NULL THEN 0 ELSE SUM(B.vt_total) END) 
			  FROM tbCXC_Rpt007_x_COBROS B 
			  WHERE B.IdEmpresa = A.IdEmpresa AND B.IdSucursal = A.IdSucursal
		      AND B.IdBodega = IdBodega 
			  AND B.IdCbteVta = A.IdCbteVta 
			  AND B.vt_tipoDoc = A.vt_tipoDoc 
			 ) 
			 AS TotalCobrado ,

		   (CASE WHEN DATEDIFF(day,A.vt_fech_venc, @fechaCorte ) > 0 THEN sum(A.vt_total) - (SELECT (CASE WHEN SUM(C.vt_total) IS NULL THEN 0 ELSE SUM(C.vt_total) END) FROM tbCXC_Rpt007_x_COBROS C WHERE C.IdEmpresa = A.IdEmpresa AND C.IdSucursal = A.IdSucursal
		   AND C.IdBodega = IdBodega AND C.IdCbteVta = A.IdCbteVta AND C.vt_tipoDoc = A.vt_tipoDoc ) ELSE 0  END) Valor_Vencido,

			(CASE WHEN DATEDIFF(day,A.vt_fech_venc, @fechaCorte ) <= 0 THEN sum(A.vt_total) - (SELECT (CASE WHEN SUM(D.vt_total) IS NULL THEN 0 ELSE SUM(D.vt_total) END) FROM tbCXC_Rpt007_x_COBROS D WHERE D.IdEmpresa = A.IdEmpresa AND D.IdSucursal = A.IdSucursal
		   AND D.IdBodega = IdBodega AND D.IdCbteVta = A.IdCbteVta AND D.vt_tipoDoc = A.vt_tipoDoc ) ELSE 0  END) Valor_x_Vencer,



			A.Tipo    
			,cast(A.IdEmpresa as varchar(20)) +'-'+ cast(A.IdSucursal as varchar(20)) +'-'+ cast(A.IdBodega as varchar(20)) +'-'+ cast(A.IdCbteVta as varchar(20)) +'-'+ A.vt_tipoDoc as Documento_Grupo
	FROM vwCXC_Rpt007 A ,tbCXC_Rpt007_cbts_vtas C 
	WHERE 
			
			A.IdEmpresa=C.IdEmpresa
		and A.IdSucursal=C.IdSucursal
		and A.IdBodega=C.IdBodega
		and A.IdCbteVta=C.IdCbteVta
		and A.vt_tipoDoc=C.vt_tipoDoc

		and A.TIPO = 'Cbte_Vta'  AND A.IdEmpresa = @IdEmpresa
		AND A.IdSucursal >= @SucursalIni AND A.IdSucursal <= @SucursalFin
		AND A.vt_fecha <= @fechaCorte AND A.IdCliente = @IdCliente
	group by A.IdEmpresa, A.IdSucursal, A.IdBodega , A.IdCbteVta, A.vt_tipoDoc, A.numDocumento,						 
		   A.IdCliente, A.vt_fecha, A.vt_fech_venc, 
		   A.Su_Descripcion, A.pe_nombreCompleto, A.pe_cedulaRuc ,    
		   A.Tipo , A.IdEstadoCobro , A.IdCobro_tipo



	UNION
(	

	SELECT 2 as Orden,  A.IdEmpresa, A.IdSucursal, A.IdBodega , A.IdCbteVta, A.vt_tipoDoc, A.IdCobro_Tipo, A.Su_Descripcion, A.pe_nombreCompleto, A.pe_cedulaRuc , A.numDocumento,						 
		   A.IdCliente, A.vt_fecha, A.vt_fech_venc,  DATEDIFF(day,A.vt_fech_venc, @fechaCorte ) AS DiasVencidos, IdEstadoCobro,
		   sum(A.vt_total) AS Monto , 0 AS TotalCobrado ,
		   (CASE WHEN DATEDIFF(day,A.vt_fech_venc, @fechaCorte ) > 0 THEN sum(A.vt_total)  ELSE 0 END ) AS Valor_Vencido, 
		   (CASE WHEN DATEDIFF(day,A.vt_fech_venc, @fechaCorte ) <= 0 THEN sum(A.vt_total)  ELSE 0 END ) AS Valor_x_Vencer,
		   A.Tipo
		   ,cast(A.IdEmpresa as varchar(20)) +'-'+ cast(A.IdSucursal as varchar(20)) +'-'+ cast(A.IdBodega as varchar(20)) +'-'+ cast(A.IdCbteVta as varchar(20)) +'-'+ A.vt_tipoDoc as Documento_Grupo
	FROM vwCXC_Rpt007 A , tbCXC_Rpt007_cbts_vtas C 
	WHERE 
	
		A.IdEmpresa=C.IdEmpresa
		and A.IdSucursal=C.IdSucursal
		and A.IdBodega=C.IdBodega
		and A.IdCbteVta=C.IdCbteVta
		and A.vt_tipoDoc=C.vt_tipoDoc

	and A.TIPO = 'Cobro' AND A.IdCliente = @IdCliente AND A.IdEmpresa = @IdEmpresa AND A.IdSucursal >= @SucursalIni AND A.IdSucursal <= @SucursalFin
	AND A.vt_fech_venc <= @fechaCorte  
	AND A.IdEstadoCobro = 'PORC' 
	AND NOT EXISTS  (SELECT B.IdCobro FROM  vwCXC_Rpt007 B WHERE A.IdEmpresa = B.IdEmpresa AND A.IdSucursal = B.IdSucursal 
	AND A.IdCobro = B.IdCobro AND A.IdCobro_tipo = B.IdCobro_tipo AND B.IdEstadoCobro = 'COBR'  ) 
	 GROUP BY  A.IdEmpresa, A.IdSucursal, A.IdBodega , A.IdCbteVta, A.vt_tipoDoc, A.IdCobro_Tipo, A.Su_Descripcion, A.pe_nombreCompleto, A.pe_cedulaRuc , A.numDocumento,						 
		   A.IdCliente, A.vt_fecha, A.vt_fech_venc, IdEstadoCobro, A.Tipo
	
	UNION ALL


	SELECT 3 as Orden, A.IdEmpresa, A.IdSucursal, A.IdBodega , A.IdCbteVta, A.vt_tipoDoc, A.IdCobro_Tipo, A.Su_Descripcion, A.pe_nombreCompleto, A.pe_cedulaRuc , A.numDocumento,						 
		   A.IdCliente, A.vt_fecha, A.vt_fech_venc,  DATEDIFF(day,A.vt_fech_venc, @fechaCorte ) AS DiasVencidos, IdEstadoCobro,
		   sum(A.vt_total) as Monto , sum(A.vt_total) AS TotalCobrado,   0 AS Valor_Vencido, 0 AS Valor_x_Vencer, A.Tipo
,cast(A.IdEmpresa as varchar(20)) +'-'+ cast(A.IdSucursal as varchar(20)) +'-'+ cast(A.IdBodega as varchar(20)) +'-'+ cast(A.IdCbteVta as varchar(20)) +'-'+ A.vt_tipoDoc as Documento_Grupo
	FROM vwCXC_Rpt007 A ,tbCXC_Rpt007_cbts_vtas C 
	WHERE 
			A.IdEmpresa=C.IdEmpresa
		and A.IdSucursal=C.IdSucursal
		and A.IdBodega=C.IdBodega
		and A.IdCbteVta=C.IdCbteVta
		and A.vt_tipoDoc=C.vt_tipoDoc
	and A.TIPO = 'Cobro' AND A.IdCliente = @IdCliente AND A.IdEmpresa = @IdEmpresa AND A.IdSucursal >= @SucursalIni AND A.IdSucursal <= @SucursalFin
	AND A.vt_fech_venc <= @fechaCorte AND A.IdEstadoCobro = 'COBR'
	 GROUP BY  A.IdEmpresa, A.IdSucursal, A.IdBodega , A.IdCbteVta, A.vt_tipoDoc, A.IdCobro_Tipo, A.Su_Descripcion, A.pe_nombreCompleto, A.pe_cedulaRuc , A.numDocumento,						 
		   A.IdCliente, A.vt_fecha, A.vt_fech_venc, IdEstadoCobro, A.Tipo


) 



UNION

	select 1 as Orden, A.IdEmpresa, A.IdSucursal, A.IdBodega , A.IdCbteVta, A.vt_tipoDoc, A.IdCobro_tipo, A.Su_Descripcion, A.pe_nombreCompleto, A.pe_cedulaRuc , A.numDocumento,						 
		   A.IdCliente, A.vt_fecha,  A.vt_fech_venc,  DATEDIFF(day,A.vt_fech_venc, @fechaCorte ) AS DiasVencidos,  A.IdEstadoCobro,
		   round(sum(A.vt_total),2) as Monto ,

			(SELECT (CASE WHEN round(SUM(B.vt_total),2) IS NULL THEN 0 ELSE round(SUM(B.vt_total),2) END) FROM tbCXC_Rpt007_x_COBROS B 
			WHERE B.IdEmpresa = A.IdEmpresa AND B.IdSucursal = A.IdSucursal
		   AND B.IdBodega = IdBodega AND B.IdCbteVta = A.IdCbteVta AND B.vt_tipoDoc = A.vt_tipoDoc ) AS TotalCobrado ,
		   (CASE WHEN DATEDIFF(day,A.vt_fech_venc, @fechaCorte ) > 0 THEN round(sum(A.vt_total),2) - (SELECT (CASE WHEN round(SUM(C.vt_total),2) IS NULL THEN 0 ELSE round(SUM(C.vt_total),2) END) FROM tbCXC_Rpt007_x_COBROS C WHERE C.IdEmpresa = A.IdEmpresa AND C.IdSucursal = A.IdSucursal
		   AND C.IdBodega = IdBodega AND C.IdCbteVta = A.IdCbteVta AND C.vt_tipoDoc = A.vt_tipoDoc ) ELSE 0  END) Valor_Vencido,

			(CASE WHEN DATEDIFF(day,A.vt_fech_venc, @fechaCorte ) <= 0 THEN round(sum(A.vt_total),2) - (SELECT (CASE WHEN round(SUM(D.vt_total),2) IS NULL THEN 0 ELSE round(SUM(D.vt_total),2) END) FROM tbCXC_Rpt007_x_COBROS D WHERE D.IdEmpresa = A.IdEmpresa AND D.IdSucursal = A.IdSucursal
		   AND D.IdBodega = IdBodega AND D.IdCbteVta = A.IdCbteVta AND D.vt_tipoDoc = A.vt_tipoDoc ) ELSE 0  END) Valor_x_Vencer,
				A.Tipo  
				,cast(A.IdEmpresa as varchar(20)) +'-'+ cast(A.IdSucursal as varchar(20)) +'-'+ cast(A.IdBodega as varchar(20)) +'-'+ cast(A.IdCbteVta as varchar(20)) +'-'+ A.vt_tipoDoc as Documento_Grupo  
	FROM vwCXC_Rpt007 A ,tbCXC_Rpt007_cbts_vtas C 
	WHERE 
				A.IdEmpresa=C.IdEmpresa
			and A.IdSucursal=C.IdSucursal
			and A.IdBodega=C.IdBodega
			and A.IdCbteVta=C.IdCbteVta
			and A.vt_tipoDoc=C.vt_tipoDoc

			and A.TIPO = 'Cbte_Nd_Nc' AND A.IdCliente = @IdCliente  AND A.IdEmpresa = @IdEmpresa
			AND A.IdSucursal >= @SucursalIni AND A.IdSucursal <= @SucursalFin
			AND A.vt_fecha <= @fechaCorte 
	group by A.IdEmpresa, A.IdSucursal, A.IdBodega , A.IdCbteVta, A.vt_tipoDoc, A.numDocumento,						 
		   A.IdCliente, A.vt_fecha, A.vt_fech_venc, 
		   A.Su_Descripcion, A.pe_nombreCompleto, A.pe_cedulaRuc ,    
		   A.Tipo , A.IdEstadoCobro , A.IdCobro_tipo
	ORDER BY 2,3,4,12,5,6,1,7, 13
	
	
end