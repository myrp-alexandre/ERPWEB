CREATE VIEW [Fj_servindustrias].[vwFAC_FJ_Rpt009]
AS
SELECT        isnull(ROW_NUMBER() OVER (ORDER BY fa_factura_det.IdEmpresa), 0) AS IdRow, fa_factura_det.IdEmpresa, fa_factura_det.IdSucursal, fa_factura_det.IdBodega, fa_factura_det.IdCbteVta, fa_factura_det.Secuencia, 
fa_factura.vt_fecha, fa_factura.IdCliente, tb_persona.pe_nombreCompleto, fa_factura.IdVendedor, fa_Vendedor.Ve_Vendedor, in_Producto.pr_descripcion, fa_factura_det.vt_Subtotal, fa_factura_det.vt_iva, fa_factura_det.vt_total, 
isnull(fa_factura_det.IdPunto_Cargo,0)IdPunto_Cargo, isnull(fa_factura_det.IdPunto_cargo_grupo,0)IdPunto_cargo_grupo, ct_punto_cargo.nom_punto_cargo, fa_factura.vt_NumFactura
FROM            fa_factura INNER JOIN
                         fa_factura_det ON fa_factura.IdEmpresa = fa_factura_det.IdEmpresa AND fa_factura.IdSucursal = fa_factura_det.IdSucursal AND fa_factura.IdBodega = fa_factura_det.IdBodega AND 
                         fa_factura.IdCbteVta = fa_factura_det.IdCbteVta INNER JOIN
                         fa_cliente ON fa_factura.IdEmpresa = fa_cliente.IdEmpresa AND fa_factura.IdCliente = fa_cliente.IdCliente INNER JOIN
                         tb_persona ON fa_cliente.IdPersona = tb_persona.IdPersona INNER JOIN
                         fa_Vendedor ON fa_factura.IdEmpresa = fa_Vendedor.IdEmpresa AND fa_factura.IdVendedor = fa_Vendedor.IdVendedor INNER JOIN
                         in_Producto ON fa_factura_det.IdEmpresa = in_Producto.IdEmpresa AND fa_factura_det.IdProducto = in_Producto.IdProducto LEFT OUTER JOIN
                         ct_punto_cargo ON fa_factura_det.IdEmpresa = ct_punto_cargo.IdEmpresa AND fa_factura_det.IdPunto_Cargo = ct_punto_cargo.IdPunto_cargo
WHERE        fa_factura.Estado = 'A'