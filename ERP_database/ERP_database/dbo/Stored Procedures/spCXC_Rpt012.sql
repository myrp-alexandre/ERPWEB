
CREATE PROCEDURE [dbo].[spCXC_Rpt012]
	@IdEmpresa as int,	
	@IdCliente as decimal,
	@fechaCorte as datetime
	
AS
BEGIN

	SET NOCOUNT ON;
	
	

	

	---------------------------------
	delete cxc_rpt_tmp_Cobros_fecha_corte_SP012
	--creo una tabla temporal de los cobros
	insert into cxc_rpt_tmp_Cobros_fecha_corte_SP012
	select DISTINCT B.IdEmpresa, B.IdSucursal, B.IdBodega , B.IdCbteVta, B.vt_tipoDoc, B.IdCobro, B.IdCobro_tipo,  B.dc_TipoDocumento , B.vt_total, B.vt_Observacion
	from vwCXC_Rpt007 B WHERE B.TIPO = 'Cobro' AND B.vt_fech_venc <= @fechaCorte 
		AND B.IdEmpresa = @IdEmpresa AND b.IdCliente=@IdCliente


		delete cxc_rpt_tmp_Factu_ND_NC_Cobro_SP012

	INSERT INTO [dbo].[cxc_rpt_tmp_Factu_ND_NC_Cobro_SP012]
           ([Orden]
           ,[IdEmpresa]
           ,[IdSucursal]
           ,[IdBodega]
           ,[IdCbteVta]
           ,[vt_tipoDoc]
           ,[IdCobro_tipo]
           ,[Su_Descripcion]
           ,[pe_nombreCompleto]
           ,[pe_cedulaRuc]
           ,[numDocumento]
           ,[IdCliente]
           ,[vt_fecha]
           ,[vt_fech_venc]
           ,[DiasVencidos]
           ,[IdEstadoCobro]
           ,[Monto]
           ,[TotalCobrado]
           ,[Valor_Vencido]
           ,[Valor_x_Vencer]
           ,[Tipo]
           ,[vt_Observacion])
	 SELECT *
	 FROM
	(select 1 as Orden, A.IdEmpresa, A.IdSucursal, A.IdBodega , A.IdCbteVta, A.vt_tipoDoc, A.IdCobro_tipo, A.Su_Descripcion, A.pe_nombreCompleto, A.pe_cedulaRuc , A.numDocumento,						 
			   A.IdCliente, A.vt_fecha,  A.vt_fech_venc,  DATEDIFF(day,A.vt_fech_venc, @fechaCorte ) AS DiasVencidos,  A.IdEstadoCobro,
				sum(A.vt_total) as Monto,

				(SELECT (CASE WHEN SUM(B.vt_total) IS NULL THEN 0 ELSE SUM(B.vt_total) END) FROM cxc_rpt_tmp_Cobros_fecha_corte_SP012 B WHERE B.IdEmpresa = A.IdEmpresa AND B.IdSucursal = A.IdSucursal
			   AND B.IdBodega = IdBodega AND B.IdCbteVta = A.IdCbteVta AND B.vt_tipoDoc = A.vt_tipoDoc ) AS TotalCobrado ,

			   (CASE WHEN DATEDIFF(day,A.vt_fech_venc, @fechaCorte ) > 0 THEN sum(A.vt_total) - (SELECT (CASE WHEN SUM(C.vt_total) IS NULL THEN 0 ELSE SUM(C.vt_total) END) FROM cxc_rpt_tmp_Cobros_fecha_corte_SP012 C WHERE C.IdEmpresa = A.IdEmpresa AND C.IdSucursal = A.IdSucursal
			   AND C.IdBodega = IdBodega AND C.IdCbteVta = A.IdCbteVta AND C.vt_tipoDoc = A.vt_tipoDoc ) ELSE 0  END) Valor_Vencido,

				(CASE WHEN DATEDIFF(day,A.vt_fech_venc, @fechaCorte ) <= 0 THEN sum(A.vt_total) - (SELECT (CASE WHEN SUM(D.vt_total) IS NULL THEN 0 ELSE SUM(D.vt_total) END) FROM cxc_rpt_tmp_Cobros_fecha_corte_SP012 D WHERE D.IdEmpresa = A.IdEmpresa AND D.IdSucursal = A.IdSucursal
			   AND D.IdBodega = IdBodega AND D.IdCbteVta = A.IdCbteVta AND D.vt_tipoDoc = A.vt_tipoDoc ) ELSE 0  END) Valor_x_Vencer,

				A.Tipo, A.vt_Observacion
		FROM vwCXC_Rpt007 A
		WHERE A.TIPO = 'Cbte_Vta'  AND A.IdEmpresa = @IdEmpresa
			  AND a.IdCliente=@IdCliente
			  AND A.vt_fecha <= @fechaCorte
		group by A.IdEmpresa, A.IdSucursal, A.IdCliente, A.IdBodega , A.IdCbteVta, A.vt_tipoDoc, A.numDocumento,						 
			   A.IdCliente, A.vt_fecha, A.vt_fech_venc, 
			   A.Su_Descripcion, A.pe_nombreCompleto, A.pe_cedulaRuc ,    
			   A.Tipo , A.IdEstadoCobro , A.IdCobro_tipo, A.vt_Observacion



	UNION
		select 1 as Orden, A.IdEmpresa, A.IdSucursal, A.IdBodega , A.IdCbteVta, A.vt_tipoDoc, A.IdCobro_tipo, A.Su_Descripcion, A.pe_nombreCompleto, A.pe_cedulaRuc , A.numDocumento,						 
			   A.IdCliente, A.vt_fecha,  A.vt_fech_venc,  DATEDIFF(day,A.vt_fech_venc, @fechaCorte ) AS DiasVencidos,  A.IdEstadoCobro,
		 		sum(A.vt_total) as Monto ,

			  (CASE WHEN SUM(notCxc.Valor_cobro) IS NULL THEN 0 ELSE SUM(notCxc.Valor_cobro) END)  + (SELECT (CASE WHEN SUM(B.vt_total) IS NULL THEN 0 ELSE SUM(B.vt_total) END) FROM cxc_rpt_tmp_Cobros_fecha_corte_SP012 B WHERE B.IdEmpresa = A.IdEmpresa AND B.IdSucursal = A.IdSucursal
			   AND B.IdBodega = IdBodega AND B.IdCbteVta = A.IdCbteVta AND B.vt_tipoDoc = A.vt_tipoDoc ) AS TotalCobrado ,
			   --0 AS TotalCobrado,

			   (CASE WHEN DATEDIFF(day,A.vt_fech_venc, @fechaCorte ) > 0 THEN sum(A.vt_total) - ((SELECT (CASE WHEN SUM(C.vt_total) IS NULL THEN 0 ELSE SUM(C.vt_total) END) FROM cxc_rpt_tmp_Cobros_fecha_corte_SP012 C WHERE C.IdEmpresa = A.IdEmpresa AND C.IdSucursal = A.IdSucursal
			   AND C.IdBodega = IdBodega AND C.IdCbteVta = A.IdCbteVta AND C.vt_tipoDoc = A.vt_tipoDoc ) + (CASE WHEN SUM(notCxc.Valor_cobro) IS NULL THEN 0 ELSE SUM(notCxc.Valor_cobro) END) ) ELSE 0  END) Valor_Vencido,

				(CASE WHEN DATEDIFF(day,A.vt_fech_venc, @fechaCorte ) <= 0 THEN sum(A.vt_total) - ((SELECT (CASE WHEN SUM(D.vt_total) IS NULL THEN 0 ELSE SUM(D.vt_total) END) FROM cxc_rpt_tmp_Cobros_fecha_corte_SP012 D WHERE D.IdEmpresa = A.IdEmpresa AND D.IdSucursal = A.IdSucursal
			   AND D.IdBodega = IdBodega AND D.IdCbteVta = A.IdCbteVta AND D.vt_tipoDoc = A.vt_tipoDoc ) + (CASE WHEN SUM(notCxc.Valor_cobro) IS NULL THEN 0 ELSE SUM(notCxc.Valor_cobro) END) ) ELSE 0  END) Valor_x_Vencer,

				A.Tipo, A.vt_Observacion
		FROM vwCXC_Rpt007 A LEFT OUTER JOIN
				 dbo.fa_notaCreDeb_x_cxc_cobro AS notCxc ON notCxc.IdEmpresa_nt = A.IdEmpresa AND 
				 notCxc.IdSucursal_nt = A.IdSucursal AND notCxc.IdNota_nt = A.IdCbteVta AND 
				 notCxc.IdBodega_nt = A.IdBodega			 
		WHERE A.TIPO = 'Cbte_Nd_Nc'  AND A.IdEmpresa = @IdEmpresa
			  AND A.IdCliente=@IdCliente
			  AND A.vt_fecha <= @fechaCorte 
		group by A.IdEmpresa, A.IdSucursal, A.IdBodega , A.IdCbteVta, A.vt_tipoDoc, A.numDocumento,						 
			   A.IdCliente, A.vt_fecha, A.vt_fech_venc, 
			   A.Su_Descripcion, A.pe_nombreCompleto, A.pe_cedulaRuc ,    
			   A.Tipo , A.IdEstadoCobro , A.IdCobro_tipo, A.vt_Observacion
	) AS q


	UPDATE [dbo].[cxc_rpt_tmp_Factu_ND_NC_Cobro_SP012]
   SET [Valor_x_Vencer_f] = A.Valor_x_Vencer
      ,[Vencer_30_Dias] = A.Vencer_30_Dias
      ,[Vencer_60_Dias] = A.Vencer_60_Dias
      ,[Vencer_90_Dias] = A.Vencer_90_Dias
      ,[Mayor_a_90Dias] = A.Mayor_a_90Dias
	  from(
							SELECT A.IdEmpresa,A.IdCliente,SUM(A.Valor_x_Vencer) Valor_x_Vencer,SUM(A.Vencer_30_Dias)Vencer_30_Dias,SUM(A.Vencer_60_Dias)Vencer_60_Dias,SUM(A.Vencer_90_Dias)Vencer_90_Dias ,SUM(A.Mayor_a_90Dias)Mayor_a_90Dias
							FROM (
							select      Facturas_y_notas_deb.IdEmpresa ,Facturas_y_notas_deb.IdSucursal,Facturas_y_notas_deb.IdBodega,Facturas_y_notas_deb.IdCliente,Facturas_y_notas_deb.Codigo,Facturas_y_notas_deb.IdCbteVta,Facturas_y_notas_deb.CodCbteVta,Facturas_y_notas_deb.vt_tipoDoc,Facturas_y_notas_deb.vt_serie1,Facturas_y_notas_deb.vt_serie2,
									Facturas_y_notas_deb.vt_NumFactura,Facturas_y_notas_deb.Su_Descripcion,LTRIM(Facturas_y_notas_deb.pe_nombreCompleto) AS pe_nombreCompleto,Facturas_y_notas_deb.pe_cedulaRuc,
									Facturas_y_notas_deb.Valor_Original as Valor_Original,
									isnull(Cobros_x_fac.dc_ValorPago,0) as Total_Pagado,
									IIF( DATEDIFF( day,Facturas_y_notas_deb.vt_fech_venc,@fechaCorte)<0, Facturas_y_notas_deb.Valor_Original - isnull(Cobros_x_fac.dc_ValorPago,0) ,0) Valor_x_Vencer,
									IIF( DATEDIFF( day,Facturas_y_notas_deb.vt_fech_venc,@fechaCorte)>=1 and  DATEDIFF( day,Facturas_y_notas_deb.vt_fech_venc,@fechaCorte )<=30 ,  Facturas_y_notas_deb.Valor_Original -(iif(Cobros_x_fac.IdEstadoCobro='COBR', isnull( Cobros_x_fac.dc_ValorPago,0),0)) ,0) Vencer_30_Dias,
									IIF( DATEDIFF( day,Facturas_y_notas_deb.vt_fech_venc,@fechaCorte )>30 and  DATEDIFF( day,Facturas_y_notas_deb.vt_fech_venc,@fechaCorte )<=60 ,   Facturas_y_notas_deb.Valor_Original - (iif(Cobros_x_fac.IdEstadoCobro='COBR', isnull( Cobros_x_fac.dc_ValorPago,0),0)) ,0) Vencer_60_Dias,
									IIF( DATEDIFF( day,Facturas_y_notas_deb.vt_fech_venc,@fechaCorte )>60 and  DATEDIFF( day,Facturas_y_notas_deb.vt_fech_venc,@fechaCorte )<=90 ,  Facturas_y_notas_deb.Valor_Original -(iif(Cobros_x_fac.IdEstadoCobro='COBR', isnull( Cobros_x_fac.dc_ValorPago,0),0)) ,0) Vencer_90_Dias,
									IIF( DATEDIFF( day,Facturas_y_notas_deb.vt_fech_venc,@fechaCorte )>90,  Facturas_y_notas_deb.Valor_Original - (iif(Cobros_x_fac.IdEstadoCobro='COBR', isnull( Cobros_x_fac.dc_ValorPago,0),0)),0) Mayor_a_90Dias
									,Facturas_y_notas_deb.vt_fech_venc,Facturas_y_notas_deb.vt_fecha,Facturas_y_notas_deb.Idtipo_cliente,DATEDIFF( day,Facturas_y_notas_deb.vt_fech_venc,@fechaCorte ) Dias_Vencidos,
									cast( Facturas_y_notas_deb.Valor_Original-isnull( Cobros_x_fac.dc_ValorPago,0) as numeric(10,2))Total,Facturas_y_notas_deb.pe_telefonoOfic, num_op

							from 
							(
	
									SELECT              F.IdEmpresa, F.IdSucursal, F.IdBodega, dbo.fa_cliente.IdCliente, dbo.fa_cliente.Codigo, F.IdCbteVta, 
														F.CodCbteVta,F.vt_tipoDoc,F.vt_serie1,F.vt_serie2,F.vt_NumFactura, 
														dbo.tb_sucursal.Su_Descripcion, LTRIM(dbo.tb_persona.pe_nombreCompleto) + '/'+ cast( fa_cliente.IdCliente as varchar(20)) as pe_nombreCompleto, dbo.tb_persona.pe_cedulaRuc, SUM( FD.vt_total) Valor_Original,F.vt_fech_venc,
														F.vt_fecha,dbo.fa_cliente.Idtipo_cliente, '/'+ dbo.tb_persona.pe_telfono_Contacto as pe_telefonoOfic,
														A.num_op
									FROM                dbo.fa_factura F INNER JOIN
														dbo.fa_factura_det FD ON F.IdEmpresa = FD.IdEmpresa AND F.IdSucursal = FD.IdSucursal AND 
														F.IdBodega = FD.IdBodega AND F.IdCbteVta = FD.IdCbteVta INNER JOIN
														dbo.fa_cliente ON F.IdEmpresa = dbo.fa_cliente.IdEmpresa AND F.IdCliente = dbo.fa_cliente.IdCliente INNER JOIN
														dbo.tb_persona ON dbo.fa_cliente.IdPersona = dbo.tb_persona.IdPersona INNER JOIN
														dbo.tb_sucursal ON F.IdEmpresa = dbo.tb_sucursal.IdEmpresa LEFT JOIN Grafinpren.fa_factura_graf A ON
															A.IdEmpresa = F.IdEmpresa and A.IdSucursal = F.IdSucursal AND A.IdBodega = F.IdBodega AND A.IdCbteVta = F.IdCbteVta
														and F.Estado='A' 
									WHERE				F.vt_fecha <= @fechaCorte
									GROUP BY            F.IdEmpresa,F.IdSucursal,F.IdBodega, dbo.fa_cliente.IdCliente, dbo.fa_cliente.Codigo,F.IdCbteVta, 
														F.CodCbteVta,F.vt_tipoDoc,F.vt_serie1,F.vt_serie2,F.vt_NumFactura, 
														dbo.tb_sucursal.Su_Descripcion, ltrim(dbo.tb_persona.pe_nombreCompleto) + '/'+ cast( fa_cliente.IdCliente as varchar(20)), dbo.tb_persona.pe_cedulaRuc,F.vt_fech_venc,F.vt_fecha,dbo.fa_cliente.Idtipo_cliente
														,'/'+ dbo.tb_persona.pe_telfono_Contacto, A.num_op 
		
							-- *******************************************************************************************************************************************
							-- notas de debito
							union 

							SELECT			dbo.fa_notaCreDeb.IdEmpresa, dbo.fa_notaCreDeb.IdSucursal, dbo.fa_notaCreDeb.IdBodega, dbo.fa_cliente.IdCliente, dbo.fa_cliente.Codigo, 
										dbo.fa_notaCreDeb.IdNota, dbo.fa_notaCreDeb.CodNota,
									case 
										when  dbo.fa_notaCreDeb.CodDocumentoTipo is null then 'NTDB'
											else  dbo.fa_notaCreDeb.CodDocumentoTipo end as CodDocumentoTipo
										, dbo.fa_notaCreDeb.Serie1, dbo.fa_notaCreDeb.Serie2, 
										isnull( dbo.fa_notaCreDeb.NumNota_Impresa, dbo.fa_notaCreDeb.IdNota), dbo.tb_sucursal.Su_Descripcion, 
										LTRIM(dbo.tb_persona.pe_nombreCompleto) + '/'+ cast( fa_cliente.IdCliente as varchar(20)) , dbo.tb_persona.pe_cedulaRuc, 
										dbo.fa_notaCreDeb_det.sc_total, dbo.fa_notaCreDeb.no_fecha_venc,dbo.fa_notaCreDeb.no_fecha, dbo.fa_cliente.Idtipo_cliente,
										'' +'/'+ dbo.tb_persona.pe_telfono_Contacto as pe_telefonoOfic,A.num_op
							FROM            dbo.fa_notaCreDeb INNER JOIN
										dbo.fa_notaCreDeb_det ON dbo.fa_notaCreDeb.IdEmpresa = dbo.fa_notaCreDeb_det.IdEmpresa AND 
										dbo.fa_notaCreDeb.IdSucursal = dbo.fa_notaCreDeb_det.IdSucursal AND dbo.fa_notaCreDeb.IdBodega = dbo.fa_notaCreDeb_det.IdBodega AND 
										dbo.fa_notaCreDeb.IdNota = dbo.fa_notaCreDeb_det.IdNota INNER JOIN
										dbo.fa_cliente ON dbo.fa_notaCreDeb.IdEmpresa = dbo.fa_cliente.IdEmpresa AND dbo.fa_notaCreDeb.IdCliente = dbo.fa_cliente.IdCliente INNER JOIN
										dbo.tb_sucursal ON dbo.fa_notaCreDeb.IdEmpresa = dbo.tb_sucursal.IdEmpresa INNER JOIN
										dbo.tb_persona ON dbo.fa_cliente.IdPersona = dbo.tb_persona.IdPersona LEFT JOIN Grafinpren.fa_notaCreDeb_graf A ON 
										A.IdEmpresa = fa_notaCreDeb.IdEmpresa and A.IdSucursal = fa_notaCreDeb.IdSucursal and A.IdBodega = fa_notaCreDeb.IdBodega
										and A.IdNota = fa_notaCreDeb.IdNota
							where           dbo.fa_notaCreDeb.CreDeb='D' and dbo.fa_notaCreDeb.no_fecha <= @fechaCorte
										and dbo.fa_notaCreDeb.Estado='A' AND NOT EXISTS(
										SELECT        *
										FROM            fa_notaCreDeb_x_fa_factura_NotaDeb Cruce
										WHERE        Cruce.IdEmpresa_nt = fa_notaCreDeb.IdEmpresa AND Cruce.IdSucursal_nt = fa_notaCreDeb.IdSucursal AND Cruce.IdBodega_nt = fa_notaCreDeb.IdBodega AND Cruce.IdNota_nt = fa_notaCreDeb.IdNota
										)
							GROUP BY		dbo.fa_notaCreDeb.IdEmpresa, dbo.fa_notaCreDeb.IdSucursal, dbo.fa_notaCreDeb.IdBodega, dbo.fa_cliente.IdCliente, dbo.fa_cliente.Codigo, 
										dbo.fa_notaCreDeb.IdNota, dbo.fa_notaCreDeb.CodNota, dbo.fa_notaCreDeb.CodDocumentoTipo, dbo.fa_notaCreDeb.Serie1, dbo.fa_notaCreDeb.Serie2, 
										dbo.fa_notaCreDeb.NumNota_Impresa, dbo.tb_sucursal.Su_Descripcion, 
										LTRIM(dbo.tb_persona.pe_nombreCompleto) + '/'+ cast( fa_cliente.IdCliente as varchar(20)) , dbo.tb_persona.pe_cedulaRuc, 
										dbo.fa_notaCreDeb_det.sc_total, dbo.fa_notaCreDeb.no_fecha_venc,dbo.fa_notaCreDeb.no_fecha,dbo.fa_cliente.Idtipo_cliente,
										'' +'/'+ dbo.tb_persona.pe_telfono_Contacto, a.num_op

							) as  Facturas_y_notas_deb left join
							(

								SELECT                   dbo.cxc_cobro.IdEmpresa, dbo.cxc_cobro.IdSucursal,  dbo.cxc_cobro_det.dc_TipoDocumento, dbo.cxc_cobro_det.IdBodega_Cbte, 
															dbo.cxc_cobro_det.IdCbte_vta_nota, sum(dbo.cxc_cobro_det.dc_ValorPago) as dc_ValorPago ,
															dbo.cxc_cobro_x_EstadoCobro.IdEstadoCobro
								FROM                     dbo.cxc_cobro INNER JOIN
															dbo.cxc_cobro_det ON dbo.cxc_cobro.IdEmpresa = dbo.cxc_cobro_det.IdEmpresa AND dbo.cxc_cobro.IdSucursal = dbo.cxc_cobro_det.IdSucursal AND 
															dbo.cxc_cobro.IdCobro = dbo.cxc_cobro_det.IdCobro INNER JOIN
															dbo.cxc_cobro_x_EstadoCobro ON dbo.cxc_cobro_det.IdEmpresa = dbo.cxc_cobro_x_EstadoCobro.IdEmpresa AND 
															dbo.cxc_cobro_det.IdSucursal = dbo.cxc_cobro_x_EstadoCobro.IdSucursal AND dbo.cxc_cobro_det.IdCobro = dbo.cxc_cobro_x_EstadoCobro.IdCobro
															and dbo.cxc_cobro.cr_estado='A' 
								WHERE					cxc_cobro.cr_fechaCobro<=@fechaCorte
								GROUP BY                 dbo.cxc_cobro.IdEmpresa, dbo.cxc_cobro.IdSucursal,  dbo.cxc_cobro_det.dc_TipoDocumento, dbo.cxc_cobro_det.IdBodega_Cbte, 
															dbo.cxc_cobro_det.IdCbte_vta_nota, dbo.cxc_cobro_x_EstadoCobro.IdEstadoCobro
								having cxc_cobro_x_EstadoCobro.IdEstadoCobro='COBR'

							) as Cobros_x_fac
							on Facturas_y_notas_deb.IdEmpresa=Cobros_x_fac.IdEmpresa
							and Facturas_y_notas_deb.IdSucursal=Cobros_x_fac.IdSucursal
							and Facturas_y_notas_deb.IdBodega=Cobros_x_fac.IdBodega_Cbte
							and Facturas_y_notas_deb.IdCbteVta=Cobros_x_fac.IdCbte_vta_nota
							and Facturas_y_notas_deb.vt_tipoDoc=Cobros_x_fac.dc_TipoDocumento
							where 
							round(Facturas_y_notas_deb.Valor_Original,2) -round(isnull(Cobros_x_fac.dc_ValorPago,0),2)<>0
							)A
							where IdCliente = @IdCliente
							group by A.IdEmpresa,A.IdCliente
							) A							
		
		

				select fac.IdEmpresa, fac.IdSucursal, fac.IdCliente, fac.Su_Descripcion , fac.pe_nombreCompleto, fac.pe_cedulaRuc, fac.DiasVencidos
						, ROUND((Monto), 2) AS Valor_Original, ROUND((TotalCobrado), 2) AS TotalCobrado , ROUND((Monto), 2) - ROUND((TotalCobrado), 2) AS Saldo 
						,fac.IdCbteVta,fac.vt_fecha,fac.vt_fech_venc,fac.numDocumento,fac.vt_tipoDoc, fac.vt_Observacion,fac.[Valor_x_Vencer_f] ,fac.[Vencer_30_Dias]
						,fac.[Vencer_60_Dias],fac.[Vencer_90_Dias],fac.[Mayor_a_90Dias]
				from cxc_rpt_tmp_Factu_ND_NC_Cobro_SP012 fac	
END