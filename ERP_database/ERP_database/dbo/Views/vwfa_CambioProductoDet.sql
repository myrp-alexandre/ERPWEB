
CREATE view [dbo].[vwfa_CambioProductoDet]
as
SELECT dbo.fa_CambioProductoDet.IdEmpresa, dbo.fa_CambioProductoDet.IdSucursal, dbo.fa_CambioProductoDet.IdBodega, dbo.fa_CambioProductoDet.IdCambio, dbo.fa_CambioProductoDet.Secuencia, dbo.fa_CambioProductoDet.IdCbteVta, 
                  dbo.fa_CambioProductoDet.SecuenciaFact, dbo.fa_CambioProductoDet.IdProductoFact, dbo.fa_CambioProductoDet.IdProductoCambio, dbo.fa_CambioProductoDet.CantidadFact, dbo.fa_CambioProductoDet.CantidadCambio, 
                  in_Producto_1.pr_descripcion AS pr_descripcionFact, dbo.in_Producto.pr_descripcion AS pr_descripcionCambio, dbo.fa_factura.vt_NumFactura, 
                  dbo.fa_cliente_contactos.Nombres AS NombreCliente
FROM     dbo.fa_cliente_contactos INNER JOIN
                  dbo.fa_factura ON dbo.fa_cliente_contactos.IdEmpresa = dbo.fa_factura.IdEmpresa AND dbo.fa_cliente_contactos.IdCliente = dbo.fa_factura.IdCliente AND 
                  dbo.fa_cliente_contactos.IdContacto = dbo.fa_factura.IdContacto RIGHT OUTER JOIN
                  dbo.fa_CambioProductoDet ON dbo.fa_factura.IdEmpresa = dbo.fa_CambioProductoDet.IdEmpresa AND dbo.fa_factura.IdSucursal = dbo.fa_CambioProductoDet.IdSucursal AND 
                  dbo.fa_factura.IdBodega = dbo.fa_CambioProductoDet.IdBodega AND dbo.fa_factura.IdCbteVta = dbo.fa_CambioProductoDet.IdCbteVta LEFT OUTER JOIN
                  dbo.in_Producto AS in_Producto_1 ON dbo.fa_CambioProductoDet.IdProductoFact = in_Producto_1.IdProducto AND dbo.fa_CambioProductoDet.IdEmpresa = in_Producto_1.IdEmpresa LEFT OUTER JOIN
                  dbo.in_Producto ON dbo.fa_CambioProductoDet.IdProductoCambio = dbo.in_Producto.IdProducto AND dbo.fa_CambioProductoDet.IdEmpresa = dbo.in_Producto.IdEmpresa