CREATE VIEW [Fj_servindustrias].[vwFAC_FJ_Rpt017]
AS
SELECT isnull(ROW_NUMBER() OVER (ORDER BY A.IdEmpresa), 0) AS IdRow, A.*
FROM     (SELECT dbo.fa_factura.IdEmpresa, dbo.fa_factura.IdSucursal, dbo.fa_factura.IdBodega, dbo.fa_factura.IdCbteVta, dbo.fa_factura.vt_tipoDoc, dbo.fa_factura.vt_NumFactura, dbo.fa_factura.vt_fecha, dbo.fa_factura.IdCliente, 
                                    dbo.tb_persona.pe_nombreCompleto, det.vt_Subtotal, det.vt_iva, det.vt_total vt_total, ISNULL(cobro.dc_ValorPago, 0) AS dc_ValorPago, ROUND((ROUND(det.vt_total, 2) 
                                    - round(isnull(reten.dc_ValorPago, 0), 2)) - ROUND(ISNULL(cobro.dc_ValorPago, 0), 2), 2) AS vt_saldo, ult_cobro.cr_fecha, CASE WHEN ult_cobro.cr_fecha IS NULL 
                                    THEN 'PENDIENTE' WHEN nc.IdEmpresa_fac_nd_doc_mod IS NOT NULL THEN 'CRUZADO' WHEN ult_cobro.cr_fecha IS NOT NULL AND ROUND(ROUND(det.vt_total, 2) - ROUND(ISNULL(cobro.dc_ValorPago, 0), 2) 
                                    - round(isnull(reten.dc_ValorPago, 0), 2), 2) > 0 THEN 'ABONADO' ELSE 'COBRADO' END AS Estado_cobro, Fj_servindustrias.fa_factura_fj.num_oc, cobro.cant_cobro, CAST(CAST(YEAR(dbo.fa_factura.vt_fecha) AS varchar(4)) 
                                    + RIGHT('00' + CAST(MONTH(dbo.fa_factura.vt_fecha) AS varchar(2)), 2) AS int) AS IdPeriodo, 'FACTURACION ' + UPPER(dbo.vwct_periodo.smes) + ' ' + CAST(YEAR(dbo.fa_factura.vt_fecha) AS varchar(20)) AS nombre_periodo, 
                                    Fj_servindustrias.fa_factura_fj.descripcion_fact AS vt_Observacion
                  FROM      dbo.fa_factura INNER JOIN
                                    dbo.fa_cliente ON dbo.fa_factura.IdEmpresa = dbo.fa_cliente.IdEmpresa AND dbo.fa_factura.IdCliente = dbo.fa_cliente.IdCliente INNER JOIN
                                    dbo.tb_persona ON dbo.fa_cliente.IdPersona = dbo.tb_persona.IdPersona LEFT OUTER JOIN
                                    Fj_servindustrias.fa_factura_fj ON dbo.fa_factura.IdEmpresa = Fj_servindustrias.fa_factura_fj.IdEmpresa AND dbo.fa_factura.IdSucursal = Fj_servindustrias.fa_factura_fj.IdSucursal AND 
                                    dbo.fa_factura.IdBodega = Fj_servindustrias.fa_factura_fj.IdBodega AND dbo.fa_factura.IdCbteVta = Fj_servindustrias.fa_factura_fj.IdCbteVta LEFT OUTER JOIN
                                        (SELECT IdEmpresa, IdSucursal, IdBodega, IdCbteVta, SUM(vt_Subtotal) AS vt_Subtotal, SUM(vt_iva) AS vt_iva, SUM(vt_total) AS vt_total
                                         FROM      dbo.fa_factura_det
                                         GROUP BY IdEmpresa, IdSucursal, IdBodega, IdCbteVta) AS det ON det.IdEmpresa = dbo.fa_factura.IdEmpresa AND det.IdSucursal = dbo.fa_factura.IdSucursal AND det.IdBodega = dbo.fa_factura.IdBodega AND 
                                    det.IdCbteVta = dbo.fa_factura.IdCbteVta LEFT OUTER JOIN
                                        (SELECT cxc_cobro_det_1.IdEmpresa, cxc_cobro_det_1.IdSucursal, IdBodega_Cbte, IdCbte_vta_nota, dc_TipoDocumento, SUM(dc_ValorPago) AS dc_ValorPago, COUNT(IdBodega_Cbte) AS cant_cobro
                                         FROM      dbo.cxc_cobro_det AS cxc_cobro_det_1 INNER JOIN
                                                           dbo.cxc_cobro ON cxc_cobro_det_1.IdEmpresa = dbo.cxc_cobro.IdEmpresa AND cxc_cobro_det_1.IdSucursal = dbo.cxc_cobro.IdSucursal AND cxc_cobro_det_1.IdCobro = dbo.cxc_cobro.IdCobro INNER JOIN
                                                           dbo.cxc_cobro_tipo ON dbo.cxc_cobro.IdCobro_tipo = dbo.cxc_cobro_tipo.IdCobro_tipo
                                         WHERE   cxc_cobro_tipo.ESRetenFTE = 'N' AND cxc_cobro_tipo.ESRetenIVA = 'N'
                                         GROUP BY cxc_cobro_det_1.IdEmpresa, cxc_cobro_det_1.IdSucursal, cxc_cobro_det_1.IdBodega_Cbte, cxc_cobro_det_1.IdCbte_vta_nota, cxc_cobro_det_1.dc_TipoDocumento) AS cobro ON 
                                    cobro.IdEmpresa = dbo.fa_factura.IdEmpresa AND cobro.IdSucursal = dbo.fa_factura.IdSucursal AND cobro.IdBodega_Cbte = dbo.fa_factura.IdBodega AND cobro.IdCbte_vta_nota = dbo.fa_factura.IdCbteVta AND 
                                    cobro.dc_TipoDocumento = dbo.fa_factura.vt_tipoDoc LEFT OUTER JOIN
                                        (SELECT cxc_cobro_det_1.IdEmpresa, cxc_cobro_det_1.IdSucursal, cxc_cobro_det_1.IdBodega_Cbte, cxc_cobro_det_1.IdCbte_vta_nota, cxc_cobro_det_1.dc_TipoDocumento, MAX(dbo.cxc_cobro.cr_fecha) AS cr_fecha
                                         FROM      dbo.cxc_cobro_det AS cxc_cobro_det_1 INNER JOIN
                                                           dbo.cxc_cobro ON cxc_cobro_det_1.IdEmpresa = dbo.cxc_cobro.IdEmpresa AND cxc_cobro_det_1.IdSucursal = dbo.cxc_cobro.IdSucursal AND cxc_cobro_det_1.IdCobro = dbo.cxc_cobro.IdCobro INNER JOIN
                                                           dbo.cxc_cobro_tipo ON dbo.cxc_cobro.IdCobro_tipo = dbo.cxc_cobro_tipo.IdCobro_tipo
                                         WHERE   cxc_cobro_tipo.ESRetenFTE = 'N' AND cxc_cobro_tipo.ESRetenIVA = 'N'
                                         GROUP BY cxc_cobro_det_1.IdEmpresa, cxc_cobro_det_1.IdSucursal, cxc_cobro_det_1.IdBodega_Cbte, cxc_cobro_det_1.IdCbte_vta_nota, cxc_cobro_det_1.dc_TipoDocumento) AS ult_cobro ON 
                                    ult_cobro.IdEmpresa = dbo.fa_factura.IdEmpresa AND ult_cobro.IdSucursal = dbo.fa_factura.IdSucursal AND ult_cobro.IdBodega_Cbte = dbo.fa_factura.IdBodega AND ult_cobro.IdCbte_vta_nota = dbo.fa_factura.IdCbteVta AND 
                                    ult_cobro.dc_TipoDocumento = dbo.fa_factura.vt_tipoDoc LEFT OUTER JOIN
                                    dbo.vwct_periodo ON dbo.fa_factura.IdEmpresa = dbo.vwct_periodo.IdEmpresa AND dbo.vwct_periodo.IdPeriodo = CAST(CAST(YEAR(dbo.fa_factura.vt_fecha) AS varchar(4)) 
                                    + RIGHT('00' + CAST(MONTH(dbo.fa_factura.vt_fecha) AS varchar(2)), 2) AS int) LEFT OUTER JOIN
                                        (SELECT dbo.fa_notaCreDeb_x_fa_factura_NotaDeb.IdEmpresa_fac_nd_doc_mod, dbo.fa_notaCreDeb_x_fa_factura_NotaDeb.IdSucursal_fac_nd_doc_mod, 
                                                           dbo.fa_notaCreDeb_x_fa_factura_NotaDeb.IdBodega_fac_nd_doc_mod, dbo.fa_notaCreDeb_x_fa_factura_NotaDeb.IdCbteVta_fac_nd_doc_mod, dbo.fa_notaCreDeb_x_fa_factura_NotaDeb.vt_tipoDoc
                                         FROM      dbo.fa_notaCreDeb_x_fa_factura_NotaDeb INNER JOIN
                                                           dbo.fa_notaCreDeb ON dbo.fa_notaCreDeb_x_fa_factura_NotaDeb.IdEmpresa_nt = dbo.fa_notaCreDeb.IdEmpresa AND 
                                                           dbo.fa_notaCreDeb_x_fa_factura_NotaDeb.IdSucursal_nt = dbo.fa_notaCreDeb.IdSucursal AND dbo.fa_notaCreDeb_x_fa_factura_NotaDeb.IdBodega_nt = dbo.fa_notaCreDeb.IdBodega AND 
                                                           dbo.fa_notaCreDeb_x_fa_factura_NotaDeb.IdNota_nt = dbo.fa_notaCreDeb.IdNota
                                         WHERE   (dbo.fa_notaCreDeb.NaturalezaNota = 'INT')
                                         GROUP BY dbo.fa_notaCreDeb_x_fa_factura_NotaDeb.IdEmpresa_fac_nd_doc_mod, dbo.fa_notaCreDeb_x_fa_factura_NotaDeb.IdSucursal_fac_nd_doc_mod, 
                                                           dbo.fa_notaCreDeb_x_fa_factura_NotaDeb.IdBodega_fac_nd_doc_mod, dbo.fa_notaCreDeb_x_fa_factura_NotaDeb.IdCbteVta_fac_nd_doc_mod, dbo.fa_notaCreDeb_x_fa_factura_NotaDeb.vt_tipoDoc) AS nc ON 
                                    dbo.fa_factura.IdEmpresa = nc.IdEmpresa_fac_nd_doc_mod AND dbo.fa_factura.IdSucursal = nc.IdSucursal_fac_nd_doc_mod AND dbo.fa_factura.IdBodega = nc.IdBodega_fac_nd_doc_mod AND 
                                    dbo.fa_factura.IdCbteVta = nc.IdCbteVta_fac_nd_doc_mod AND dbo.fa_factura.vt_tipoDoc = nc.vt_tipoDoc LEFT JOIN
                                        (SELECT cxc_cobro_det_1.IdEmpresa, cxc_cobro_det_1.IdSucursal, cxc_cobro_det_1.IdBodega_Cbte, cxc_cobro_det_1.IdCbte_vta_nota, cxc_cobro_det_1.dc_TipoDocumento, SUM(dc_ValorPago) AS dc_ValorPago
                                         FROM      dbo.cxc_cobro_det AS cxc_cobro_det_1 INNER JOIN
                                                           dbo.cxc_cobro ON cxc_cobro_det_1.IdEmpresa = dbo.cxc_cobro.IdEmpresa AND cxc_cobro_det_1.IdSucursal = dbo.cxc_cobro.IdSucursal AND cxc_cobro_det_1.IdCobro = dbo.cxc_cobro.IdCobro INNER JOIN
                                                           dbo.cxc_cobro_tipo ON dbo.cxc_cobro.IdCobro_tipo = dbo.cxc_cobro_tipo.IdCobro_tipo
                                         WHERE   cxc_cobro_tipo.ESRetenFTE = 'S' OR
                                                           cxc_cobro_tipo.ESRetenIVA = 'S'
                                         GROUP BY cxc_cobro_det_1.IdEmpresa, cxc_cobro_det_1.IdSucursal, cxc_cobro_det_1.IdBodega_Cbte, cxc_cobro_det_1.IdCbte_vta_nota, cxc_cobro_det_1.dc_TipoDocumento) reten ON 
                                    reten.IdEmpresa = dbo.fa_factura.IdEmpresa AND reten.IdSucursal = dbo.fa_factura.IdSucursal AND reten.IdBodega_Cbte = dbo.fa_factura.IdBodega AND reten.IdCbte_vta_nota = dbo.fa_factura.IdCbteVta AND 
                                    reten.dc_TipoDocumento = dbo.fa_factura.vt_tipoDoc
                  WHERE   (dbo.fa_factura.Estado = 'A')
                  UNION
                  SELECT fa_notaCreDeb.IdEmpresa, fa_notaCreDeb.IdSucursal, fa_notaCreDeb.IdBodega, fa_notaCreDeb.IdNota, fa_notaCreDeb.CodDocumentoTipo, fa_notaCreDeb.CodNota, fa_notaCreDeb.no_fecha, fa_notaCreDeb.IdCliente, 
                                    tb_persona.pe_nombreCompleto, det.vt_Subtotal, det.vt_iva, det.vt_total, ISNULL(cobro.dc_ValorPago, 0) AS dc_ValorPago, ROUND(ROUND(det.vt_total, 2) - ROUND(ISNULL(cobro.dc_ValorPago, 0), 2), 2) AS vt_saldo, 
                                    ult_cobro.cr_fecha, CASE WHEN ult_cobro.cr_fecha IS NULL THEN 'PENDIENTE' WHEN nc.IdEmpresa_fac_nd_doc_mod IS NOT NULL THEN 'CRUZADO' WHEN ult_cobro.cr_fecha IS NOT NULL AND ROUND(ROUND(det.vt_total, 2) 
                                    - ROUND(ISNULL(cobro.dc_ValorPago, 0), 2), 2) > 0 THEN 'ABONADO' ELSE 'COBRADO' END AS Estado_cobro, '' num_oc, cobro.cant_cobro, CAST(CAST(YEAR(fa_notaCreDeb.no_fecha) AS varchar(4)) 
                                    + RIGHT('00' + CAST(MONTH(fa_notaCreDeb.no_fecha) AS varchar(2)), 2) AS int) AS IdPeriodo, 'FACTURACION ' + UPPER(vwct_periodo.smes) + ' ' + cast(YEAR(fa_notaCreDeb.no_fecha) AS varchar(20)) AS nombre_periodo, 
                                    fa_notaCreDeb.sc_observacion
                  FROM     fa_notaCreDeb INNER JOIN
                                    fa_cliente ON fa_notaCreDeb.IdEmpresa = fa_cliente.IdEmpresa AND fa_notaCreDeb.IdCliente = fa_cliente.IdCliente INNER JOIN
                                    tb_persona ON fa_cliente.IdPersona = tb_persona.IdPersona LEFT OUTER JOIN
                                        (SELECT IdEmpresa, IdSucursal, IdBodega, IdNota, SUM(sc_subtotal) AS vt_Subtotal, SUM(sc_iva) AS vt_iva, SUM(sc_total) AS vt_total
                                         FROM      fa_notaCreDeb_det
                                         GROUP BY IdEmpresa, IdSucursal, IdBodega, IdNota) AS det ON det.IdEmpresa = fa_notaCreDeb.IdEmpresa AND det.IdSucursal = fa_notaCreDeb.IdSucursal AND det.IdBodega = fa_notaCreDeb.IdBodega AND 
                                    det.IdNota = fa_notaCreDeb.IdNota LEFT OUTER JOIN
                                        (SELECT IdEmpresa, IdSucursal, IdBodega_Cbte, IdCbte_vta_nota, dc_TipoDocumento, SUM(dc_ValorPago) AS dc_ValorPago, COUNT(IdBodega_Cbte) AS cant_cobro
                                         FROM      cxc_cobro_det
                                         GROUP BY IdEmpresa, IdSucursal, IdBodega_Cbte, IdCbte_vta_nota, dc_TipoDocumento) AS cobro ON cobro.IdEmpresa = fa_notaCreDeb.IdEmpresa AND cobro.IdSucursal = fa_notaCreDeb.IdSucursal AND 
                                    cobro.IdBodega_Cbte = fa_notaCreDeb.IdBodega AND cobro.IdCbte_vta_nota = fa_notaCreDeb.IdNota AND cobro.dc_TipoDocumento = fa_notaCreDeb.CodDocumentoTipo LEFT OUTER JOIN
                                        (SELECT cxc_cobro_det_1.IdEmpresa, cxc_cobro_det_1.IdSucursal, cxc_cobro_det_1.IdBodega_Cbte, cxc_cobro_det_1.IdCbte_vta_nota, cxc_cobro_det_1.dc_TipoDocumento, MAX(cxc_cobro.cr_fecha) AS cr_fecha
                                         FROM      cxc_cobro_det AS cxc_cobro_det_1 INNER JOIN
                                                           cxc_cobro ON cxc_cobro_det_1.IdEmpresa = cxc_cobro.IdEmpresa AND cxc_cobro_det_1.IdSucursal = cxc_cobro.IdSucursal AND cxc_cobro_det_1.IdCobro = cxc_cobro.IdCobro
                                         GROUP BY cxc_cobro_det_1.IdEmpresa, cxc_cobro_det_1.IdSucursal, cxc_cobro_det_1.IdBodega_Cbte, cxc_cobro_det_1.IdCbte_vta_nota, cxc_cobro_det_1.dc_TipoDocumento) AS ult_cobro ON 
                                    ult_cobro.IdEmpresa = fa_notaCreDeb.IdEmpresa AND ult_cobro.IdSucursal = fa_notaCreDeb.IdSucursal AND ult_cobro.IdBodega_Cbte = fa_notaCreDeb.IdBodega AND ult_cobro.IdCbte_vta_nota = fa_notaCreDeb.IdNota AND 
                                    ult_cobro.dc_TipoDocumento = fa_notaCreDeb.CodDocumentoTipo LEFT JOIN
                                    vwct_periodo ON fa_notaCreDeb.IdEmpresa = vwct_periodo.IdEmpresa AND vwct_periodo.IdPeriodo = CAST(CAST(YEAR(fa_notaCreDeb.no_fecha) AS varchar(4)) + RIGHT('00' + CAST(MONTH(fa_notaCreDeb.no_fecha) 
                                    AS varchar(2)), 2) AS int) LEFT JOIN
                                        (SELECT IdEmpresa_fac_nd_doc_mod, IdSucursal_fac_nd_doc_mod, IdBodega_fac_nd_doc_mod, IdCbteVta_fac_nd_doc_mod, vt_tipoDoc
                                         FROM      dbo.fa_notaCreDeb_x_fa_factura_NotaDeb
                                         GROUP BY IdEmpresa_fac_nd_doc_mod, IdSucursal_fac_nd_doc_mod, IdBodega_fac_nd_doc_mod, IdCbteVta_fac_nd_doc_mod, vt_tipoDoc) nc ON fa_notaCreDeb.IdEmpresa = nc.IdEmpresa_fac_nd_doc_mod AND 
                                    fa_notaCreDeb.IdSucursal = nc.IdSucursal_fac_nd_doc_mod AND fa_notaCreDeb.IdBodega = nc.IdBodega_fac_nd_doc_mod AND fa_notaCreDeb.IdNota = nc.IdCbteVta_fac_nd_doc_mod AND 
                                    fa_notaCreDeb.CodDocumentoTipo = nc.vt_tipoDoc
                  WHERE  fa_notaCreDeb.Estado = 'A' AND fa_notaCreDeb.CreDeb = 'D') A