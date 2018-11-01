CREATE view vwCXC_Rpt007 as 
SELECT        ISNULL(ROW_NUMBER() OVER (ORDER BY A.IdEmpresa), 0) AS IdRow, *
FROM            (SELECT        dbo.fa_factura.IdEmpresa, dbo.fa_factura.IdSucursal, dbo.fa_factura.IdBodega, dbo.fa_factura.IdCbteVta, dbo.fa_factura.vt_tipoDoc, CONVERT(varchar(3), 
                                                    dbo.fa_factura.vt_serie1) + '-' + CONVERT(varchar(3), dbo.fa_factura.vt_serie2) + '-' + CONVERT(varchar(20), dbo.fa_factura.vt_NumFactura) 
                                                    + ' / ' + cast(dbo.fa_factura.IdCbteVta AS varchar(20)) AS numDocumento, dbo.fa_factura.IdCliente, dbo.fa_factura.vt_fecha, dbo.fa_factura.vt_plazo, 
                                                    dbo.fa_factura.vt_fech_venc, dbo.tb_sucursal.Su_Descripcion, ROUND(SUM(dbo.fa_factura_det.vt_total), 2) AS vt_total, 
                                                    dbo.tb_persona.pe_nombreCompleto, dbo.tb_persona.pe_cedulaRuc, 'Cbte_Vta' AS Tipo, NULL IdEstadoCobro, NULL AS IdCobro, 
                                                    dbo.fa_factura.vt_tipoDoc AS IdCobro_tipo, fa_factura.vt_tipoDoc AS dc_TipoDocumento, dbo.fa_cliente_tipo.Idtipo_cliente, 
                                                    dbo.fa_cliente_tipo.Descripcion_tip_cliente, dbo.fa_factura.vt_Observacion
                          FROM            dbo.fa_factura INNER JOIN
                                                    dbo.tb_sucursal ON dbo.fa_factura.IdEmpresa = dbo.tb_sucursal.IdEmpresa AND dbo.fa_factura.IdSucursal = dbo.tb_sucursal.IdSucursal INNER JOIN
                                                    dbo.fa_factura_det ON dbo.fa_factura.IdEmpresa = dbo.fa_factura_det.IdEmpresa AND dbo.fa_factura.IdSucursal = dbo.fa_factura_det.IdSucursal AND 
                                                    dbo.fa_factura.IdBodega = dbo.fa_factura_det.IdBodega AND dbo.fa_factura.IdCbteVta = dbo.fa_factura_det.IdCbteVta INNER JOIN
                                                    dbo.fa_cliente ON dbo.fa_factura.IdEmpresa = dbo.fa_cliente.IdEmpresa AND dbo.fa_factura.IdCliente = dbo.fa_cliente.IdCliente INNER JOIN
                                                    dbo.tb_persona ON dbo.fa_cliente.IdPersona = dbo.tb_persona.IdPersona INNER JOIN
                                                    DBO.fa_cliente_tipo ON dbo.fa_cliente_tipo.IdEmpresa = dbo.fa_cliente.IdEmpresa AND 
                                                    dbo.fa_cliente_tipo.Idtipo_cliente = dbo.fa_cliente.Idtipo_cliente
													where fa_factura_det.vt_estado='A' and dbo.fa_factura.Estado='A'
                          GROUP BY dbo.fa_factura.IdEmpresa, dbo.fa_factura.IdSucursal, dbo.fa_factura.IdBodega, dbo.fa_factura.IdCbteVta, dbo.fa_factura.vt_tipoDoc, CONVERT(varchar(3), 
                                                    dbo.fa_factura.vt_serie1) + '-' + CONVERT(varchar(3), dbo.fa_factura.vt_serie2) + '-' + CONVERT(varchar(20), dbo.fa_factura.vt_NumFactura), 
                                                    dbo.fa_factura.IdCliente, dbo.fa_factura.vt_fecha, dbo.fa_factura.vt_plazo, dbo.fa_factura.vt_fech_venc, dbo.tb_sucursal.Su_Descripcion, 
                                                    dbo.tb_persona.pe_nombreCompleto, dbo.tb_persona.pe_cedulaRuc, dbo.fa_cliente_tipo.Idtipo_cliente, dbo.fa_cliente_tipo.Descripcion_tip_cliente, 
                                                    dbo.fa_factura.vt_Observacion
                          UNION
                          SELECT        dbo.fa_notaCreDeb.IdEmpresa, dbo.fa_notaCreDeb.IdSucursal, dbo.fa_notaCreDeb.IdBodega, dbo.fa_notaCreDeb.IdNota, 
                                                   (CASE dbo.fa_TipoNota.Tipo WHEN 'C' THEN 'NTCR' ELSE 'NTDB' END) AS vt_tipoDoc, CASE WHEN dbo.fa_notaCreDeb.NumNota_Impresa IS NULL 
                                                   THEN cast(fa_notaCreDeb.IdNota AS varchar(20)) 
                                                   ELSE dbo.fa_notaCreDeb.Serie1 + '-' + dbo.fa_notaCreDeb.Serie2 + '-' + dbo.fa_notaCreDeb.NumNota_Impresa + ' / ' + cast(fa_notaCreDeb.IdNota AS varchar(20))
                                                    END numDocumento, dbo.fa_notaCreDeb.IdCliente, dbo.fa_notaCreDeb.no_fecha, DATEDIFF(day, dbo.fa_notaCreDeb.no_fecha, 
                                                   dbo.fa_notaCreDeb.no_fecha_venc) AS vt_plazo, dbo.fa_notaCreDeb.no_fecha_venc, dbo.tb_sucursal.Su_Descripcion, 
                                                   ROUND(SUM(dbo.fa_notaCreDeb_det.sc_total), 2) AS vt_total, dbo.tb_persona.pe_nombreCompleto, dbo.tb_persona.pe_cedulaRuc, 
                                                   'Cbte_Nd_Nc' AS Tipo, NULL IdEstadoCobro, NULL AS IdCobro, (CASE dbo.fa_TipoNota.Tipo WHEN 'C' THEN 'NTCR' ELSE 'NTDB' END) AS IdCobro_tipo, 
                                                   fa_notaCreDeb.CodDocumentoTipo AS dc_TipoDocumento, dbo.fa_cliente_tipo.Idtipo_cliente, dbo.fa_cliente_tipo.Descripcion_tip_cliente, 
                                                   dbo.fa_notaCreDeb.sc_observacion
                          FROM            dbo.fa_notaCreDeb INNER JOIN
                                                   dbo.tb_sucursal ON dbo.fa_notaCreDeb.IdEmpresa = dbo.tb_sucursal.IdEmpresa AND 
                                                   dbo.fa_notaCreDeb.IdSucursal = dbo.tb_sucursal.IdSucursal INNER JOIN
                                                   dbo.fa_notaCreDeb_det ON dbo.fa_notaCreDeb.IdEmpresa = dbo.fa_notaCreDeb_det.IdEmpresa AND 
                                                   dbo.fa_notaCreDeb.IdSucursal = dbo.fa_notaCreDeb_det.IdSucursal AND dbo.fa_notaCreDeb.IdBodega = dbo.fa_notaCreDeb_det.IdBodega AND 
                                                   dbo.fa_notaCreDeb.IdNota = dbo.fa_notaCreDeb_det.IdNota INNER JOIN
                                                   dbo.fa_cliente ON dbo.fa_notaCreDeb.IdEmpresa = dbo.fa_cliente.IdEmpresa AND dbo.fa_notaCreDeb.IdCliente = dbo.fa_cliente.IdCliente INNER JOIN
                                                   dbo.tb_persona ON dbo.fa_cliente.IdPersona = dbo.tb_persona.IdPersona INNER JOIN
                                                   dbo.fa_TipoNota ON dbo.fa_notaCreDeb.IdTipoNota = dbo.fa_TipoNota.IdTipoNota INNER JOIN
                                                   DBO.fa_cliente_tipo ON dbo.fa_cliente_tipo.IdEmpresa = dbo.fa_cliente.IdEmpresa AND 
                                                   dbo.fa_cliente_tipo.Idtipo_cliente = dbo.fa_cliente.Idtipo_cliente
                          WHERE        dbo.fa_notaCreDeb.CreDeb = 'D' AND fa_notaCreDeb.Estado = 'A' AND NOT EXISTS
                                                       (SELECT        *
                                                         FROM            fa_notaCreDeb_x_fa_factura_NotaDeb Cruce
                                                         WHERE        Cruce.IdEmpresa_nt = fa_notaCreDeb.IdEmpresa AND Cruce.IdSucursal_nt = fa_notaCreDeb.IdSucursal AND 
                                                                                   Cruce.IdBodega_nt = fa_notaCreDeb.IdBodega AND Cruce.IdNota_nt = fa_notaCreDeb.IdNota)
                          GROUP BY dbo.fa_notaCreDeb.IdEmpresa, dbo.fa_notaCreDeb.IdSucursal, dbo.fa_notaCreDeb.IdBodega, dbo.fa_notaCreDeb.IdNota, 
                                                   (CASE dbo.fa_TipoNota.Tipo WHEN 'C' THEN 'NTCR' ELSE 'NTDB' END), dbo.fa_notaCreDeb.Serie1, dbo.fa_notaCreDeb.Serie2, 
                                                   dbo.fa_notaCreDeb.NumNota_Impresa, dbo.fa_notaCreDeb.IdCliente, dbo.fa_notaCreDeb.no_fecha, dbo.fa_notaCreDeb.no_fecha_venc, 
                                                   dbo.tb_sucursal.Su_Descripcion, dbo.tb_persona.pe_nombreCompleto, dbo.tb_persona.pe_cedulaRuc, dbo.fa_cliente_tipo.Idtipo_cliente, 
                                                   dbo.fa_cliente_tipo.Descripcion_tip_cliente, fa_notaCreDeb.CodDocumentoTipo, dbo.fa_notaCreDeb.sc_observacion
                          UNION
                          /*- COBROS */ SELECT cxc_cobro_det.IdEmpresa, cxc_cobro_det.IdSucursal, cxc_cobro_det.IdBodega_Cbte, cxc_cobro_det.IdCbte_vta_nota, 
                                                   cxc_cobro_det.dc_TipoDocumento, CASE WHEN cxc_cobro.cr_NumDocumento IS NULL OR
                                                   cxc_cobro.cr_NumDocumento = '' THEN cast(cxc_cobro_det.IdCobro AS varchar(20)) ELSE cast(cxc_cobro.cr_NumDocumento AS varchar(20)) 
                                                   + ' / id:' + cast(cxc_cobro.IdCobro AS varchar(20)) END numDocumento, cxc_cobro.IdCliente, cxc_cobro.cr_fechaDocu, DATEDIFF(day, 
                                                   cxc_cobro.cr_fechaDocu, cxc_cobro.cr_fechaCobro), cxc_cobro.cr_fechaCobro, tb_sucursal.Su_Descripcion, cxc_cobro_det.dc_ValorPago, 
                                                   tb_persona.pe_nombreCompleto, tb_persona.pe_cedulaRuc, 'Cobro', vwcxc_EstadoCobro_Actual.IdEstadoCobro, cxc_cobro.IdCobro, 
                                                   cxc_cobro.IdCobro_tipo, cxc_cobro.IdCobro_tipo, fa_cliente.Idtipo_cliente, fa_cliente_tipo.Descripcion_tip_cliente, cxc_cobro.cr_observacion
                          FROM            cxc_cobro_det INNER JOIN
                                                   cxc_cobro ON cxc_cobro_det.IdEmpresa = cxc_cobro.IdEmpresa AND cxc_cobro_det.IdSucursal = cxc_cobro.IdSucursal AND 
                                                   cxc_cobro_det.IdCobro = cxc_cobro.IdCobro INNER JOIN
                                                   tb_sucursal ON cxc_cobro.IdEmpresa = tb_sucursal.IdEmpresa AND cxc_cobro.IdSucursal = tb_sucursal.IdSucursal INNER JOIN
                                                   fa_cliente ON cxc_cobro.IdEmpresa = fa_cliente.IdEmpresa AND cxc_cobro.IdCliente = fa_cliente.IdCliente INNER JOIN
                                                   tb_persona ON fa_cliente.IdPersona = tb_persona.IdPersona INNER JOIN
                                                   vwcxc_EstadoCobro_Actual ON cxc_cobro.IdEmpresa = vwcxc_EstadoCobro_Actual.IdEmpresa AND 
                                                   cxc_cobro.IdSucursal = vwcxc_EstadoCobro_Actual.IdSucursal AND cxc_cobro.IdCobro = vwcxc_EstadoCobro_Actual.IdCobro INNER JOIN
                                                   fa_cliente_tipo ON fa_cliente.IdEmpresa = fa_cliente_tipo.IdEmpresa AND fa_cliente.Idtipo_cliente = fa_cliente_tipo.Idtipo_cliente
                          WHERE        cxc_cobro.cr_estado = 'A') A