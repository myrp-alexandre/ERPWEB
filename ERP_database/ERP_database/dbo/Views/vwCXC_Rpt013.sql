CREATE view [dbo].[vwCXC_Rpt013]
as
SELECT        cxc_cobro_det.IdEmpresa, tb_sucursal.Su_Descripcion AS nom_sucursal, cxc_cobro_det.IdCobro, cxc_cobro.cr_fecha AS Fecha_cobro, 
                         cxc_cobro.cr_fechaDocu AS Fecha_Retencion, cxc_cobro.cr_NumDocumento AS Num_Retencion, cxc_cobro.IdCobro_tipo, fa_cliente.IdCliente, 
                         tb_persona.pe_nombreCompleto AS nom_cliente, tb_persona.pe_cedulaRuc AS ruc_ced, cxc_cobro_tipo.PorcentajeRet, 
                         CASE WHEN cxc_cobro_tipo.ESRetenIVA = 'S' THEN vwfa_factura_Subtotal_Iva.vt_iva ELSE 0 END AS Base_RIva, 
                         CASE WHEN cxc_cobro_tipo.ESRetenFTE = 'S' THEN vwfa_factura_Subtotal_Iva.vt_Subtotal ELSE 0 END AS Base_RFte, cxc_cobro_det.dc_ValorPago AS Valor_Ret, 
                         fa_factura.IdCbteVta, 'FT#:' + fa_factura.vt_NumFactura AS num_factura, fa_factura.vt_fecha AS Fecha_Fact, fa_factura.vt_tipoDoc, 
                         CASE WHEN cxc_cobro_tipo.ESRetenIVA = 'S' THEN 'RET_IVA' ELSE 'RET_FT' END AS Tipo_Retencion, 
                         CASE WHEN cxc_cobro_tipo.ESRetenIVA = 'S' THEN 'RETENCION DE IVA' ELSE 'RETENCION DE FUENTE' END AS nomTipo_Retencion, 
                         cxc_cobro_tipo.tc_descripcion AS nomTipoCobro
FROM            vwfa_factura_Subtotal_Iva INNER JOIN
                         fa_factura ON vwfa_factura_Subtotal_Iva.IdEmpresa = fa_factura.IdEmpresa AND vwfa_factura_Subtotal_Iva.IdSucursal = fa_factura.IdSucursal AND 
                         vwfa_factura_Subtotal_Iva.IdBodega = fa_factura.IdBodega AND vwfa_factura_Subtotal_Iva.IdCbteVta = fa_factura.IdCbteVta INNER JOIN
                         cxc_cobro_det INNER JOIN
                         cxc_cobro ON cxc_cobro_det.IdEmpresa = cxc_cobro.IdEmpresa AND cxc_cobro_det.IdSucursal = cxc_cobro.IdSucursal AND 
                         cxc_cobro_det.IdCobro = cxc_cobro.IdCobro AND cxc_cobro_det.IdEmpresa = cxc_cobro.IdEmpresa AND cxc_cobro_det.IdSucursal = cxc_cobro.IdSucursal AND 
                         cxc_cobro_det.IdCobro = cxc_cobro.IdCobro AND cxc_cobro_det.IdEmpresa = cxc_cobro.IdEmpresa AND cxc_cobro_det.IdSucursal = cxc_cobro.IdSucursal AND 
                         cxc_cobro_det.IdCobro = cxc_cobro.IdCobro INNER JOIN
                         tb_sucursal ON cxc_cobro.IdEmpresa = tb_sucursal.IdEmpresa AND cxc_cobro.IdSucursal = tb_sucursal.IdSucursal AND 
                         cxc_cobro.IdEmpresa = tb_sucursal.IdEmpresa AND cxc_cobro.IdSucursal = tb_sucursal.IdSucursal AND cxc_cobro.IdEmpresa = tb_sucursal.IdEmpresa AND 
                         cxc_cobro.IdSucursal = tb_sucursal.IdSucursal INNER JOIN
                         cxc_cobro_tipo ON cxc_cobro.IdCobro_tipo = cxc_cobro_tipo.IdCobro_tipo AND cxc_cobro.IdCobro_tipo = cxc_cobro_tipo.IdCobro_tipo AND 
                         cxc_cobro.IdCobro_tipo = cxc_cobro_tipo.IdCobro_tipo INNER JOIN
                         fa_cliente ON cxc_cobro.IdEmpresa = fa_cliente.IdEmpresa AND cxc_cobro.IdCliente = fa_cliente.IdCliente AND cxc_cobro.IdEmpresa = fa_cliente.IdEmpresa AND 
                         cxc_cobro.IdCliente = fa_cliente.IdCliente AND cxc_cobro.IdEmpresa = fa_cliente.IdEmpresa AND cxc_cobro.IdCliente = fa_cliente.IdCliente INNER JOIN
                         tb_persona ON fa_cliente.IdPersona = tb_persona.IdPersona AND fa_cliente.IdPersona = tb_persona.IdPersona AND fa_cliente.IdPersona = tb_persona.IdPersona ON
                          fa_factura.IdCliente = fa_cliente.IdCliente AND fa_factura.IdEmpresa = fa_cliente.IdEmpresa AND fa_factura.IdCliente = fa_cliente.IdCliente AND 
                         fa_factura.IdEmpresa = fa_cliente.IdEmpresa AND fa_factura.IdEmpresa = cxc_cobro_det.IdEmpresa AND fa_factura.IdSucursal = cxc_cobro_det.IdSucursal AND 
                         fa_factura.IdBodega = cxc_cobro_det.IdBodega_Cbte AND fa_factura.IdCbteVta = cxc_cobro_det.IdCbte_vta_nota AND 
                         fa_factura.vt_tipoDoc = cxc_cobro_det.dc_TipoDocumento
WHERE        (cxc_cobro.cr_estado = N'A') AND (cxc_cobro_tipo.ESRetenIVA = 'S') OR
                         (cxc_cobro.cr_estado = N'A') AND (cxc_cobro_tipo.ESRetenFTE = 'S')
UNION
SELECT        cxc_cobro_det.IdEmpresa, tb_sucursal.Su_Descripcion AS nom_sucursal, cxc_cobro_det.IdCobro, cxc_cobro.cr_fecha AS Fecha_cobro, 
                         cxc_cobro.cr_fechaDocu AS Fecha_Retencion, cxc_cobro.cr_NumDocumento AS Num_Retencion, cxc_cobro.IdCobro_tipo, fa_cliente.IdCliente, 
                         tb_persona.pe_nombreCompleto AS nom_cliente, tb_persona.pe_cedulaRuc AS ruc_ced, cxc_cobro_tipo.PorcentajeRet, 
                         CASE WHEN cxc_cobro_tipo.ESRetenIVA = 'S' THEN fa_notaCreDeb_Subtotal_Ivas.sc_iva ELSE 0 END AS Base_RIva, 
                         CASE WHEN cxc_cobro_tipo.ESRetenFTE = 'S' THEN fa_notaCreDeb_Subtotal_Ivas.sc_subtotal ELSE 0 END AS Base_RFte, 
                         cxc_cobro_det.dc_ValorPago AS Valor_Ret, fa_notaCreDeb.IdNota, 'ND#:' + cast(fa_notaCreDeb.IdNota AS varchar(20)), fa_notaCreDeb.no_fecha, 
                         fa_notaCreDeb.CodDocumentoTipo, CASE WHEN cxc_cobro_tipo.ESRetenIVA = 'S' THEN 'RET_IVA' ELSE 'RET_FT' END AS Tipo_Retencion, 
                         CASE WHEN cxc_cobro_tipo.ESRetenIVA = 'S' THEN 'RETENCION DE IVA' ELSE 'RETENCION DE FUENTE' END AS nomTipo_Retencion, 
                         cxc_cobro_tipo.tc_descripcion AS nomTipoCobro
FROM            fa_notaCreDeb INNER JOIN
                         cxc_cobro_det INNER JOIN
                         cxc_cobro ON cxc_cobro_det.IdEmpresa = cxc_cobro.IdEmpresa AND cxc_cobro_det.IdSucursal = cxc_cobro.IdSucursal AND 
                         cxc_cobro_det.IdCobro = cxc_cobro.IdCobro AND cxc_cobro_det.IdEmpresa = cxc_cobro.IdEmpresa AND cxc_cobro_det.IdSucursal = cxc_cobro.IdSucursal AND 
                         cxc_cobro_det.IdCobro = cxc_cobro.IdCobro AND cxc_cobro_det.IdEmpresa = cxc_cobro.IdEmpresa AND cxc_cobro_det.IdSucursal = cxc_cobro.IdSucursal AND 
                         cxc_cobro_det.IdCobro = cxc_cobro.IdCobro INNER JOIN
                         tb_sucursal ON cxc_cobro.IdEmpresa = tb_sucursal.IdEmpresa AND cxc_cobro.IdSucursal = tb_sucursal.IdSucursal AND 
                         cxc_cobro.IdEmpresa = tb_sucursal.IdEmpresa AND cxc_cobro.IdSucursal = tb_sucursal.IdSucursal AND cxc_cobro.IdEmpresa = tb_sucursal.IdEmpresa AND 
                         cxc_cobro.IdSucursal = tb_sucursal.IdSucursal INNER JOIN
                         cxc_cobro_tipo ON cxc_cobro.IdCobro_tipo = cxc_cobro_tipo.IdCobro_tipo AND cxc_cobro.IdCobro_tipo = cxc_cobro_tipo.IdCobro_tipo AND 
                         cxc_cobro.IdCobro_tipo = cxc_cobro_tipo.IdCobro_tipo INNER JOIN
                         fa_cliente ON cxc_cobro.IdEmpresa = fa_cliente.IdEmpresa AND cxc_cobro.IdCliente = fa_cliente.IdCliente AND cxc_cobro.IdEmpresa = fa_cliente.IdEmpresa AND 
                         cxc_cobro.IdCliente = fa_cliente.IdCliente AND cxc_cobro.IdEmpresa = fa_cliente.IdEmpresa AND cxc_cobro.IdCliente = fa_cliente.IdCliente INNER JOIN
                         tb_persona ON fa_cliente.IdPersona = tb_persona.IdPersona AND fa_cliente.IdPersona = tb_persona.IdPersona AND fa_cliente.IdPersona = tb_persona.IdPersona ON
                          fa_notaCreDeb.IdEmpresa = fa_cliente.IdEmpresa AND fa_notaCreDeb.IdCliente = fa_cliente.IdCliente AND fa_notaCreDeb.IdEmpresa = fa_cliente.IdEmpresa AND 
                         fa_notaCreDeb.IdCliente = fa_cliente.IdCliente AND fa_notaCreDeb.IdEmpresa = fa_cliente.IdEmpresa AND fa_notaCreDeb.IdCliente = fa_cliente.IdCliente AND 
                         fa_notaCreDeb.IdEmpresa = cxc_cobro_det.IdEmpresa AND fa_notaCreDeb.IdSucursal = cxc_cobro_det.IdSucursal AND 
                         fa_notaCreDeb.IdBodega = cxc_cobro_det.IdBodega_Cbte AND fa_notaCreDeb.IdNota = cxc_cobro_det.IdCbte_vta_nota AND 
                         fa_notaCreDeb.CodDocumentoTipo = cxc_cobro_det.dc_TipoDocumento INNER JOIN
                         fa_notaCreDeb_Subtotal_Ivas ON fa_notaCreDeb.IdEmpresa = fa_notaCreDeb_Subtotal_Ivas.IdEmpresa AND 
                         fa_notaCreDeb.IdSucursal = fa_notaCreDeb_Subtotal_Ivas.IdSucursal AND fa_notaCreDeb.IdBodega = fa_notaCreDeb_Subtotal_Ivas.IdBodega AND 
                         fa_notaCreDeb.IdNota = fa_notaCreDeb_Subtotal_Ivas.IdNota
WHERE        (cxc_cobro.cr_estado = N'A') AND (cxc_cobro_tipo.ESRetenIVA = 'S' OR
                         cxc_cobro_tipo.ESRetenFTE = 'S')
UNION
SELECT        cxc_cobro.IdEmpresa, tb_sucursal.Su_Descripcion AS nom_sucursal, cxc_cobro.IdCobro, cxc_cobro.cr_fecha AS Fecha_cobro, 
                         cxc_cobro.cr_fechaDocu AS Fecha_Retencion, cxc_cobro.cr_NumDocumento AS Num_Retencion, cxc_cobro.IdCobro_tipo, fa_cliente.IdCliente, 
                         tb_persona.pe_nombreCompleto AS nom_cliente, tb_persona.pe_cedulaRuc AS ruc_ced, cxc_cobro_tipo.PorcentajeRet, 0 AS Base_RIva, 0 AS Base_RFte, 
                         cxc_cobro.cr_TotalCobro, cxc_cobro.IdCobro, '', cxc_cobro.cr_fechaDocu, 'COBRO', 
                         CASE WHEN cxc_cobro_tipo.ESRetenIVA = 'S' THEN 'RET_IVA' ELSE 'RET_FT' END AS Tipo_Retencion, 
                         CASE WHEN cxc_cobro_tipo.ESRetenIVA = 'S' THEN 'RETENCION DE IVA' ELSE 'RETENCION DE FUENTE' END AS nomTipo_Retencion, 
                         cxc_cobro_tipo.tc_descripcion AS nomTipoCobro
FROM            cxc_cobro INNER JOIN
                         tb_sucursal ON cxc_cobro.IdEmpresa = tb_sucursal.IdEmpresa AND cxc_cobro.IdSucursal = tb_sucursal.IdSucursal AND 
                         cxc_cobro.IdEmpresa = tb_sucursal.IdEmpresa AND cxc_cobro.IdSucursal = tb_sucursal.IdSucursal AND cxc_cobro.IdEmpresa = tb_sucursal.IdEmpresa AND 
                         cxc_cobro.IdSucursal = tb_sucursal.IdSucursal INNER JOIN
                         cxc_cobro_tipo ON cxc_cobro.IdCobro_tipo = cxc_cobro_tipo.IdCobro_tipo AND cxc_cobro.IdCobro_tipo = cxc_cobro_tipo.IdCobro_tipo AND 
                         cxc_cobro.IdCobro_tipo = cxc_cobro_tipo.IdCobro_tipo INNER JOIN
                         fa_cliente ON cxc_cobro.IdEmpresa = fa_cliente.IdEmpresa AND cxc_cobro.IdCliente = fa_cliente.IdCliente AND cxc_cobro.IdEmpresa = fa_cliente.IdEmpresa AND 
                         cxc_cobro.IdCliente = fa_cliente.IdCliente AND cxc_cobro.IdEmpresa = fa_cliente.IdEmpresa AND cxc_cobro.IdCliente = fa_cliente.IdCliente INNER JOIN
                         tb_persona ON fa_cliente.IdPersona = tb_persona.IdPersona AND fa_cliente.IdPersona = tb_persona.IdPersona AND 
                         fa_cliente.IdPersona = tb_persona.IdPersona
WHERE        (cxc_cobro.cr_estado = N'A') AND (cxc_cobro_tipo.ESRetenIVA = 'S' OR
                         cxc_cobro_tipo.ESRetenFTE = 'S') AND NOT EXISTS
                             (SELECT        A.IdEmpresa
                               FROM            cxc_cobro_det A
                               WHERE        A.IdEmpresa = cxc_cobro.IdEmpresa AND A.IdCobro = cxc_cobro.IdCobro AND A.IdSucursal = cxc_cobro.IdSucursal)
UNION
SELECT        FA.IdEmpresa, dbo.tb_sucursal.Su_Descripcion AS nom_sucursal, NULL AS Expr1, FA.vt_fecha AS Fecha_cobro, FA.vt_fecha  AS Fecha_Retencion, NULL 
                         AS Num_Retencion, NULL AS Expr2, dbo.fa_cliente.IdCliente, dbo.tb_persona.pe_nombreCompleto AS nom_cliente, dbo.tb_persona.pe_cedulaRuc AS ruc_ced, NULL 
                         AS Expr3, NULL AS Base_RIva, NULL AS Base_RFte, NULL AS Valor_Ret, FA.IdCbteVta, 'FT#:' + FA.vt_NumFactura AS num_factura, FA.vt_fecha AS Fecha_Fact, 
                         FA.vt_tipoDoc, 'SIN_RT' AS Tipo_Retencion, 'COMPROBANTES SIN RETENCION' AS nomTipo_Retencion, 'COMPROBANTES SIN RETENCION' AS nomTipoCobro
FROM            dbo.fa_cliente INNER JOIN
                         dbo.fa_factura AS FA ON dbo.fa_cliente.IdEmpresa = FA.IdEmpresa AND dbo.fa_cliente.IdCliente = FA.IdCliente INNER JOIN
                         dbo.vwfa_factura_Subtotal_Iva ON dbo.vwfa_factura_Subtotal_Iva.IdEmpresa = FA.IdEmpresa AND dbo.vwfa_factura_Subtotal_Iva.IdSucursal = FA.IdSucursal AND 
                         dbo.vwfa_factura_Subtotal_Iva.IdBodega = FA.IdBodega AND dbo.vwfa_factura_Subtotal_Iva.IdCbteVta = FA.IdCbteVta INNER JOIN
                         dbo.tb_sucursal ON FA.IdEmpresa = dbo.tb_sucursal.IdEmpresa AND FA.IdSucursal = dbo.tb_sucursal.IdSucursal INNER JOIN
                         dbo.tb_persona ON dbo.fa_cliente.IdPersona = dbo.tb_persona.IdPersona
WHERE        (NOT EXISTS
                             (SELECT        *
                               FROM            dbo.cxc_cobro INNER JOIN
                                                         dbo.cxc_cobro_det ON dbo.cxc_cobro.IdEmpresa = dbo.cxc_cobro_det.IdEmpresa AND dbo.cxc_cobro.IdSucursal = dbo.cxc_cobro_det.IdSucursal AND
                                                          dbo.cxc_cobro.IdCobro = dbo.cxc_cobro_det.IdCobro INNER JOIN
                                                         dbo.cxc_cobro_tipo AS cxc_cobro_tipo_1 ON dbo.cxc_cobro.IdCobro_tipo = cxc_cobro_tipo_1.IdCobro_tipo
                               WHERE        (cxc_cobro_tipo_1.ESRetenFTE = 'S') AND (FA.IdEmpresa = dbo.cxc_cobro_det.IdEmpresa) AND (FA.IdSucursal = dbo.cxc_cobro_det.IdSucursal) AND 
                                                         (FA.IdBodega = dbo.cxc_cobro_det.IdBodega_Cbte) AND (FA.IdCbteVta = dbo.cxc_cobro_det.IdCbte_vta_nota) AND 
                                                         (FA.vt_tipoDoc = dbo.cxc_cobro_det.dc_TipoDocumento) OR
                                                         (FA.IdEmpresa = dbo.cxc_cobro_det.IdEmpresa) AND (FA.IdSucursal = dbo.cxc_cobro_det.IdSucursal) AND 
                                                         (FA.IdBodega = dbo.cxc_cobro_det.IdBodega_Cbte) AND (FA.IdCbteVta = dbo.cxc_cobro_det.IdCbte_vta_nota) AND 
                                                         (FA.vt_tipoDoc = dbo.cxc_cobro_det.dc_TipoDocumento) AND (cxc_cobro_tipo_1.ESRetenIVA = 'S'))) AND (NOT EXISTS
                             (SELECT        *
                               FROM            dbo.fa_notaCreDeb_x_fa_factura_NotaDeb AS NC
                               WHERE        NC.IdEmpresa_fac_nd_doc_mod = FA.IdEmpresa AND NC.IdSucursal_fac_nd_doc_mod = FA.IdSucursal AND 
                                                         NC.IdBodega_fac_nd_doc_mod = FA.IdBodega AND NC.IdCbteVta_fac_nd_doc_mod = FA.IdCbteVta AND NC.vt_tipoDoc = FA.vt_tipoDoc)) AND 
                         FA.Estado = 'A'
						 AND (NOT EXISTS(
								SELECT        dbo.vwfa_factura_SubTotal_Iva_total.IdEmpresa, dbo.vwfa_factura_SubTotal_Iva_total.IdSucursal, dbo.vwfa_factura_SubTotal_Iva_total.IdBodega, 
								dbo.vwfa_factura_SubTotal_Iva_total.IdCbteVta, dbo.cxc_cobro_det.dc_TipoDocumento
								FROM            dbo.cxc_cobro_det INNER JOIN
								dbo.vwfa_factura_SubTotal_Iva_total ON dbo.cxc_cobro_det.IdEmpresa = dbo.vwfa_factura_SubTotal_Iva_total.IdEmpresa AND 
								dbo.cxc_cobro_det.IdSucursal = dbo.vwfa_factura_SubTotal_Iva_total.IdSucursal AND 
								dbo.cxc_cobro_det.IdBodega_Cbte = dbo.vwfa_factura_SubTotal_Iva_total.IdBodega AND 
								dbo.cxc_cobro_det.IdCbte_vta_nota = dbo.vwfa_factura_SubTotal_Iva_total.IdCbteVta
								WHERE cxc_cobro_det.IdEmpresa = fa.IdEmpresa
								and cxc_cobro_det.IdSucursal = fa.IdSucursal
								and cxc_cobro_det.IdBodega_Cbte = fa.IdBodega
								and cxc_cobro_det.IdCbte_vta_nota = fa.IdCbteVta
								and cxc_cobro_det.dc_TipoDocumento = fa.vt_tipoDoc
								GROUP BY dbo.vwfa_factura_SubTotal_Iva_total.IdEmpresa, dbo.vwfa_factura_SubTotal_Iva_total.IdSucursal, dbo.vwfa_factura_SubTotal_Iva_total.IdBodega, 
								dbo.vwfa_factura_SubTotal_Iva_total.IdCbteVta, dbo.cxc_cobro_det.dc_TipoDocumento, dbo.vwfa_factura_SubTotal_Iva_total.vt_total
								HAVING        (dbo.cxc_cobro_det.dc_TipoDocumento = 'FACT') AND (round(dbo.vwfa_factura_SubTotal_Iva_total.vt_total,2) -round(SUM(isnull(dbo.cxc_cobro_det.dc_ValorPago,0)),2) = 0)
						 ))