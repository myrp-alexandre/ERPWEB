CREATE VIEW web.vwin_Producto_Composicion
AS
SELECT        in_Producto_Composicion.IdEmpresa, in_Producto_Composicion.IdProductoPadre, in_Producto_Composicion.IdProductoHijo, in_Producto_Composicion.IdUnidadMedida, in_Producto_Composicion.Cantidad, 
                         in_Producto.pr_descripcion, in_presentacion.nom_presentacion, in_categorias.ca_Categoria, in_Producto.lote_fecha_fab, in_Producto.lote_fecha_vcto, in_Producto.lote_num_lote
FROM            in_Producto_Composicion INNER JOIN
                         in_Producto ON in_Producto_Composicion.IdEmpresa = in_Producto.IdEmpresa AND in_Producto_Composicion.IdEmpresa = in_Producto.IdEmpresa AND 
                         in_Producto_Composicion.IdProductoHijo = in_Producto.IdProducto INNER JOIN
                         in_categorias ON in_Producto.IdEmpresa = in_categorias.IdEmpresa AND in_Producto.IdCategoria = in_categorias.IdCategoria INNER JOIN
                         in_presentacion ON in_Producto.IdEmpresa = in_presentacion.IdEmpresa AND in_Producto.IdPresentacion = in_presentacion.IdPresentacion