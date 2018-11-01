CREATE VIEW [web].[VWFAC_005]
AS
SELECT        dbo.fa_factura.IdEmpresa, dbo.fa_factura.IdSucursal, dbo.fa_factura.IdBodega, dbo.fa_factura.IdCbteVta, dbo.fa_factura.vt_tipoDoc, dbo.fa_factura.IdCliente, dbo.fa_factura.IdContacto, 
                         LTRIM(RTRIM(dbo.tb_persona.pe_nombreCompleto)) AS NomCliente, LTRIM(RTRIM(dbo.fa_cliente_contactos.Nombres)) AS NomContacto, dbo.fa_factura.vt_fecha, ISNULL(FIVA0.SubtotalIVA0, 0) AS SubtotalIVA0, 
                         ISNULL(FIVA.SubtotalIVA, 0) AS SubtotalIVA, ISNULL(FIVA.vt_iva, 0) vt_iva, ISNULL(FIVA0.SubtotalIVA0, 0) + ISNULL(FIVA.SubtotalIVA, 0) + ISNULL(FIVA.vt_iva, 0) AS Total, ISNULL(RTIVA.VRetenIVA, 0) AS VRetenIVA, 
                         ISNULL(RTFTE.VRetenFTE, 0) AS VRetenFTE, ISNULL(FIVA0.SubtotalIVA0, 0) + ISNULL(FIVA.SubtotalIVA, 0) + ISNULL(FIVA.vt_iva, 0) - ISNULL(RTIVA.VRetenIVA, 0) - ISNULL(RTFTE.VRetenFTE, 0) AS ValorACobrar, 
                         ISNULL(COBR.VCobrado, 0) VCobrado, ISNULL(FIVA0.SubtotalIVA0, 0) + ISNULL(FIVA.SubtotalIVA, 0) + ISNULL(FIVA.vt_iva, 0) - ISNULL(COBR.VCobrado, 0) AS Saldo, 'FACTURA' AS TipoDocumento, 
                         CASE WHEN tb_persona.IdTipoDocumento = 'PAS' AND FIVA0.IdEmpresa IS NOT NULL AND FIVA.IdEmpresa IS NULL THEN CAST(1 AS BIT) ELSE CAST(0 AS BIT) END AS EsExportacion, Su_Descripcion, Su_CodigoEstablecimiento
FROM            dbo.fa_cliente INNER JOIN
                         dbo.fa_cliente_contactos ON dbo.fa_cliente.IdEmpresa = dbo.fa_cliente_contactos.IdEmpresa AND dbo.fa_cliente.IdCliente = dbo.fa_cliente_contactos.IdCliente INNER JOIN
                         dbo.tb_persona ON dbo.fa_cliente.IdPersona = dbo.tb_persona.IdPersona RIGHT OUTER JOIN
                         dbo.fa_factura ON dbo.fa_cliente_contactos.IdEmpresa = dbo.fa_factura.IdEmpresa AND dbo.fa_cliente_contactos.IdCliente = dbo.fa_factura.IdCliente AND 
                         dbo.fa_cliente_contactos.IdContacto = dbo.fa_factura.IdContacto LEFT OUTER JOIN
                             (SELECT        IdEmpresa, IdSucursal, IdBodega, IdCbteVta, SUM(vt_cantidad * vt_PrecioFinal) AS SubtotalIVA0
                               FROM            dbo.fa_factura_det
                               WHERE        (vt_por_iva = 0)
                               GROUP BY IdEmpresa, IdSucursal, IdBodega, IdCbteVta) AS FIVA0 ON dbo.fa_factura.IdEmpresa = FIVA0.IdEmpresa AND dbo.fa_factura.IdSucursal = FIVA0.IdSucursal AND dbo.fa_factura.IdBodega = FIVA0.IdBodega AND 
                         dbo.fa_factura.IdCbteVta = FIVA0.IdCbteVta LEFT OUTER JOIN
                             (SELECT        IdEmpresa, IdSucursal, IdBodega, IdCbteVta, SUM(vt_cantidad * vt_PrecioFinal) AS SubtotalIVA, sum(vt_iva) vt_iva
                               FROM            dbo.fa_factura_det
                               WHERE        (vt_por_iva <> 0)
                               GROUP BY IdEmpresa, IdSucursal, IdBodega, IdCbteVta) AS FIVA ON dbo.fa_factura.IdEmpresa = FIVA.IdEmpresa AND dbo.fa_factura.IdSucursal = FIVA.IdSucursal AND dbo.fa_factura.IdBodega = FIVA.IdBodega AND 
                         dbo.fa_factura.IdCbteVta = FIVA.IdCbteVta LEFT OUTER JOIN
                             (SELECT        dbo.cxc_cobro_det.IdEmpresa, dbo.cxc_cobro_det.IdSucursal, dbo.cxc_cobro_det.IdBodega_Cbte, dbo.cxc_cobro_det.IdCbte_vta_nota, dbo.cxc_cobro_det.dc_TipoDocumento, 
                                                         SUM(dbo.cxc_cobro_det.dc_ValorPago) AS VRetenIVA
                               FROM            dbo.cxc_cobro_det INNER JOIN
                                                         dbo.cxc_cobro ON dbo.cxc_cobro_det.IdEmpresa = dbo.cxc_cobro.IdEmpresa AND dbo.cxc_cobro_det.IdSucursal = dbo.cxc_cobro.IdSucursal AND dbo.cxc_cobro_det.IdCobro = dbo.cxc_cobro.IdCobro INNER JOIN
                                                         dbo.cxc_cobro_tipo ON dbo.cxc_cobro_det.IdCobro_tipo = dbo.cxc_cobro_tipo.IdCobro_tipo
                               WHERE        (dbo.cxc_cobro.cr_estado = N'A') AND (dbo.cxc_cobro_det.estado = 'A') AND (dbo.cxc_cobro_tipo.ESRetenIVA = 'S') AND (dbo.cxc_cobro_det.dc_TipoDocumento = 'FACT')
                               GROUP BY dbo.cxc_cobro_det.IdEmpresa, dbo.cxc_cobro_det.IdSucursal, dbo.cxc_cobro_det.IdBodega_Cbte, dbo.cxc_cobro_det.IdCbte_vta_nota, dbo.cxc_cobro_det.dc_TipoDocumento) AS RTIVA ON 
                         dbo.fa_factura.IdEmpresa = RTIVA.IdEmpresa AND dbo.fa_factura.IdSucursal = RTIVA.IdSucursal AND dbo.fa_factura.IdBodega = RTIVA.IdBodega_Cbte AND dbo.fa_factura.IdCbteVta = RTIVA.IdCbte_vta_nota AND 
                         dbo.fa_factura.vt_tipoDoc = RTIVA.dc_TipoDocumento LEFT OUTER JOIN
                             (SELECT        dbo.cxc_cobro_det.IdEmpresa, dbo.cxc_cobro_det.IdSucursal, dbo.cxc_cobro_det.IdBodega_Cbte, dbo.cxc_cobro_det.IdCbte_vta_nota, dbo.cxc_cobro_det.dc_TipoDocumento, 
                                                         SUM(dbo.cxc_cobro_det.dc_ValorPago) AS VRetenFTE
                               FROM            dbo.cxc_cobro_det INNER JOIN
                                                         dbo.cxc_cobro ON dbo.cxc_cobro_det.IdEmpresa = dbo.cxc_cobro.IdEmpresa AND dbo.cxc_cobro_det.IdSucursal = dbo.cxc_cobro.IdSucursal AND dbo.cxc_cobro_det.IdCobro = dbo.cxc_cobro.IdCobro INNER JOIN
                                                         dbo.cxc_cobro_tipo ON dbo.cxc_cobro_det.IdCobro_tipo = dbo.cxc_cobro_tipo.IdCobro_tipo
                               WHERE        (dbo.cxc_cobro.cr_estado = N'A') AND (dbo.cxc_cobro_det.estado = 'A') AND (dbo.cxc_cobro_tipo.ESRetenFTE = 'S') AND (dbo.cxc_cobro_det.dc_TipoDocumento = 'FACT')
                               GROUP BY dbo.cxc_cobro_det.IdEmpresa, dbo.cxc_cobro_det.IdSucursal, dbo.cxc_cobro_det.IdBodega_Cbte, dbo.cxc_cobro_det.IdCbte_vta_nota, dbo.cxc_cobro_det.dc_TipoDocumento) AS RTFTE ON 
                         dbo.fa_factura.IdEmpresa = RTFTE.IdEmpresa AND dbo.fa_factura.IdSucursal = RTFTE.IdSucursal AND dbo.fa_factura.IdBodega = RTFTE.IdBodega_Cbte AND dbo.fa_factura.IdCbteVta = RTFTE.IdCbte_vta_nota AND 
                         dbo.fa_factura.vt_tipoDoc = RTFTE.dc_TipoDocumento LEFT OUTER JOIN
                             (SELECT        dbo.cxc_cobro_det.IdEmpresa, dbo.cxc_cobro_det.IdSucursal, dbo.cxc_cobro_det.IdBodega_Cbte, dbo.cxc_cobro_det.IdCbte_vta_nota, dbo.cxc_cobro_det.dc_TipoDocumento, 
                                                         SUM(dbo.cxc_cobro_det.dc_ValorPago) AS VCobrado
                               FROM            dbo.cxc_cobro_det INNER JOIN
                                                         dbo.cxc_cobro ON dbo.cxc_cobro_det.IdEmpresa = dbo.cxc_cobro.IdEmpresa AND dbo.cxc_cobro_det.IdSucursal = dbo.cxc_cobro.IdSucursal AND dbo.cxc_cobro_det.IdCobro = dbo.cxc_cobro.IdCobro INNER JOIN
                                                         dbo.cxc_cobro_tipo ON dbo.cxc_cobro_det.IdCobro_tipo = dbo.cxc_cobro_tipo.IdCobro_tipo
                               WHERE        (dbo.cxc_cobro.cr_estado = N'A') AND (dbo.cxc_cobro_det.estado = 'A') AND (dbo.cxc_cobro_det.dc_TipoDocumento = 'FACT')
                               GROUP BY dbo.cxc_cobro_det.IdEmpresa, dbo.cxc_cobro_det.IdSucursal, dbo.cxc_cobro_det.IdBodega_Cbte, dbo.cxc_cobro_det.IdCbte_vta_nota, dbo.cxc_cobro_det.dc_TipoDocumento) AS COBR ON 
                         dbo.fa_factura.IdEmpresa = COBR.IdEmpresa AND dbo.fa_factura.IdSucursal = COBR.IdSucursal AND dbo.fa_factura.IdBodega = COBR.IdBodega_Cbte AND dbo.fa_factura.IdCbteVta = COBR.IdCbte_vta_nota AND 
                         dbo.fa_factura.vt_tipoDoc = COBR.dc_TipoDocumento
						 LEFT JOIN tb_sucursal as su on dbo.fa_factura.IdEmpresa = su.IdEmpresa and fa_factura.IdSucursal = su.IdSucursal
WHERE        (dbo.fa_factura.Estado = 'A')
UNION ALL
SELECT        dbo.fa_notaCreDeb.IdEmpresa, dbo.fa_notaCreDeb.IdSucursal, dbo.fa_notaCreDeb.IdBodega, dbo.fa_notaCreDeb.IdNota, dbo.fa_notaCreDeb.CodDocumentoTipo, dbo.fa_notaCreDeb.IdCliente, 1 IdContacto, 
                         LTRIM(RTRIM(dbo.tb_persona.pe_nombreCompleto)) AS NomCliente, LTRIM(RTRIM(dbo.tb_persona.pe_nombreCompleto)) AS NomContacto, dbo.fa_notaCreDeb.no_fecha, ISNULL(FIVA0.SubtotalIVA0, 0) AS SubtotalIVA0, 
                         ISNULL(FIVA.SubtotalIVA, 0) AS SubtotalIVA, ISNULL(FIVA.vt_iva, 0) vt_iva, ISNULL(FIVA0.SubtotalIVA0, 0) + ISNULL(FIVA.SubtotalIVA, 0) + ISNULL(FIVA.vt_iva, 0) AS Total, ISNULL(RTIVA.VRetenIVA, 0) AS VRetenIVA, 
                         ISNULL(RTFTE.VRetenFTE, 0) AS VRetenFTE, ISNULL(FIVA0.SubtotalIVA0, 0) + ISNULL(FIVA.SubtotalIVA, 0) + ISNULL(FIVA.vt_iva, 0) - ISNULL(RTIVA.VRetenIVA, 0) - ISNULL(RTFTE.VRetenFTE, 0) AS ValorACobrar, 
                         ISNULL(COBR.VCobrado, 0) VCobrado, ISNULL(FIVA0.SubtotalIVA0, 0) + ISNULL(FIVA.SubtotalIVA, 0) + ISNULL(FIVA.vt_iva, 0) - ISNULL(COBR.VCobrado, 0) AS Saldo, 'NOTA DE DEBITO' AS TipoDocumento, CAST(0 AS BIT) 
                         AS EsExportacion, Su_Descripcion, Su_CodigoEstablecimiento
FROM            dbo.fa_cliente INNER JOIN
                         dbo.tb_persona ON dbo.fa_cliente.IdPersona = dbo.tb_persona.IdPersona RIGHT OUTER JOIN
                         dbo.fa_notaCreDeb ON dbo.fa_cliente.IdEmpresa = dbo.fa_notaCreDeb.IdEmpresa AND dbo.fa_cliente.IdCliente = dbo.fa_notaCreDeb.IdCliente LEFT OUTER JOIN
                             (SELECT        IdEmpresa, IdSucursal, IdBodega, IdNota, SUM(sc_cantidad * sc_precioFinal) AS SubtotalIVA0
                               FROM            dbo.fa_notaCreDeb_det
                               WHERE        (vt_por_iva = 0)
                               GROUP BY IdEmpresa, IdSucursal, IdBodega, IdNota) AS FIVA0 ON dbo.fa_notaCreDeb.IdEmpresa = FIVA0.IdEmpresa AND dbo.fa_notaCreDeb.IdSucursal = FIVA0.IdSucursal AND 
                         dbo.fa_notaCreDeb.IdBodega = FIVA0.IdBodega AND dbo.fa_notaCreDeb.IdNota = FIVA0.IdNota LEFT OUTER JOIN
                             (SELECT        IdEmpresa, IdSucursal, IdBodega, IdNota, SUM(sc_cantidad * sc_precioFinal) AS SubtotalIVA, sum(sc_iva) vt_iva
                               FROM            dbo.fa_notaCreDeb_det
                               WHERE        (vt_por_iva <> 0)
                               GROUP BY IdEmpresa, IdSucursal, IdBodega, IdNota) AS FIVA ON dbo.fa_notaCreDeb.IdEmpresa = FIVA.IdEmpresa AND dbo.fa_notaCreDeb.IdSucursal = FIVA.IdSucursal AND 
                         dbo.fa_notaCreDeb.IdBodega = FIVA.IdBodega AND dbo.fa_notaCreDeb.IdNota = FIVA.IdNota LEFT OUTER JOIN
                             (SELECT        dbo.cxc_cobro_det.IdEmpresa, dbo.cxc_cobro_det.IdSucursal, dbo.cxc_cobro_det.IdBodega_Cbte, dbo.cxc_cobro_det.IdCbte_vta_nota, dbo.cxc_cobro_det.dc_TipoDocumento, 
                                                         SUM(dbo.cxc_cobro_det.dc_ValorPago) AS VRetenIVA
                               FROM            dbo.cxc_cobro_det INNER JOIN
                                                         dbo.cxc_cobro ON dbo.cxc_cobro_det.IdEmpresa = dbo.cxc_cobro.IdEmpresa AND dbo.cxc_cobro_det.IdSucursal = dbo.cxc_cobro.IdSucursal AND dbo.cxc_cobro_det.IdCobro = dbo.cxc_cobro.IdCobro INNER JOIN
                                                         dbo.cxc_cobro_tipo ON dbo.cxc_cobro_det.IdCobro_tipo = dbo.cxc_cobro_tipo.IdCobro_tipo
                               WHERE        (dbo.cxc_cobro.cr_estado = N'A') AND (dbo.cxc_cobro_det.estado = 'A') AND (dbo.cxc_cobro_tipo.ESRetenIVA = 'S') AND (dbo.cxc_cobro_det.dc_TipoDocumento = 'NTDB')
                               GROUP BY dbo.cxc_cobro_det.IdEmpresa, dbo.cxc_cobro_det.IdSucursal, dbo.cxc_cobro_det.IdBodega_Cbte, dbo.cxc_cobro_det.IdCbte_vta_nota, dbo.cxc_cobro_det.dc_TipoDocumento) AS RTIVA ON 
                         dbo.fa_notaCreDeb.IdEmpresa = RTIVA.IdEmpresa AND dbo.fa_notaCreDeb.IdSucursal = RTIVA.IdSucursal AND dbo.fa_notaCreDeb.IdBodega = RTIVA.IdBodega_Cbte AND dbo.fa_notaCreDeb.IdNota = RTIVA.IdCbte_vta_nota AND 
                         dbo.fa_notaCreDeb.CodDocumentoTipo = RTIVA.dc_TipoDocumento LEFT OUTER JOIN
                             (SELECT        dbo.cxc_cobro_det.IdEmpresa, dbo.cxc_cobro_det.IdSucursal, dbo.cxc_cobro_det.IdBodega_Cbte, dbo.cxc_cobro_det.IdCbte_vta_nota, dbo.cxc_cobro_det.dc_TipoDocumento, 
                                                         SUM(dbo.cxc_cobro_det.dc_ValorPago) AS VRetenFTE
                               FROM            dbo.cxc_cobro_det INNER JOIN
                                                         dbo.cxc_cobro ON dbo.cxc_cobro_det.IdEmpresa = dbo.cxc_cobro.IdEmpresa AND dbo.cxc_cobro_det.IdSucursal = dbo.cxc_cobro.IdSucursal AND dbo.cxc_cobro_det.IdCobro = dbo.cxc_cobro.IdCobro INNER JOIN
                                                         dbo.cxc_cobro_tipo ON dbo.cxc_cobro_det.IdCobro_tipo = dbo.cxc_cobro_tipo.IdCobro_tipo
                               WHERE        (dbo.cxc_cobro.cr_estado = N'A') AND (dbo.cxc_cobro_det.estado = 'A') AND (dbo.cxc_cobro_tipo.ESRetenFTE = 'S') AND (dbo.cxc_cobro_det.dc_TipoDocumento = 'NTDB')
                               GROUP BY dbo.cxc_cobro_det.IdEmpresa, dbo.cxc_cobro_det.IdSucursal, dbo.cxc_cobro_det.IdBodega_Cbte, dbo.cxc_cobro_det.IdCbte_vta_nota, dbo.cxc_cobro_det.dc_TipoDocumento) AS RTFTE ON 
                         dbo.fa_notaCreDeb.IdEmpresa = RTFTE.IdEmpresa AND dbo.fa_notaCreDeb.IdSucursal = RTFTE.IdSucursal AND dbo.fa_notaCreDeb.IdBodega = RTFTE.IdBodega_Cbte AND 
                         dbo.fa_notaCreDeb.IdNota = RTFTE.IdCbte_vta_nota AND dbo.fa_notaCreDeb.CodDocumentoTipo = RTFTE.dc_TipoDocumento LEFT OUTER JOIN
                             (SELECT        dbo.cxc_cobro_det.IdEmpresa, dbo.cxc_cobro_det.IdSucursal, dbo.cxc_cobro_det.IdBodega_Cbte, dbo.cxc_cobro_det.IdCbte_vta_nota, dbo.cxc_cobro_det.dc_TipoDocumento, 
                                                         SUM(dbo.cxc_cobro_det.dc_ValorPago) AS VCobrado
                               FROM            dbo.cxc_cobro_det INNER JOIN
                                                         dbo.cxc_cobro ON dbo.cxc_cobro_det.IdEmpresa = dbo.cxc_cobro.IdEmpresa AND dbo.cxc_cobro_det.IdSucursal = dbo.cxc_cobro.IdSucursal AND dbo.cxc_cobro_det.IdCobro = dbo.cxc_cobro.IdCobro INNER JOIN
                                                         dbo.cxc_cobro_tipo ON dbo.cxc_cobro_det.IdCobro_tipo = dbo.cxc_cobro_tipo.IdCobro_tipo
                               WHERE        (dbo.cxc_cobro.cr_estado = N'A') AND (dbo.cxc_cobro_det.estado = 'A') AND (dbo.cxc_cobro_det.dc_TipoDocumento = 'FACT')
                               GROUP BY dbo.cxc_cobro_det.IdEmpresa, dbo.cxc_cobro_det.IdSucursal, dbo.cxc_cobro_det.IdBodega_Cbte, dbo.cxc_cobro_det.IdCbte_vta_nota, dbo.cxc_cobro_det.dc_TipoDocumento) AS COBR ON 
                         dbo.fa_notaCreDeb.IdEmpresa = COBR.IdEmpresa AND dbo.fa_notaCreDeb.IdSucursal = COBR.IdSucursal AND dbo.fa_notaCreDeb.IdBodega = COBR.IdBodega_Cbte AND dbo.fa_notaCreDeb.IdNota = COBR.IdCbte_vta_nota AND
                          dbo.fa_notaCreDeb.CodDocumentoTipo = COBR.dc_TipoDocumento
						  LEFT JOIN tb_sucursal as su on dbo.fa_notaCreDeb.IdEmpresa = su.IdEmpresa and fa_notaCreDeb.IdSucursal = su.IdSucursal
WHERE        (dbo.fa_notaCreDeb.Estado = 'A') AND (dbo.fa_notaCreDeb.CreDeb = 'D')