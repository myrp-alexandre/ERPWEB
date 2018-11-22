CREATE VIEW vwfa_CambioProductoDet_facturas
AS
SELECT        fa_factura_det.IdEmpresa, fa_factura_det.IdSucursal, fa_factura_det.IdBodega, fa_factura_det.IdCbteVta, fa_factura_det.Secuencia, fa_factura.vt_fecha, fa_factura_det.IdProducto, in_Producto.pr_descripcion, 
                         fa_factura_det.vt_cantidad - isnull(cambios.CantidadCambio,0) as vt_cantidad, fa_factura.vt_NumFactura, fa_cliente_contactos.Nombres AS NombreCliente, fa_factura.Estado
FROM            fa_factura INNER JOIN
                         fa_factura_det ON fa_factura.IdEmpresa = fa_factura_det.IdEmpresa AND fa_factura.IdSucursal = fa_factura_det.IdSucursal AND fa_factura.IdBodega = fa_factura_det.IdBodega AND 
                         fa_factura.IdCbteVta = fa_factura_det.IdCbteVta INNER JOIN
                         fa_cliente_contactos ON fa_factura.IdEmpresa = fa_cliente_contactos.IdEmpresa AND fa_factura.IdCliente = fa_cliente_contactos.IdCliente AND fa_factura.IdContacto = fa_cliente_contactos.IdContacto INNER JOIN
                         in_Producto ON fa_factura_det.IdEmpresa = in_Producto.IdEmpresa AND fa_factura_det.IdProducto = in_Producto.IdProducto LEFT OUTER JOIN(
							 SELECT d.IdEmpresa, d.IdSucursal, d.IdBodega, d.IdCbteVta, d.SecuenciaFact, sum(d.CantidadCambio) CantidadCambio
							 FROM fa_CambioProductoDet AS D inner join fa_CambioProducto as c
							 on c.IdEmpresa = d.IdEmpresa
							 and c.IdSucursal = d.IdSucursal
							 and c.IdBodega = d.IdBodega
							 and c.IdCambio = d.IdCambio
							 group by d.IdEmpresa, d.IdSucursal, d.IdBodega, d.IdCbteVta, d.SecuenciaFact
						 ) as Cambios on fa_factura_det.IdEmpresa = cambios.IdEmpresa and fa_factura_det.IdSucursal = cambios.IdSucursal and fa_factura_det.IdBodega = Cambios.IdBodega
						 and fa_factura_det.IdCbteVta = Cambios.IdCbteVta and fa_factura_det.Secuencia = Cambios.SecuenciaFact
WHERE        (fa_factura.Estado = 'A') and fa_factura_det.vt_cantidad - isnull(cambios.CantidadCambio,0) > 0