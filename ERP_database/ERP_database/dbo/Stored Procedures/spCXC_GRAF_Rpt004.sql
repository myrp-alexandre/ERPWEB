
CREATE PROCEDURE [dbo].[spCXC_GRAF_Rpt004]
	@IdEmpresa as int,	
	@SucursalIni as int,
	@SucursalFin as int,
	@fechaIni as datetime,
	@fechaFin as datetime
AS
BEGIN

	SET NOCOUNT ON;



select      Facturas_y_notas_deb.IdEmpresa ,Facturas_y_notas_deb.IdSucursal,Facturas_y_notas_deb.IdBodega,Facturas_y_notas_deb.IdCliente,Facturas_y_notas_deb.Codigo,Facturas_y_notas_deb.IdCbteVta,Facturas_y_notas_deb.CodCbteVta,Facturas_y_notas_deb.vt_tipoDoc,Facturas_y_notas_deb.vt_serie1,Facturas_y_notas_deb.vt_serie2,
            Facturas_y_notas_deb.vt_NumFactura,Facturas_y_notas_deb.Su_Descripcion,LTRIM(Facturas_y_notas_deb.pe_nombreCompleto) AS pe_nombreCompleto,Facturas_y_notas_deb.pe_cedulaRuc,
			Facturas_y_notas_deb.Valor_Original as Valor_Original,
			isnull(Cobros_x_fac.dc_ValorPago,0) as Total_Pagado,
            IIF( DATEDIFF( day,Facturas_y_notas_deb.vt_fech_venc,@fechaFin)<0, Facturas_y_notas_deb.Valor_Original - isnull(Cobros_x_fac.dc_ValorPago,0) ,0) Valor_x_Vencer,
			IIF( DATEDIFF( day,Facturas_y_notas_deb.vt_fech_venc,@fechaFin)>=1 and  DATEDIFF( day,Facturas_y_notas_deb.vt_fech_venc,@fechaFin )<=30 ,  Facturas_y_notas_deb.Valor_Original -(iif(Cobros_x_fac.IdEstadoCobro='COBR', isnull( Cobros_x_fac.dc_ValorPago,0),0)) ,0) Vencer_30_Dias,
			IIF( DATEDIFF( day,Facturas_y_notas_deb.vt_fech_venc,@fechaFin )>30 and  DATEDIFF( day,Facturas_y_notas_deb.vt_fech_venc,@fechaFin )<=60 ,   Facturas_y_notas_deb.Valor_Original - (iif(Cobros_x_fac.IdEstadoCobro='COBR', isnull( Cobros_x_fac.dc_ValorPago,0),0)) ,0) Vencer_60_Dias,
			IIF( DATEDIFF( day,Facturas_y_notas_deb.vt_fech_venc,@fechaFin )>60 and  DATEDIFF( day,Facturas_y_notas_deb.vt_fech_venc,@fechaFin )<=90 ,  Facturas_y_notas_deb.Valor_Original -(iif(Cobros_x_fac.IdEstadoCobro='COBR', isnull( Cobros_x_fac.dc_ValorPago,0),0)) ,0) Vencer_90_Dias,
			IIF( DATEDIFF( day,Facturas_y_notas_deb.vt_fech_venc,@fechaFin )>90,  Facturas_y_notas_deb.Valor_Original - (iif(Cobros_x_fac.IdEstadoCobro='COBR', isnull( Cobros_x_fac.dc_ValorPago,0),0)),0) Mayor_a_90Dias
			,Facturas_y_notas_deb.vt_fech_venc,Facturas_y_notas_deb.vt_fecha,Facturas_y_notas_deb.Idtipo_cliente,DATEDIFF( day,Facturas_y_notas_deb.vt_fech_venc,@fechaFin ) Dias_Vencidos,
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
			WHERE				F.vt_fecha <= @fechaFin
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
where           dbo.fa_notaCreDeb.CreDeb='D' and fa_notaCreDeb.no_fecha <= @fechaFin
				and dbo.fa_notaCreDeb.Estado='A'
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
		WHERE					 dbo.cxc_cobro.cr_fechaCobro <= @fechaFin
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

END