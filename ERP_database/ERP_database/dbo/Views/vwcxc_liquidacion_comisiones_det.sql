CREATE view [dbo].[vwcxc_liquidacion_comisiones_det]
as
SELECT dbo.cxc_liquidacion_comisiones.IdEmpresa, dbo.cxc_liquidacion_comisiones.IdLiquidacion, dbo.cxc_liquidacion_comisiones_det.Secuencia, dbo.fa_factura.IdSucursal, dbo.fa_factura.IdBodega, dbo.fa_factura.IdCbteVta, 
                  dbo.fa_factura.vt_tipoDoc, dbo.fa_factura.vt_serie1, dbo.fa_factura.vt_serie2, dbo.fa_factura.vt_NumFactura, dbo.fa_cliente_contactos.Nombres, dbo.fa_Vendedor.Ve_Vendedor, dbo.fa_Vendedor.NomInterno, 
                  dbo.fa_TerminoPago.nom_TerminoPago, dbo.fa_factura.vt_fecha, dbo.fa_factura.vt_fech_venc, ISNULL(SUM(dbo.fa_factura_det.vt_Subtotal), 0) AS vt_Subtotal, ISNULL(SUM(dbo.fa_factura_det.vt_iva), 0) AS vt_iva, 
                  ISNULL(SUM(dbo.fa_factura_det.vt_total), 0) AS vt_total, dbo.fa_Vendedor.IdVendedor, dbo.fa_Vendedor.PorComision, dbo.cxc_liquidacion_comisiones_det.SubtotalFactura, dbo.cxc_liquidacion_comisiones_det.IvaFactura, 
                  dbo.cxc_liquidacion_comisiones_det.Secuencia AS Expr1, dbo.cxc_liquidacion_comisiones_det.TotalFactura, dbo.cxc_liquidacion_comisiones_det.TotalCobrado, dbo.cxc_liquidacion_comisiones_det.BaseComision, 
                  dbo.cxc_liquidacion_comisiones_det.PorcentajeComision, dbo.cxc_liquidacion_comisiones_det.TotalAComisionar, dbo.cxc_liquidacion_comisiones_det.TotalComisionado, dbo.cxc_liquidacion_comisiones_det.TotalLiquidacion, 
                  dbo.cxc_liquidacion_comisiones_det.NoComisiona
FROM     dbo.fa_factura INNER JOIN
                  dbo.fa_cliente_contactos ON dbo.fa_factura.IdEmpresa = dbo.fa_cliente_contactos.IdEmpresa AND dbo.fa_factura.IdCliente = dbo.fa_cliente_contactos.IdCliente AND 
                  dbo.fa_factura.IdContacto = dbo.fa_cliente_contactos.IdContacto INNER JOIN
                  dbo.fa_TerminoPago ON dbo.fa_factura.vt_tipo_venta = dbo.fa_TerminoPago.IdTerminoPago INNER JOIN
                  dbo.cxc_liquidacion_comisiones_det INNER JOIN
                  dbo.fa_Vendedor ON dbo.cxc_liquidacion_comisiones_det.IdEmpresa = dbo.fa_Vendedor.IdEmpresa AND dbo.cxc_liquidacion_comisiones_det.IdVendedor = dbo.fa_Vendedor.IdVendedor INNER JOIN
                  dbo.cxc_liquidacion_comisiones ON dbo.cxc_liquidacion_comisiones_det.IdEmpresa = dbo.cxc_liquidacion_comisiones.IdEmpresa AND dbo.cxc_liquidacion_comisiones_det.IdLiquidacion = dbo.cxc_liquidacion_comisiones.IdLiquidacion ON 
                  dbo.fa_factura.IdEmpresa = dbo.cxc_liquidacion_comisiones_det.fa_IdEmpresa AND dbo.fa_factura.IdSucursal = dbo.cxc_liquidacion_comisiones_det.fa_IdSucursal AND 
                  dbo.fa_factura.IdBodega = dbo.cxc_liquidacion_comisiones_det.fa_IdBodega AND dbo.fa_factura.IdCbteVta = dbo.cxc_liquidacion_comisiones_det.fa_IdCbteVta LEFT OUTER JOIN
                  dbo.fa_factura_det ON dbo.fa_factura.IdEmpresa = dbo.fa_factura_det.IdEmpresa AND dbo.fa_factura.IdSucursal = dbo.fa_factura_det.IdSucursal AND dbo.fa_factura.IdBodega = dbo.fa_factura_det.IdBodega AND 
                  dbo.fa_factura.IdCbteVta = dbo.fa_factura_det.IdCbteVta
GROUP BY dbo.fa_factura.IdSucursal, dbo.fa_factura.IdBodega, dbo.fa_factura.IdCbteVta, dbo.fa_factura.vt_tipoDoc, dbo.fa_factura.vt_serie1, dbo.fa_factura.vt_serie2, dbo.fa_factura.vt_NumFactura, dbo.fa_cliente_contactos.Nombres, 
                  dbo.fa_factura.IdVendedor, dbo.fa_Vendedor.Ve_Vendedor, dbo.fa_Vendedor.NomInterno, dbo.fa_TerminoPago.nom_TerminoPago, dbo.fa_factura.vt_fecha, dbo.fa_factura.vt_fech_venc, dbo.fa_Vendedor.PorComision, 
                  dbo.fa_Vendedor.IdVendedor, dbo.cxc_liquidacion_comisiones.IdEmpresa, dbo.cxc_liquidacion_comisiones.IdLiquidacion, dbo.cxc_liquidacion_comisiones_det.Secuencia, dbo.cxc_liquidacion_comisiones_det.SubtotalFactura, 
                  dbo.cxc_liquidacion_comisiones_det.IvaFactura, dbo.cxc_liquidacion_comisiones_det.TotalFactura, dbo.cxc_liquidacion_comisiones_det.TotalCobrado, dbo.cxc_liquidacion_comisiones_det.BaseComision, 
                  dbo.cxc_liquidacion_comisiones_det.PorcentajeComision, dbo.cxc_liquidacion_comisiones_det.TotalAComisionar, dbo.cxc_liquidacion_comisiones_det.TotalComisionado, dbo.cxc_liquidacion_comisiones_det.TotalLiquidacion, 
                  dbo.cxc_liquidacion_comisiones_det.NoComisiona