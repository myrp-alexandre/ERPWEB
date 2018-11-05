

CREATE VIEW [dbo].[XXXPRODUCTOSFACTURADOSCON0]
AS
SELECT fa_factura.IdCbteVta, fa_factura.vt_NumFactura, fa_factura_det.vt_Precio, in_Producto.pr_descripcion, in_Producto.lote_num_lote, in_Producto.lote_fecha_vcto
FROM     fa_factura INNER JOIN
                  fa_factura_det ON fa_factura.IdEmpresa = fa_factura_det.IdEmpresa AND fa_factura.IdSucursal = fa_factura_det.IdSucursal AND fa_factura.IdBodega = fa_factura_det.IdBodega AND 
                  fa_factura.IdCbteVta = fa_factura_det.IdCbteVta INNER JOIN
                  in_Producto ON fa_factura_det.IdEmpresa = in_Producto.IdEmpresa AND fa_factura_det.IdProducto = in_Producto.IdProducto
WHERE  (fa_factura_det.vt_Precio = 0)