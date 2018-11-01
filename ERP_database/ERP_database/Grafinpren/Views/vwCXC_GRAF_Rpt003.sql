CREATE view [Grafinpren].[vwCXC_GRAF_Rpt003]
as
SELECT        ISNULL(ROW_NUMBER() OVER (ORDER BY A.IdEmpresa), 0) AS IdRow, *
FROM            (SELECT        fa_factura.IdEmpresa, fa_factura.IdSucursal, fa_factura.IdBodega, fa_factura.IdCbteVta, fa_factura.CodCbteVta, fa_factura.vt_tipoDoc, fa_cliente.IdCliente, 
                                                    tb_persona.IdPersona, tb_persona.pe_nombreCompleto, CAST(CAST(fa_factura.vt_NumFactura AS NUMERIC) AS VARCHAR(20)) vt_NumFactura, 
                                                    ROUND(vwfa_factura_SubTotal_Iva_total.vt_total, 2) AS vt_total, ROUND(SUM(ISNULL(cxc_cobro_det.dc_ValorPago, 0)), 2) AS dc_ValorPago, 
                                                    ROUND(vwfa_factura_SubTotal_Iva_total.vt_total, 2) - SUM(ISNULL(cxc_cobro_det.dc_ValorPago, 0)) AS Saldo, fa_factura.vt_fecha, 
                                                    fa_factura.vt_fech_venc, DATEDIFF(DAY, fa_factura.vt_fecha, getdate()) AS Dias_en_credito, datediff(day, fa_factura.vt_fech_venc, getdate()) 
                                                    AS Dias_vencido
                          FROM            cxc_cobro_det INNER JOIN
                                                    fa_factura ON cxc_cobro_det.IdEmpresa = fa_factura.IdEmpresa AND cxc_cobro_det.IdSucursal = fa_factura.IdSucursal AND 
                                                    cxc_cobro_det.IdBodega_Cbte = fa_factura.IdBodega AND cxc_cobro_det.IdCbte_vta_nota = fa_factura.IdCbteVta AND 
                                                    cxc_cobro_det.dc_TipoDocumento = fa_factura.vt_tipoDoc INNER JOIN
                                                    vwfa_factura_SubTotal_Iva_total ON fa_factura.IdEmpresa = vwfa_factura_SubTotal_Iva_total.IdEmpresa AND 
                                                    fa_factura.IdSucursal = vwfa_factura_SubTotal_Iva_total.IdSucursal AND fa_factura.IdBodega = vwfa_factura_SubTotal_Iva_total.IdBodega AND 
                                                    fa_factura.IdCbteVta = vwfa_factura_SubTotal_Iva_total.IdCbteVta INNER JOIN
                                                    fa_cliente ON fa_factura.IdEmpresa = fa_cliente.IdEmpresa AND fa_factura.IdCliente = fa_cliente.IdCliente INNER JOIN
                                                    tb_persona ON fa_cliente.IdPersona = tb_persona.IdPersona
                          GROUP BY fa_factura.IdEmpresa, fa_factura.IdSucursal, fa_factura.IdBodega, fa_factura.IdCbteVta, fa_factura.CodCbteVta, fa_factura.vt_tipoDoc, fa_cliente.IdCliente, 
                                                    tb_persona.IdPersona, tb_persona.pe_nombreCompleto, fa_factura.vt_NumFactura, vwfa_factura_SubTotal_Iva_total.vt_total, fa_factura.vt_fecha, 
                                                    fa_factura.vt_fech_venc
                          HAVING         datediff(day, fa_factura.vt_fech_venc, getdate()) > 0 AND 
						  (ROUND(vwfa_factura_SubTotal_Iva_total.vt_total, 2) - ROUND(SUM(ISNULL(cxc_cobro_det.dc_ValorPago, 0)), 2)) > 0
                          UNION
                          SELECT        fa_notaCreDeb.IdEmpresa, fa_notaCreDeb.IdSucursal, fa_notaCreDeb.IdBodega, fa_notaCreDeb.IdNota, fa_notaCreDeb.CodNota, 
                                                   fa_notaCreDeb.CodDocumentoTipo, fa_cliente.IdCliente, tb_persona.IdPersona, tb_persona.pe_nombreCompleto, 
                                                   LTRIM(SUBSTRING(fa_notaCreDeb.CodNota, 5, LEN(fa_notaCreDeb.CodNota))) CodNota, ROUND(vwfa_notaCreDeb_det_Subtotal_Iva_total.sc_total, 2) 
                                                   AS vt_total, ROUND(SUM(ISNULL(cxc_cobro_det.dc_ValorPago, 0)), 2) AS dc_ValorPago, 
                                                   ROUND(vwfa_notaCreDeb_det_Subtotal_Iva_total.sc_total - SUM(ISNULL(cxc_cobro_det.dc_ValorPago, 0)), 2) AS Saldo, fa_notaCreDeb.no_fecha, 
                                                   fa_notaCreDeb.no_fecha_venc, DATEDIFF(DAY, fa_notaCreDeb.no_fecha, getdate()) AS Dias_en_credito, datediff(day, fa_notaCreDeb.no_fecha_venc, 
                                                   getdate()) AS Dias_vencido
                          FROM            cxc_cobro_det INNER JOIN
                                                   fa_notaCreDeb ON cxc_cobro_det.IdEmpresa = fa_notaCreDeb.IdEmpresa AND cxc_cobro_det.IdSucursal = fa_notaCreDeb.IdSucursal AND 
                                                   cxc_cobro_det.IdBodega_Cbte = fa_notaCreDeb.IdBodega AND cxc_cobro_det.IdCbte_vta_nota = fa_notaCreDeb.IdNota AND 
                                                   cxc_cobro_det.dc_TipoDocumento = fa_notaCreDeb.CodDocumentoTipo INNER JOIN
                                                   vwfa_notaCreDeb_det_Subtotal_Iva_total ON fa_notaCreDeb.IdEmpresa = vwfa_notaCreDeb_det_Subtotal_Iva_total.IdEmpresa AND 
                                                   fa_notaCreDeb.IdSucursal = vwfa_notaCreDeb_det_Subtotal_Iva_total.IdSucursal AND 
                                                   fa_notaCreDeb.IdBodega = vwfa_notaCreDeb_det_Subtotal_Iva_total.IdBodega AND 
                                                   fa_notaCreDeb.IdNota = vwfa_notaCreDeb_det_Subtotal_Iva_total.IdNota INNER JOIN
                                                   fa_cliente ON fa_notaCreDeb.IdEmpresa = fa_cliente.IdEmpresa AND fa_notaCreDeb.IdCliente = fa_cliente.IdCliente INNER JOIN
                                                   tb_persona ON fa_cliente.IdPersona = tb_persona.IdPersona
                          GROUP BY fa_notaCreDeb.IdEmpresa, fa_notaCreDeb.IdSucursal, fa_notaCreDeb.IdBodega, fa_notaCreDeb.IdNota, fa_notaCreDeb.CodNota, 
                                                   fa_notaCreDeb.CodDocumentoTipo, fa_cliente.IdCliente, tb_persona.IdPersona, tb_persona.pe_nombreCompleto, fa_notaCreDeb.CodNota, 
                                                   vwfa_notaCreDeb_det_Subtotal_Iva_total.sc_total, fa_notaCreDeb.no_fecha, fa_notaCreDeb.no_fecha_venc
                          HAVING        datediff(day, fa_notaCreDeb.no_fecha_venc, getdate()) > 0 
						  AND (ROUND(vwfa_notaCreDeb_det_Subtotal_Iva_total.sc_total, 2) - ROUND(SUM(ISNULL(cxc_cobro_det.dc_ValorPago, 0)), 2)) > 0) A