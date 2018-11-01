
--exec [web].[SPFAC_002] 1,1,1,57,57,1,9999,'2018/08/02'
CREATE PROCEDURE [web].[SPFAC_002]
	@IdEmpresa as int,
	@SucursalIni as int,
	@SucursalFin as int,
	@IdClienteIni as numeric,
	@IdClienteFin as numeric,
	@IdClienteContactoIni as int,
	@IdClienteContactoFin as int,
	@fechaCorte as datetime,
	@MostrarSoloCarteraVencida bit
AS
BEGIN
	SET NOCOUNT ON;


select      Facturas_y_notas_deb.IdEmpresa ,Facturas_y_notas_deb.IdSucursal,Facturas_y_notas_deb.IdBodega,Facturas_y_notas_deb.IdCliente,Facturas_y_notas_deb.Codigo,Facturas_y_notas_deb.IdCbteVta,Facturas_y_notas_deb.CodCbteVta,Facturas_y_notas_deb.vt_tipoDoc,Facturas_y_notas_deb.vt_serie1,Facturas_y_notas_deb.vt_serie2,
            Facturas_y_notas_deb.vt_NumFactura,Facturas_y_notas_deb.Su_Descripcion,LTRIM(Facturas_y_notas_deb.pe_nombreCompleto) AS pe_nombreCompleto,Facturas_y_notas_deb.pe_cedulaRuc,
			Facturas_y_notas_deb.Valor_Original as Valor_Original,
			isnull(Cobros_x_fac.dc_ValorPago,0) as Total_Pagado,
            IIF( DATEDIFF( day,Facturas_y_notas_deb.vt_fech_venc,@fechaCorte)<0, Facturas_y_notas_deb.Valor_Original - isnull(Cobros_x_fac.dc_ValorPago,0) ,0) Valor_x_Vencer,
			IIF( DATEDIFF( day,Facturas_y_notas_deb.vt_fech_venc,@fechaCorte)>0, Facturas_y_notas_deb.Valor_Original - isnull(Cobros_x_fac.dc_ValorPago,0) ,0) Valor_vencido,

			IIF( DATEDIFF( day,Facturas_y_notas_deb.vt_fech_venc,@fechaCorte)>=1 and  DATEDIFF( day,Facturas_y_notas_deb.vt_fech_venc,@fechaCorte )<=30 ,  Facturas_y_notas_deb.Valor_Original -( isnull( Cobros_x_fac.dc_ValorPago,0)) ,0) Vencer_30_Dias,
			IIF( DATEDIFF( day,Facturas_y_notas_deb.vt_fech_venc,@fechaCorte )>30 and  DATEDIFF( day,Facturas_y_notas_deb.vt_fech_venc,@fechaCorte )<=60 ,   Facturas_y_notas_deb.Valor_Original - ( isnull( Cobros_x_fac.dc_ValorPago,0)) ,0) Vencer_60_Dias,
			IIF( DATEDIFF( day,Facturas_y_notas_deb.vt_fech_venc,@fechaCorte )>60 and  DATEDIFF( day,Facturas_y_notas_deb.vt_fech_venc,@fechaCorte )<=90 ,  Facturas_y_notas_deb.Valor_Original -( isnull( Cobros_x_fac.dc_ValorPago,0)) ,0) Vencer_90_Dias,
			IIF( DATEDIFF( day,Facturas_y_notas_deb.vt_fech_venc,@fechaCorte )>90,  Facturas_y_notas_deb.Valor_Original - isnull( Cobros_x_fac.dc_ValorPago,0),0) Mayor_a_90Dias
			,Facturas_y_notas_deb.vt_fech_venc,Facturas_y_notas_deb.vt_fecha,Facturas_y_notas_deb.Idtipo_cliente,DATEDIFF( day,Facturas_y_notas_deb.vt_fech_venc,@fechaCorte ) Dias_Vencidos,
			ISNULL(cast( Facturas_y_notas_deb.Valor_Original-isnull( Cobros_x_fac.dc_ValorPago,0) as numeric(10,2)),0) Saldo,Facturas_y_notas_deb.pe_telefonoOfic, vt_Observacion, vt_plazo, IdContacto, NomContacto, TelefonoContacto

 from 
(
	
			SELECT              F.IdEmpresa, F.IdSucursal, F.IdBodega, dbo.fa_cliente.IdCliente, dbo.fa_cliente.Codigo, F.IdCbteVta, 
								F.CodCbteVta,F.vt_tipoDoc,F.vt_serie1,F.vt_serie2,F.vt_NumFactura, 
								dbo.tb_sucursal.Su_Descripcion, LTRIM(dbo.tb_persona.pe_nombreCompleto) + '/'+ cast( fa_cliente.IdCliente as varchar(20)) as pe_nombreCompleto, dbo.tb_persona.pe_cedulaRuc, SUM( FD.vt_total) Valor_Original,F.vt_fech_venc,
								F.vt_fecha,dbo.fa_cliente.Idtipo_cliente, '' +'/'+ dbo.tb_persona.pe_telfono_Contacto as pe_telefonoOfic,
								F.vt_Observacion,F.vt_plazo, f.IdContacto, con.Nombres as NomContacto, con.Telefono + '/' + con.Celular TelefonoContacto
			FROM            fa_factura AS F INNER JOIN
                         fa_factura_det AS FD ON F.IdEmpresa = FD.IdEmpresa AND F.IdSucursal = FD.IdSucursal AND F.IdBodega = FD.IdBodega AND F.IdCbteVta = FD.IdCbteVta INNER JOIN
                         fa_cliente ON F.IdEmpresa = fa_cliente.IdEmpresa AND F.IdCliente = fa_cliente.IdCliente INNER JOIN
                         tb_persona ON fa_cliente.IdPersona = tb_persona.IdPersona INNER JOIN
                         tb_sucursal ON F.IdEmpresa = tb_sucursal.IdEmpresa AND F.IdSucursal = tb_sucursal.IdSucursal 
						 INNER JOIN fa_cliente_contactos as con on F.IdEmpresa = con.IdEmpresa and f.IdCliente = con.IdCliente and f.IdContacto = con.IdContacto
			WHERE				F.IdEmpresa = @IdEmpresa AND F.vt_fecha <= @fechaCorte and F.Estado='A' 
			AND f.IdCliente between @IdClienteIni and @IdClienteFin and f.IdContacto between @IdClienteContactoIni and @IdClienteContactoFin
			GROUP BY            F.IdEmpresa,F.IdSucursal,F.IdBodega, dbo.fa_cliente.IdCliente, dbo.fa_cliente.Codigo,F.IdCbteVta, 
								F.CodCbteVta,F.vt_tipoDoc,F.vt_serie1,F.vt_serie2,F.vt_NumFactura, 
								dbo.tb_sucursal.Su_Descripcion, ltrim(dbo.tb_persona.pe_nombreCompleto) + '/'+ cast( fa_cliente.IdCliente as varchar(20)), dbo.tb_persona.pe_cedulaRuc,F.vt_fech_venc,F.vt_fecha,dbo.fa_cliente.Idtipo_cliente
								,'' +'/'+ dbo.tb_persona.pe_telfono_Contacto, F.vt_Observacion,F.vt_plazo,f.IdContacto, con.Nombres,con.Telefono + '/' + con.Celular
		
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
				dbo.tb_persona.pe_telfono_Contacto as pe_telefonoOfic, fa_notaCreDeb.sc_observacion,
				DATEDIFF(DAY,dbo.fa_notaCreDeb.no_fecha,dbo.fa_notaCreDeb.no_fecha_venc),1, tb_persona.pe_nombreCompleto, dbo.tb_persona.pe_telfono_Contacto
FROM            fa_notaCreDeb INNER JOIN
                fa_notaCreDeb_det ON fa_notaCreDeb.IdEmpresa = fa_notaCreDeb_det.IdEmpresa AND fa_notaCreDeb.IdSucursal = fa_notaCreDeb_det.IdSucursal AND 
                fa_notaCreDeb.IdBodega = fa_notaCreDeb_det.IdBodega AND fa_notaCreDeb.IdNota = fa_notaCreDeb_det.IdNota INNER JOIN
                fa_cliente ON fa_notaCreDeb.IdEmpresa = fa_cliente.IdEmpresa AND fa_notaCreDeb.IdCliente = fa_cliente.IdCliente INNER JOIN
                tb_sucursal ON fa_notaCreDeb.IdEmpresa = tb_sucursal.IdEmpresa AND fa_notaCreDeb.IdSucursal = tb_sucursal.IdSucursal INNER JOIN
                tb_persona ON fa_cliente.IdPersona = tb_persona.IdPersona 
where           dbo.fa_notaCreDeb.IdEmpresa = @IdEmpresa and dbo.fa_notaCreDeb.CreDeb='D' and fa_notaCreDeb.no_fecha <= @fechaCorte
				and dbo.fa_notaCreDeb.Estado='A' 
				AND fa_notaCreDeb.IdCliente between @IdClienteIni and @IdClienteFin 
				AND NOT EXISTS(
				  SELECT        *
                               FROM            fa_notaCreDeb_x_fa_factura_NotaDeb Cruce
                               WHERE        Cruce.IdEmpresa_nt = fa_notaCreDeb.IdEmpresa AND Cruce.IdSucursal_nt = fa_notaCreDeb.IdSucursal AND Cruce.IdBodega_nt = fa_notaCreDeb.IdBodega AND Cruce.IdNota_nt = fa_notaCreDeb.IdNota							  
				)
GROUP BY		dbo.fa_notaCreDeb.IdEmpresa, dbo.fa_notaCreDeb.IdSucursal, dbo.fa_notaCreDeb.IdBodega, dbo.fa_cliente.IdCliente, dbo.fa_cliente.Codigo, 
				dbo.fa_notaCreDeb.IdNota, dbo.fa_notaCreDeb.CodNota, dbo.fa_notaCreDeb.CodDocumentoTipo, dbo.fa_notaCreDeb.Serie1, dbo.fa_notaCreDeb.Serie2, 
				dbo.fa_notaCreDeb.NumNota_Impresa, dbo.tb_sucursal.Su_Descripcion, 
				LTRIM(dbo.tb_persona.pe_nombreCompleto) + '/'+ cast( fa_cliente.IdCliente as varchar(20)) , dbo.tb_persona.pe_cedulaRuc, 
				dbo.fa_notaCreDeb_det.sc_total, dbo.fa_notaCreDeb.no_fecha_venc,dbo.fa_notaCreDeb.no_fecha,dbo.fa_cliente.Idtipo_cliente,
				'' +'/'+ dbo.tb_persona.pe_telfono_Contacto, fa_notaCreDeb.sc_observacion, tb_persona.pe_nombreCompleto, dbo.tb_persona.pe_telfono_Contacto

) as  Facturas_y_notas_deb left join
(

		SELECT                   dbo.cxc_cobro.IdEmpresa, dbo.cxc_cobro.IdSucursal,  dbo.cxc_cobro_det.dc_TipoDocumento, dbo.cxc_cobro_det.IdBodega_Cbte, 
								 dbo.cxc_cobro_det.IdCbte_vta_nota, sum(dbo.cxc_cobro_det.dc_ValorPago) as dc_ValorPago 
		FROM                     dbo.cxc_cobro INNER JOIN
								 dbo.cxc_cobro_det ON dbo.cxc_cobro.IdEmpresa = dbo.cxc_cobro_det.IdEmpresa AND dbo.cxc_cobro.IdSucursal = dbo.cxc_cobro_det.IdSucursal AND 
								 dbo.cxc_cobro.IdCobro = dbo.cxc_cobro_det.IdCobro 
		WHERE					 dbo.cxc_cobro.IdEmpresa = @IdEmpresa and cast(dbo.cxc_cobro.cr_fechaCobro as date)<= @fechaCorte and dbo.cxc_cobro.cr_estado='A'
		GROUP BY                 dbo.cxc_cobro.IdEmpresa, dbo.cxc_cobro.IdSucursal,  dbo.cxc_cobro_det.dc_TipoDocumento, dbo.cxc_cobro_det.IdBodega_Cbte, 
								 dbo.cxc_cobro_det.IdCbte_vta_nota
	

) as Cobros_x_fac
on Facturas_y_notas_deb.IdEmpresa=Cobros_x_fac.IdEmpresa
and Facturas_y_notas_deb.IdSucursal=Cobros_x_fac.IdSucursal
and Facturas_y_notas_deb.IdBodega=Cobros_x_fac.IdBodega_Cbte
and Facturas_y_notas_deb.IdCbteVta=Cobros_x_fac.IdCbte_vta_nota
and Facturas_y_notas_deb.vt_tipoDoc=Cobros_x_fac.dc_TipoDocumento
where 
    Facturas_y_notas_deb.IdEmpresa = @IdEmpresa 
	and round(Facturas_y_notas_deb.Valor_Original,2) - round(isnull(Cobros_x_fac.dc_ValorPago,0),2) > 0
	and iif(@MostrarSoloCarteraVencida = 1,DATEDIFF( day,Facturas_y_notas_deb.vt_fech_venc,@fechaCorte), 0) >= 0

END