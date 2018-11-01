CREATE VIEW [Fj_servindustrias].[vwFAC_FJ_Rpt018]
AS
SELECT ISNULL(ROW_NUMBER() OVER (ORDER BY dbo.fa_factura.IdEmpresa), 0) AS IdRow, dbo.fa_factura.IdEmpresa, SUM(vt_Subtotal) AS vt_Subtotal, SUM(vt_iva) AS vt_iva, SUM(vt_total)-isnull(cobr.dc_ValorPago,0) AS vt_total, 
min(Fj_servindustrias.fa_factura_fj.fecha_cobro_1) fecha_cobro_1, max(Fj_servindustrias.fa_factura_fj.fecha_cobro_2) fecha_cobro_2, dbo.fa_cliente.IdCliente, ltrim(rtrim(dbo.tb_persona.pe_nombreCompleto)) pe_nombreCompleto, 
dbo.fa_factura.vt_fecha
FROM     dbo.fa_cliente INNER JOIN
                  dbo.fa_factura ON dbo.fa_cliente.IdEmpresa = dbo.fa_factura.IdEmpresa AND dbo.fa_cliente.IdCliente = dbo.fa_factura.IdCliente INNER JOIN
                  dbo.tb_persona ON dbo.fa_cliente.IdPersona = dbo.tb_persona.IdPersona AND dbo.fa_cliente.IdPersona = dbo.tb_persona.IdPersona LEFT OUTER JOIN
                  Fj_servindustrias.fa_factura_fj ON dbo.fa_factura.IdEmpresa = Fj_servindustrias.fa_factura_fj.IdEmpresa AND dbo.fa_factura.IdSucursal = Fj_servindustrias.fa_factura_fj.IdSucursal AND 
                  dbo.fa_factura.IdBodega = Fj_servindustrias.fa_factura_fj.IdBodega AND dbo.fa_factura.IdCbteVta = Fj_servindustrias.fa_factura_fj.IdCbteVta LEFT OUTER JOIN
                      (SELECT IdEmpresa, IdSucursal, IdBodega, IdCbteVta, SUM(vt_Subtotal) AS vt_Subtotal, SUM(vt_iva) AS vt_iva, SUM(vt_total) AS vt_total
                       FROM      dbo.fa_factura_det
                       GROUP BY IdEmpresa, IdSucursal, IdBodega, IdCbteVta) AS det ON dbo.fa_factura.IdEmpresa = det.IdEmpresa AND dbo.fa_factura.IdSucursal = det.IdSucursal AND dbo.fa_factura.IdBodega = det.IdBodega AND 
                  dbo.fa_factura.IdCbteVta = det.IdCbteVta LEFT JOIN
                      (SELECT cxc_cobro_det.IdEmpresa, cxc_cobro_det.IdSucursal, cxc_cobro_det.IdBodega_Cbte, cxc_cobro_det.IdCbte_vta_nota, cxc_cobro_det.dc_TipoDocumento, SUM(cxc_cobro_det.dc_ValorPago) dc_ValorPago
                       FROM      cxc_cobro_det
                       GROUP BY cxc_cobro_det.IdEmpresa, cxc_cobro_det.IdSucursal, cxc_cobro_det.IdBodega_Cbte, cxc_cobro_det.IdCbte_vta_nota, cxc_cobro_det.dc_TipoDocumento) cobr ON dbo.fa_factura.IdEmpresa = cobr.IdEmpresa AND 
                  dbo.fa_factura.IdSucursal = cobr.IdSucursal AND dbo.fa_factura.IdBodega = cobr.IdBodega_Cbte AND dbo.fa_factura.IdCbteVta = cobr.IdCbte_vta_nota AND dbo.fa_factura.vt_tipoDoc = cobr.dc_TipoDocumento
WHERE  fa_factura.Estado = 'A'
GROUP BY dbo.fa_factura.IdEmpresa, dbo.fa_cliente.IdCliente, dbo.tb_persona.pe_nombreCompleto, dbo.fa_factura.vt_fecha,cobr.dc_ValorPago
HAVING round(SUM(vt_total) - isnull(sum(cobr.dc_ValorPago), 0), 2) <> 0