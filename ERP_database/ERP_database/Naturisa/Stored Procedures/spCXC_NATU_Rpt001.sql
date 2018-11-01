--EXEC  [Naturisa].[spCXC_NATU_Rpt001] 1,'01/10/2016','31/10/2016'
CREATE PROCEDURE [Naturisa].[spCXC_NATU_Rpt001]
(
@IdEmpresa int,
@Fecha_ini datetime,
@Fecha_fin datetime
)
AS
BEGIN

SELECT      dbo.fa_factura.IdEmpresa, dbo.fa_factura.IdSucursal, dbo.fa_factura.IdBodega, dbo.fa_factura.IdCbteVta, fa_factura.vt_tipoDoc,  
			dbo.fa_factura.IdCliente, dbo.tb_persona.IdPersona, RTRIM(LTRIM(dbo.tb_persona.pe_nombreCompleto)) AS pe_nombreCompleto, dbo.tb_persona.IdTipoDocumento, dbo.tb_persona.pe_cedulaRuc, 
			dbo.tb_persona.pe_Naturaleza, dbo.tb_parroquia.cod_parroquia,dbo.tb_parroquia.nom_parroquia,  dbo.tb_ciudad.Cod_Ciudad,dbo.tb_ciudad.Descripcion_Ciudad , dbo.tb_provincia.Cod_Provincia, dbo.tb_provincia.Descripcion_Prov
			, dbo.tb_persona.pe_sexo, tb_Catalogo_1.ca_descripcion AS nom_sexo, dbo.tb_persona.IdEstadoCivil, dbo.tb_Catalogo.ca_descripcion AS nom_EstadoCivil, dbo.fa_factura.vt_fecha, 
			dateadd(day,dbo.fa_TerminoPago.Dias_Vct,dbo.fa_factura.vt_fecha) as vt_fecha_vcto , 
			dateadd(day,dbo.fa_TerminoPago.Dias_Vct,dbo.fa_factura.vt_fecha) AS vt_fecha_exigible, 
			dbo.fa_TerminoPago.Dias_Vct as vt_plazo, dbo.fa_factura.vt_tipo_venta, dbo.fa_TerminoPago.nom_TerminoPago, dbo.fa_TerminoPago.Num_Coutas,fa_factura.vt_serie1+'-'+ fa_factura.vt_serie2+'-'+fa_factura.vt_NumFactura as num_factura,
			ROUND(dbo.vwfa_factura_SubTotal_Iva_total.vt_total,2) Valor_operacion,
			ROUND(dbo.vwfa_factura_SubTotal_Iva_total.vt_total - isnull(Cobros.dc_ValorPago,0),2) as Saldo_operacion,
			iif(DATEDIFF(day, @Fecha_fin,dateadd(day,dbo.fa_TerminoPago.Dias_Vct,dbo.fa_factura.vt_fecha))<0,0,DATEDIFF(day, @Fecha_fin,dateadd(day,dbo.fa_TerminoPago.Dias_Vct,dbo.fa_factura.vt_fecha))) as Dias_morosidad,
			ROUND(dbo.vwfa_factura_SubTotal_Iva_total.vt_total - isnull(Cobros.dc_ValorPago,0),2) as Monto_morosidad,
			0 as Monto_interes_mora,
			--x vencer 0 a 30 dias
			iif( (DATEDIFF(DAY,@Fecha_fin, DATEADD(DAY,dbo.fa_TerminoPago.Dias_Vct,dbo.fa_factura.vt_fecha))>=0)
			and  (DATEDIFF(DAY,@Fecha_fin, DATEADD(DAY,dbo.fa_TerminoPago.Dias_Vct,dbo.fa_factura.vt_fecha))<=30),
			ROUND(dbo.vwfa_factura_SubTotal_Iva_total.vt_total - isnull(Cobros.dc_ValorPago,0),2),0) as x_vencer_0_30,
			--x vencer 31 a 90 dias
			iif( (DATEDIFF(DAY,@Fecha_fin, DATEADD(DAY,dbo.fa_TerminoPago.Dias_Vct,dbo.fa_factura.vt_fecha))>=31)
			and  (DATEDIFF(DAY,@Fecha_fin, DATEADD(DAY,dbo.fa_TerminoPago.Dias_Vct,dbo.fa_factura.vt_fecha))<=90),
			ROUND(dbo.vwfa_factura_SubTotal_Iva_total.vt_total - isnull(Cobros.dc_ValorPago,0),2),0) as x_vencer_31_90,
			--x vencer 91 a 180
			iif( (DATEDIFF(DAY,@Fecha_fin, DATEADD(DAY,dbo.fa_TerminoPago.Dias_Vct,dbo.fa_factura.vt_fecha))>=91)
			and  (DATEDIFF(DAY,@Fecha_fin, DATEADD(DAY,dbo.fa_TerminoPago.Dias_Vct,dbo.fa_factura.vt_fecha))<=180),
			ROUND(dbo.vwfa_factura_SubTotal_Iva_total.vt_total - isnull(Cobros.dc_ValorPago,0),2),0) as x_vencer_91_180,
			--x vencer 181 a 360
			iif( (DATEDIFF(DAY,@Fecha_fin, DATEADD(DAY,dbo.fa_TerminoPago.Dias_Vct,dbo.fa_factura.vt_fecha))>=181)
			and  (DATEDIFF(DAY,@Fecha_fin, DATEADD(DAY,dbo.fa_TerminoPago.Dias_Vct,dbo.fa_factura.vt_fecha))<=360),
			ROUND(dbo.vwfa_factura_SubTotal_Iva_total.vt_total - isnull(Cobros.dc_ValorPago,0),2),0) as x_vencer_181_360,
			--x vencer mayor a 360
			iif( (DATEDIFF(DAY,@Fecha_fin, DATEADD(DAY,dbo.fa_TerminoPago.Dias_Vct,dbo.fa_factura.vt_fecha))>=361),			
			ROUND(dbo.vwfa_factura_SubTotal_Iva_total.vt_total - isnull(Cobros.dc_ValorPago,0),2),0) as x_vencer_mayor_360,
			--vencido 0 a 30
			iif(DATEDIFF(DAY,DATEADD(DAY,dbo.fa_TerminoPago.Dias_Vct,dbo.fa_factura.vt_fecha),@Fecha_fin)>=0
			AND DATEDIFF(DAY,DATEADD(DAY,dbo.fa_TerminoPago.Dias_Vct,dbo.fa_factura.vt_fecha),@Fecha_fin)<=30,
			ROUND(dbo.vwfa_factura_SubTotal_Iva_total.vt_total - isnull(Cobros.dc_ValorPago,0),2),0) as vencido_0_30,
			--vencido 31 a 90
			iif(DATEDIFF(DAY,DATEADD(DAY,dbo.fa_TerminoPago.Dias_Vct,dbo.fa_factura.vt_fecha),@Fecha_fin)>=31
			AND DATEDIFF(DAY,DATEADD(DAY,dbo.fa_TerminoPago.Dias_Vct,dbo.fa_factura.vt_fecha),@Fecha_fin)<=90,
			ROUND(dbo.vwfa_factura_SubTotal_Iva_total.vt_total - isnull(Cobros.dc_ValorPago,0),2),0) as vencido_31_90,
			--vencido 91 a 180
			iif(DATEDIFF(DAY,DATEADD(DAY,dbo.fa_TerminoPago.Dias_Vct,dbo.fa_factura.vt_fecha),@Fecha_fin)>=91
			AND DATEDIFF(DAY,DATEADD(DAY,dbo.fa_TerminoPago.Dias_Vct,dbo.fa_factura.vt_fecha),@Fecha_fin)<=180,
			ROUND(dbo.vwfa_factura_SubTotal_Iva_total.vt_total - isnull(Cobros.dc_ValorPago,0),2),0) as vencido_91_180,
			--vencido 181 a 360
			iif(DATEDIFF(DAY,DATEADD(DAY,dbo.fa_TerminoPago.Dias_Vct,dbo.fa_factura.vt_fecha),@Fecha_fin)>=181
			AND DATEDIFF(DAY,DATEADD(DAY,dbo.fa_TerminoPago.Dias_Vct,dbo.fa_factura.vt_fecha),@Fecha_fin)<=360,
			ROUND(dbo.vwfa_factura_SubTotal_Iva_total.vt_total - isnull(Cobros.dc_ValorPago,0),2),0) as vencido_181_360,
			--vencido mayor a 360
			iif(DATEDIFF(DAY,DATEADD(DAY,dbo.fa_TerminoPago.Dias_Vct,dbo.fa_factura.vt_fecha),@Fecha_fin)>=361,			
			ROUND(dbo.vwfa_factura_SubTotal_Iva_total.vt_total - isnull(Cobros.dc_ValorPago,0),2),0) as vencido_mayor_360
FROM            tb_Catalogo INNER JOIN
                         tb_Catalogo AS tb_Catalogo_1 INNER JOIN
                         fa_factura INNER JOIN
                         vwfa_factura_SubTotal_Iva_total ON fa_factura.IdEmpresa = vwfa_factura_SubTotal_Iva_total.IdEmpresa AND 
                         fa_factura.IdSucursal = vwfa_factura_SubTotal_Iva_total.IdSucursal AND fa_factura.IdBodega = vwfa_factura_SubTotal_Iva_total.IdBodega AND 
                         fa_factura.IdCbteVta = vwfa_factura_SubTotal_Iva_total.IdCbteVta INNER JOIN
                         fa_cliente ON fa_factura.IdEmpresa = fa_cliente.IdEmpresa AND fa_factura.IdCliente = fa_cliente.IdCliente INNER JOIN
                         tb_persona ON fa_cliente.IdPersona = tb_persona.IdPersona ON tb_Catalogo_1.CodCatalogo = tb_persona.pe_sexo ON 
                         tb_Catalogo.CodCatalogo = tb_persona.IdEstadoCivil INNER JOIN
						 fa_cliente_contactos as con on fa_cliente.IdEmpresa = con.IdEmpresa and fa_cliente.IdCliente = con.IdCliente INNER JOIN
                         fa_TerminoPago ON fa_factura.vt_tipo_venta = fa_TerminoPago.IdTerminoPago LEFT OUTER JOIN						 
                         tb_parroquia ON con.IdCiudad = tb_parroquia.IdCiudad_Canton AND con.IdParroquia = tb_parroquia.IdParroquia LEFT OUTER JOIN
                         tb_provincia INNER JOIN
                         tb_ciudad ON tb_provincia.IdProvincia = tb_ciudad.IdProvincia ON tb_parroquia.IdCiudad_Canton = tb_ciudad.IdCiudad
				LEFT JOIN (
							SELECT        dbo.fa_factura.IdEmpresa, dbo.fa_factura.IdSucursal, dbo.fa_factura.IdBodega, dbo.fa_factura.IdCbteVta, dbo.fa_factura.vt_tipoDoc, 
									SUM(dbo.cxc_cobro_det.dc_ValorPago) AS dc_ValorPago
							FROM         dbo.fa_factura INNER JOIN
									dbo.cxc_cobro_det ON dbo.fa_factura.IdEmpresa = dbo.cxc_cobro_det.IdEmpresa AND dbo.fa_factura.IdSucursal = dbo.cxc_cobro_det.IdSucursal AND 
									dbo.fa_factura.IdBodega = dbo.cxc_cobro_det.IdBodega_Cbte AND dbo.fa_factura.IdCbteVta = dbo.cxc_cobro_det.IdCbte_vta_nota AND 
									dbo.fa_factura.vt_tipoDoc = dbo.cxc_cobro_det.dc_TipoDocumento INNER JOIN
									dbo.cxc_cobro ON dbo.cxc_cobro_det.IdEmpresa = dbo.cxc_cobro.IdEmpresa AND dbo.cxc_cobro_det.IdSucursal = dbo.cxc_cobro.IdSucursal AND 
									dbo.cxc_cobro_det.IdCobro = dbo.cxc_cobro.IdCobro
							WHERE  dbo.cxc_cobro.IdEmpresa = @IdEmpresa AND dbo.cxc_cobro.cr_fechaCobro BETWEEN @Fecha_ini AND @Fecha_fin AND dbo.cxc_cobro.cr_estado = 'A' 
							GROUP BY dbo.fa_factura.IdEmpresa, dbo.fa_factura.IdSucursal, dbo.fa_factura.IdBodega, dbo.fa_factura.IdCbteVta, dbo.fa_factura.vt_tipoDoc
				) Cobros ON Cobros.IdEmpresa = fa_factura.IdEmpresa AND Cobros.IdSucursal = fa_factura.IdSucursal
				AND Cobros.IdBodega = fa_factura.IdBodega AND Cobros.IdCbteVta = fa_factura.IdCbteVta AND Cobros.vt_tipoDoc = fa_factura.vt_tipoDoc
WHERE		dbo.fa_factura.IdEmpresa = @IdEmpresa AND dbo.fa_factura.vt_fecha between @Fecha_ini and @Fecha_fin
ORDER BY dbo.tb_persona.pe_nombreCompleto, dbo.fa_factura.vt_NumFactura

END