-- select * from vwCXC_Rpt016 where IdEmpresa=1 and IdSucursal=1 and IdBodega_Cbte=1 and IdCbte_vta_nota=1 and CodDocumentoTipo='FACT'
-- sp_help vwCXC_Rpt016

CREATE view vwCXC_Rpt016 as
SELECT        cxc_cobro_det.IdEmpresa, cxc_cobro_det.IdSucursal, cxc_cobro_det.IdCobro, cxc_cobro_det.secuencial, cxc_cobro_det.IdBodega_Cbte, 
                         cxc_cobro_det.IdCbte_vta_nota, cxc_cobro.IdCobro_tipo, fa_notaCreDeb.CodDocumentoTipo, fa_notaCreDeb.Serie1, fa_notaCreDeb.Serie2, 
                         fa_notaCreDeb.NumNota_Impresa, fa_cliente.IdCliente, tb_persona.pe_nombreCompleto AS nom_cliente, fa_notaCreDeb.sc_observacion, cxc_cobro.cr_fecha, 
                         cxc_cobro_tipo.tc_descripcion, cxc_cobro_tipo.PorcentajeRet, cxc_cobro_det.dc_ValorPago, cxc_cobro.cr_NumDocumento, 
                         CASE WHEN cxc_cobro_tipo.ESRetenIVA = 'S' THEN vwfa_notaCreDeb_det_Subtotal_Iva_total.sc_iva ELSE vwfa_notaCreDeb_det_Subtotal_Iva_total.sc_subtotal END AS Base
						 ,fa_notaCreDeb.CodDocumentoTipo+'-' + isnull(fa_notaCreDeb.Serie1+'-'+ fa_notaCreDeb.Serie2+'-'+ fa_notaCreDeb.NumNota_Impresa,'') +'/' + cast(fa_notaCreDeb.IdNota as varchar(20)) as num_documento
						 ,vwfa_notaCreDeb_det_Subtotal_Iva_total.sc_subtotal,vwfa_notaCreDeb_det_Subtotal_Iva_total.sc_iva,vwfa_notaCreDeb_det_Subtotal_Iva_total.sc_total
FROM            cxc_cobro_det INNER JOIN
                         cxc_cobro ON cxc_cobro_det.IdEmpresa = cxc_cobro.IdEmpresa AND cxc_cobro_det.IdSucursal = cxc_cobro.IdSucursal AND 
                         cxc_cobro_det.IdCobro = cxc_cobro.IdCobro INNER JOIN
                         cxc_cobro_tipo ON cxc_cobro.IdCobro_tipo = cxc_cobro_tipo.IdCobro_tipo INNER JOIN
                         fa_notaCreDeb ON cxc_cobro_det.IdEmpresa = fa_notaCreDeb.IdEmpresa AND cxc_cobro_det.IdSucursal = fa_notaCreDeb.IdSucursal AND 
                         cxc_cobro_det.IdBodega_Cbte = fa_notaCreDeb.IdBodega AND cxc_cobro_det.IdCbte_vta_nota = fa_notaCreDeb.IdNota AND 
                         cxc_cobro_det.dc_TipoDocumento = fa_notaCreDeb.CodDocumentoTipo INNER JOIN
                         fa_cliente ON fa_notaCreDeb.IdEmpresa = fa_cliente.IdEmpresa AND fa_notaCreDeb.IdCliente = fa_cliente.IdCliente AND 
                         fa_notaCreDeb.IdEmpresa = fa_cliente.IdEmpresa AND fa_notaCreDeb.IdCliente = fa_cliente.IdCliente AND fa_notaCreDeb.IdEmpresa = fa_cliente.IdEmpresa AND 
                         fa_notaCreDeb.IdCliente = fa_cliente.IdCliente INNER JOIN
                         tb_persona ON fa_cliente.IdPersona = tb_persona.IdPersona AND fa_cliente.IdPersona = tb_persona.IdPersona AND 
                         fa_cliente.IdPersona = tb_persona.IdPersona AND fa_cliente.IdPersona = tb_persona.IdPersona INNER JOIN
                         vwfa_notaCreDeb_det_Subtotal_Iva_total ON fa_notaCreDeb.IdSucursal = vwfa_notaCreDeb_det_Subtotal_Iva_total.IdSucursal AND 
                         fa_notaCreDeb.IdBodega = vwfa_notaCreDeb_det_Subtotal_Iva_total.IdBodega AND fa_notaCreDeb.IdNota = vwfa_notaCreDeb_det_Subtotal_Iva_total.IdNota AND 
                         fa_notaCreDeb.IdEmpresa = vwfa_notaCreDeb_det_Subtotal_Iva_total.IdEmpresa
WHERE        (cxc_cobro_tipo.ESRetenIVA = 'S') OR
                         (cxc_cobro_tipo.ESRetenFTE = 'S')


union

SELECT        cxc_cobro_det.IdEmpresa, cxc_cobro_det.IdSucursal, cxc_cobro_det.IdCobro, cxc_cobro_det.secuencial, cxc_cobro_det.IdBodega_Cbte, 
                         cxc_cobro_det.IdCbte_vta_nota, cxc_cobro.IdCobro_tipo, fa_factura.vt_tipoDoc, fa_factura.vt_serie1, fa_factura.vt_serie2, fa_factura.vt_NumFactura, 
                         fa_factura.IdCliente, tb_persona.pe_nombreCompleto, fa_factura.vt_Observacion, fa_factura.vt_fecha, cxc_cobro_tipo.tc_descripcion, cxc_cobro_tipo.PorcentajeRet, 
                         cxc_cobro_det.dc_ValorPago, cxc_cobro.cr_NumDocumento
						 ,CASE WHEN cxc_cobro_tipo.ESRetenIVA = 'S' THEN vwfa_factura_Subtotal_Iva.vt_iva ELSE vwfa_factura_Subtotal_Iva.vt_Subtotal END AS Base
						 ,fa_factura.vt_tipoDoc +'-'+ fa_factura.vt_serie1 +'-'+ fa_factura.vt_serie2 +'-'+ fa_factura.vt_NumFactura  +'/' + cast(fa_factura.IdCbteVta as varchar(20))  as num_documento
						 ,vwfa_factura_Subtotal_Iva.vt_Subtotal,vwfa_factura_Subtotal_Iva.vt_iva,vwfa_factura_Subtotal_Iva.vt_Subtotal + vwfa_factura_Subtotal_Iva.vt_iva as Total
FROM            fa_cliente INNER JOIN
                         tb_persona ON fa_cliente.IdPersona = tb_persona.IdPersona AND fa_cliente.IdPersona = tb_persona.IdPersona AND 
                         fa_cliente.IdPersona = tb_persona.IdPersona AND fa_cliente.IdPersona = tb_persona.IdPersona INNER JOIN
                         fa_factura ON fa_cliente.IdEmpresa = fa_factura.IdEmpresa AND fa_cliente.IdCliente = fa_factura.IdCliente AND fa_cliente.IdEmpresa = fa_factura.IdEmpresa AND 
                         fa_cliente.IdCliente = fa_factura.IdCliente AND fa_cliente.IdEmpresa = fa_factura.IdEmpresa AND fa_cliente.IdCliente = fa_factura.IdCliente INNER JOIN
                         cxc_cobro_det INNER JOIN
                         cxc_cobro ON cxc_cobro_det.IdEmpresa = cxc_cobro.IdEmpresa AND cxc_cobro_det.IdSucursal = cxc_cobro.IdSucursal AND 
                         cxc_cobro_det.IdCobro = cxc_cobro.IdCobro INNER JOIN
                         cxc_cobro_tipo ON cxc_cobro.IdCobro_tipo = cxc_cobro_tipo.IdCobro_tipo ON fa_factura.IdEmpresa = cxc_cobro_det.IdEmpresa AND 
                         fa_factura.IdSucursal = cxc_cobro_det.IdSucursal AND fa_factura.IdBodega = cxc_cobro_det.IdBodega_Cbte AND 
                         fa_factura.IdCbteVta = cxc_cobro_det.IdCbte_vta_nota AND fa_factura.vt_tipoDoc = cxc_cobro_det.dc_TipoDocumento INNER JOIN
                         vwfa_factura_Subtotal_Iva ON fa_factura.IdEmpresa = vwfa_factura_Subtotal_Iva.IdEmpresa AND fa_factura.IdSucursal = vwfa_factura_Subtotal_Iva.IdSucursal AND 
                         fa_factura.IdBodega = vwfa_factura_Subtotal_Iva.IdBodega AND fa_factura.IdCbteVta = vwfa_factura_Subtotal_Iva.IdCbteVta
						 
WHERE        (cxc_cobro_tipo.ESRetenIVA = 'S') OR
                         (cxc_cobro_tipo.ESRetenFTE = 'S')