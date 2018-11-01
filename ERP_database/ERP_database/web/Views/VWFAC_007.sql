CREATE VIEW [web].[VWFAC_007]
AS
SELECT fa_factura_det.IdEmpresa, fa_factura_det.IdSucursal, fa_factura_det.IdBodega, fa_factura_det.IdCbteVta, fa_factura_det.Secuencia, fa_factura_det.IdProducto, in_Producto.pr_descripcion, in_presentacion.nom_presentacion, 
                  in_Producto.lote_num_lote, in_Producto.lote_fecha_vcto, fa_factura_det.vt_cantidad, fa_factura_det.vt_Precio, fa_factura_det.vt_PorDescUnitario, fa_factura_det.vt_Subtotal, 
                  fa_factura_det.vt_DescUnitario * fa_factura_det.vt_cantidad AS DescTotal, IIF(vt_por_iva > 0, vt_Subtotal, 0) AS vt_SubtotalIVA, IIF(vt_por_iva = 0, vt_Subtotal, 0) AS vt_Subtotal0, fa_factura_det.vt_iva, fa_factura_det.vt_total, 
                  fa_factura_det.vt_por_iva, fa_cliente_contactos.Nombres, tb_sucursal.Su_Descripcion, fa_factura.vt_serie1 + '-' + fa_factura.vt_serie2 + '-' + fa_factura.vt_NumFactura vt_NumFactura, fa_factura.vt_fecha, fa_factura.vt_fech_venc, 
                  fa_Vendedor.Ve_Vendedor, fa_TerminoPago.nom_TerminoPago, fa_TerminoPago.Num_Coutas, fa_factura.vt_Observacion
FROM     fa_factura_det INNER JOIN
                  in_Producto ON fa_factura_det.IdEmpresa = in_Producto.IdEmpresa AND fa_factura_det.IdProducto = in_Producto.IdProducto INNER JOIN
                  in_presentacion ON in_Producto.IdEmpresa = in_presentacion.IdEmpresa AND in_Producto.IdPresentacion = in_presentacion.IdPresentacion INNER JOIN
                  fa_factura ON fa_factura_det.IdEmpresa = fa_factura.IdEmpresa AND fa_factura_det.IdSucursal = fa_factura.IdSucursal AND fa_factura_det.IdBodega = fa_factura.IdBodega AND 
                  fa_factura_det.IdCbteVta = fa_factura.IdCbteVta INNER JOIN
                  fa_cliente_contactos ON fa_factura.IdEmpresa = fa_cliente_contactos.IdEmpresa AND fa_factura.IdCliente = fa_cliente_contactos.IdCliente AND fa_factura.IdContacto = fa_cliente_contactos.IdContacto INNER JOIN
                  fa_Vendedor ON fa_factura.IdEmpresa = fa_Vendedor.IdEmpresa AND fa_factura.IdVendedor = fa_Vendedor.IdVendedor INNER JOIN
                  tb_sucursal ON fa_factura.IdEmpresa = tb_sucursal.IdEmpresa AND fa_factura.IdSucursal = tb_sucursal.IdSucursal INNER JOIN
                  fa_TerminoPago ON fa_factura.vt_tipo_venta = fa_TerminoPago.IdTerminoPago