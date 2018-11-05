CREATE VIEW XXXCARTERA
AS
SELECT fa_factura.IdEmpresa, fa_factura.IdSucursal, fa_factura.IdBodega, fa_factura.IdCbteVta, fa_factura.vt_tipoDoc, fa_factura.vt_NumFactura, tb_persona.pe_nombreCompleto, fa_factura.vt_fecha, fa_factura.vt_fech_venc, DET.TotalDscto, 
                  DET.Subtotal0, DET.SubtotalIVA, DET.vt_iva, DET.vt_total, isnull(COBRO.dc_ValorPago,0) as Pagado, round(DET.vt_total - isnull(COBRO.dc_ValorPago,0),2) AS Saldo
FROM     fa_factura INNER JOIN
                  fa_cliente ON fa_factura.IdEmpresa = fa_cliente.IdEmpresa AND fa_factura.IdCliente = fa_cliente.IdCliente INNER JOIN
                  tb_persona ON fa_cliente.IdPersona = tb_persona.IdPersona LEFT OUTER JOIN
                      (SELECT cxc_cobro_det.IdEmpresa, cxc_cobro_det.IdSucursal, cxc_cobro_det.IdBodega_Cbte, cxc_cobro_det.IdCbte_vta_nota, cxc_cobro_det.dc_TipoDocumento, SUM(cxc_cobro_det.dc_ValorPago) AS dc_ValorPago
                       FROM      cxc_cobro INNER JOIN
                                         cxc_cobro_det ON cxc_cobro.IdEmpresa = cxc_cobro_det.IdEmpresa AND cxc_cobro.IdSucursal = cxc_cobro_det.IdSucursal AND cxc_cobro.IdCobro = cxc_cobro_det.IdCobro
                       WHERE   (cxc_cobro.cr_estado = N'A')
                       GROUP BY cxc_cobro_det.IdEmpresa, cxc_cobro_det.IdSucursal, cxc_cobro_det.IdBodega_Cbte, cxc_cobro_det.IdCbte_vta_nota, cxc_cobro_det.dc_TipoDocumento) AS COBRO ON 
                  fa_factura.vt_tipoDoc = COBRO.dc_TipoDocumento AND fa_factura.IdCbteVta = COBRO.IdCbte_vta_nota AND fa_factura.IdBodega = COBRO.IdBodega_Cbte AND fa_factura.IdSucursal = COBRO.IdSucursal AND 
                  COBRO.IdEmpresa = fa_factura.IdEmpresa LEFT OUTER JOIN
                      (SELECT IdEmpresa, IdSucursal, IdBodega, IdCbteVta, SUM(Subtotal0) AS Subtotal0, SUM(SubtotalIVA) AS SubtotalIVA, SUM(TotalDscto) AS TotalDscto, SUM(vt_iva) AS vt_iva, SUM(vt_total) AS vt_total
                       FROM      (SELECT IdEmpresa, IdSucursal, IdBodega, IdCbteVta, vt_cantidad * vt_PorDescUnitario AS TotalDscto, CASE WHEN vt_por_iva = 0 THEN vt_Subtotal ELSE 0 END AS Subtotal0, 
                                                            CASE WHEN vt_por_iva > 0 THEN vt_Subtotal ELSE 0 END AS SubtotalIVA, vt_iva, vt_total
                                          FROM      fa_factura_det) AS A
                       GROUP BY IdEmpresa, IdSucursal, IdBodega, IdCbteVta) AS DET ON fa_factura.IdCbteVta = DET.IdCbteVta AND fa_factura.IdBodega = DET.IdBodega AND fa_factura.IdSucursal = DET.IdSucursal AND 
                  fa_factura.IdEmpresa = DET.IdEmpresa