CREATE view [dbo].[vwcxc_liquidacion_comisiones_det_x_comisionar]
as
SELECT dbo.fa_factura.IdEmpresa, dbo.fa_factura.IdSucursal, dbo.fa_factura.IdBodega, dbo.fa_factura.IdCbteVta, dbo.fa_factura.vt_tipoDoc, dbo.fa_factura.vt_serie1, dbo.fa_factura.vt_serie2, dbo.fa_factura.vt_NumFactura, 
                  dbo.fa_cliente_contactos.Nombres, dbo.fa_Vendedor.Ve_Vendedor, dbo.fa_Vendedor.NomInterno, dbo.fa_TerminoPago.nom_TerminoPago, dbo.fa_factura.vt_fecha, dbo.fa_factura.vt_fech_venc, isnull(SUM(dbo.fa_factura_det.vt_Subtotal),0)
                  AS vt_Subtotal, isnull(SUM(dbo.fa_factura_det.vt_iva),0) AS vt_iva, isnull(SUM(dbo.fa_factura_det.vt_total),0) AS vt_total, ISNULL(cobro.dc_ValorPago, 0) AS valor_cobro, CASE WHEN round(SUM(fa_factura_det.vt_total), 2) 
                  - ISNULL(round(cobro.dc_ValorPago, 2), 0) = 0 THEN 'CANCELADA' ELSE 'PENDIENTE' END AS ESTADO_COBRO, isnull(ROUND(SUM(dbo.fa_factura_det.vt_total) * (dbo.fa_Vendedor.PorComision / 100), 2),0) AS TotalAComisionar, 
                  ISNULL(comisiones.TotalLiquidacion, 0) AS TotalComisionado, ROUND(SUM(dbo.fa_factura_det.vt_Subtotal) * (dbo.fa_Vendedor.PorComision / 100), 2) - ISNULL(comisiones.TotalLiquidacion, 0) AS SaldoPorComisionar, 
                  dbo.fa_Vendedor.IdVendedor, dbo.fa_Vendedor.PorComision
FROM     dbo.fa_factura INNER JOIN
                  dbo.fa_factura_det ON dbo.fa_factura.IdEmpresa = dbo.fa_factura_det.IdEmpresa AND dbo.fa_factura.IdSucursal = dbo.fa_factura_det.IdSucursal AND dbo.fa_factura.IdBodega = dbo.fa_factura_det.IdBodega AND 
                  dbo.fa_factura.IdCbteVta = dbo.fa_factura_det.IdCbteVta INNER JOIN
                  dbo.fa_Vendedor ON dbo.fa_factura.IdEmpresa = dbo.fa_Vendedor.IdEmpresa AND dbo.fa_factura.IdVendedor = dbo.fa_Vendedor.IdVendedor INNER JOIN
                  dbo.fa_cliente_contactos ON dbo.fa_factura.IdEmpresa = dbo.fa_cliente_contactos.IdEmpresa AND dbo.fa_factura.IdCliente = dbo.fa_cliente_contactos.IdCliente AND 
                  dbo.fa_factura.IdContacto = dbo.fa_cliente_contactos.IdContacto INNER JOIN
                  dbo.fa_TerminoPago ON dbo.fa_factura.vt_tipo_venta = dbo.fa_TerminoPago.IdTerminoPago LEFT OUTER JOIN
                      (SELECT IdEmpresa, IdSucursal, IdBodega_Cbte, IdCbte_vta_nota, dc_TipoDocumento, SUM(dc_ValorPago) AS dc_ValorPago
                       FROM      dbo.cxc_cobro_det
                       WHERE   (estado = 'A')
                       GROUP BY IdEmpresa, IdSucursal, IdBodega_Cbte, IdCbte_vta_nota, dc_TipoDocumento) AS cobro ON dbo.fa_factura.IdEmpresa = cobro.IdEmpresa AND dbo.fa_factura.IdSucursal = cobro.IdSucursal AND 
                  dbo.fa_factura.IdBodega = cobro.IdBodega_Cbte AND dbo.fa_factura.IdCbteVta = cobro.IdCbte_vta_nota LEFT OUTER JOIN
                      (SELECT dbo.cxc_liquidacion_comisiones_det.fa_IdEmpresa, dbo.cxc_liquidacion_comisiones_det.fa_IdSucursal, dbo.cxc_liquidacion_comisiones_det.fa_IdBodega, dbo.cxc_liquidacion_comisiones_det.fa_IdCbteVta, 
                                         SUM(dbo.cxc_liquidacion_comisiones_det.TotalLiquidacion) AS TotalLiquidacion
                       FROM      dbo.cxc_liquidacion_comisiones LEFT OUTER JOIN
                                         dbo.cxc_liquidacion_comisiones_det ON dbo.cxc_liquidacion_comisiones.IdEmpresa = dbo.cxc_liquidacion_comisiones_det.IdEmpresa AND 
                                         dbo.cxc_liquidacion_comisiones.IdLiquidacion = dbo.cxc_liquidacion_comisiones_det.IdLiquidacion
                       WHERE   (dbo.cxc_liquidacion_comisiones.Estado = 1)
                       GROUP BY dbo.cxc_liquidacion_comisiones_det.fa_IdEmpresa, dbo.cxc_liquidacion_comisiones_det.fa_IdSucursal, dbo.cxc_liquidacion_comisiones_det.fa_IdBodega, dbo.cxc_liquidacion_comisiones_det.fa_IdCbteVta) 
                  AS comisiones ON comisiones.fa_IdEmpresa = dbo.fa_factura.IdEmpresa AND comisiones.fa_IdSucursal = dbo.fa_factura.IdSucursal AND comisiones.fa_IdBodega = dbo.fa_factura.IdBodega AND 
                  comisiones.fa_IdCbteVta = dbo.fa_factura.IdCbteVta
WHERE  (dbo.fa_factura.Estado = 'A') AND (dbo.fa_Vendedor.PorComision > 0) AND (NOT EXISTS
                      (SELECT f.IdEmpresa
                       FROM      dbo.cxc_liquidacion_comisiones LEFT OUTER JOIN
                                         dbo.cxc_liquidacion_comisiones_det AS f ON dbo.cxc_liquidacion_comisiones.IdEmpresa = f.IdEmpresa AND dbo.cxc_liquidacion_comisiones.IdLiquidacion = f.IdLiquidacion
                       WHERE   (f.NoComisiona = 1) AND (f.fa_IdEmpresa = dbo.fa_factura.IdEmpresa) AND (f.fa_IdSucursal = dbo.fa_factura.IdSucursal) AND (f.fa_IdBodega = dbo.fa_factura.IdBodega) AND (f.fa_IdCbteVta = dbo.fa_factura.IdCbteVta) AND 
                                         (dbo.cxc_liquidacion_comisiones.Estado = 1)))
GROUP BY dbo.fa_factura.IdEmpresa, dbo.fa_factura.IdSucursal, dbo.fa_factura.IdBodega, dbo.fa_factura.IdCbteVta, dbo.fa_factura.vt_tipoDoc, dbo.fa_factura.vt_serie1, dbo.fa_factura.vt_serie2, dbo.fa_factura.vt_NumFactura, 
                  dbo.fa_cliente_contactos.Nombres, dbo.fa_factura.IdVendedor, dbo.fa_Vendedor.Ve_Vendedor, dbo.fa_Vendedor.NomInterno, dbo.fa_TerminoPago.nom_TerminoPago, dbo.fa_factura.vt_fecha, dbo.fa_factura.vt_fech_venc, 
                  cobro.dc_ValorPago, dbo.fa_Vendedor.PorComision, comisiones.TotalLiquidacion, dbo.fa_Vendedor.IdVendedor
HAVING (ROUND(SUM(dbo.fa_factura_det.vt_Subtotal) * (dbo.fa_Vendedor.PorComision / 100), 2) - ROUND(ISNULL(comisiones.TotalLiquidacion, 0), 2) > 0)