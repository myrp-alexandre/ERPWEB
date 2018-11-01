CREATE VIEW web.VWCXC_006_sin_comision
AS
SELECT cxc_liquidacion_comisiones.IdEmpresa, cxc_liquidacion_comisiones.IdLiquidacion, cxc_liquidacion_comisiones.Fecha, cxc_liquidacion_comisiones.Observacion, cxc_liquidacion_comisiones.IdVendedor, cxc_liquidacion_comisiones.Estado, 
                  fa_Vendedor.Ve_Vendedor, fa_factura.vt_tipoDoc, fa_factura.vt_serie1+'-'+ fa_factura.vt_serie2+'-'+ fa_factura.vt_NumFactura vt_NumFactura, cxc_liquidacion_comisiones_det.SubtotalFactura, cxc_liquidacion_comisiones_det.IvaFactura, 
                  cxc_liquidacion_comisiones_det.TotalFactura, cxc_liquidacion_comisiones_det.TotalCobrado, cxc_liquidacion_comisiones_det.BaseComision, cxc_liquidacion_comisiones_det.PorcentajeComision, 
                  cxc_liquidacion_comisiones_det.TotalAComisionar, cxc_liquidacion_comisiones_det.TotalComisionado, cxc_liquidacion_comisiones_det.TotalLiquidacion, cxc_liquidacion_comisiones_det.NoComisiona, 
                  tb_persona.pe_nombreCompleto, cxc_liquidacion_comisiones_det.TotalAComisionar - (cxc_liquidacion_comisiones_det.TotalComisionado + cxc_liquidacion_comisiones_det.TotalLiquidacion) as Saldo
FROM     cxc_liquidacion_comisiones INNER JOIN
                  cxc_liquidacion_comisiones_det ON cxc_liquidacion_comisiones.IdEmpresa = cxc_liquidacion_comisiones_det.IdEmpresa AND cxc_liquidacion_comisiones.IdLiquidacion = cxc_liquidacion_comisiones_det.IdLiquidacion INNER JOIN
                  fa_Vendedor ON cxc_liquidacion_comisiones.IdEmpresa = fa_Vendedor.IdEmpresa AND cxc_liquidacion_comisiones.IdVendedor = fa_Vendedor.IdVendedor INNER JOIN
                  fa_factura ON cxc_liquidacion_comisiones_det.fa_IdEmpresa = fa_factura.IdEmpresa AND cxc_liquidacion_comisiones_det.fa_IdSucursal = fa_factura.IdSucursal AND 
                  cxc_liquidacion_comisiones_det.fa_IdBodega = fa_factura.IdBodega AND cxc_liquidacion_comisiones_det.fa_IdCbteVta = fa_factura.IdCbteVta INNER JOIN
                  fa_cliente ON fa_factura.IdEmpresa = fa_cliente.IdEmpresa AND fa_factura.IdCliente = fa_cliente.IdCliente INNER JOIN
                  tb_persona ON fa_cliente.IdPersona = tb_persona.IdPersona
where cxc_liquidacion_comisiones_det.NoComisiona = 1