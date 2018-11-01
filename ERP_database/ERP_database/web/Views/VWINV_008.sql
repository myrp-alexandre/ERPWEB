CREATE view web.VWINV_008
as
SELECT        dbo.in_producto_x_tb_bodega.IdEmpresa, dbo.in_producto_x_tb_bodega.IdSucursal, dbo.in_producto_x_tb_bodega.IdBodega, dbo.in_producto_x_tb_bodega.IdProducto, p_hijo.pr_codigo, p_hijo.pr_descripcion, 
                         p_hijo.IdProducto_padre, p_hijo.lote_fecha_fab, p_hijo.lote_fecha_vcto, p_hijo.lote_num_lote, ISNULL(SUM(mov.dm_cantidad), 0) AS stock, p_padre.IdCategoria, p_padre.IdLinea, p_padre.IdGrupo, p_padre.IdSubGrupo, 
                         dbo.in_categorias.ca_Categoria, p_padre.IdPresentacion, dbo.in_presentacion.nom_presentacion, dbo.tb_sucursal.Su_Descripcion, dbo.tb_bodega.bo_Descripcion
FROM            dbo.tb_sucursal RIGHT OUTER JOIN
                         dbo.tb_bodega ON dbo.tb_sucursal.IdEmpresa = dbo.tb_bodega.IdEmpresa AND dbo.tb_sucursal.IdSucursal = dbo.tb_bodega.IdSucursal RIGHT OUTER JOIN
                         dbo.in_producto_x_tb_bodega INNER JOIN
                         dbo.in_Producto AS p_hijo ON dbo.in_producto_x_tb_bodega.IdEmpresa = p_hijo.IdEmpresa AND dbo.in_producto_x_tb_bodega.IdProducto = p_hijo.IdProducto INNER JOIN
                         dbo.in_Producto AS p_padre ON p_hijo.IdEmpresa = p_padre.IdEmpresa AND p_hijo.IdProducto_padre = p_padre.IdProducto ON dbo.tb_bodega.IdEmpresa = dbo.in_producto_x_tb_bodega.IdEmpresa AND 
                         dbo.tb_bodega.IdSucursal = dbo.in_producto_x_tb_bodega.IdSucursal AND dbo.tb_bodega.IdBodega = dbo.in_producto_x_tb_bodega.IdBodega LEFT OUTER JOIN
                         dbo.in_presentacion ON p_padre.IdEmpresa = dbo.in_presentacion.IdEmpresa AND p_padre.IdPresentacion = dbo.in_presentacion.IdPresentacion LEFT OUTER JOIN
                         dbo.in_categorias ON p_padre.IdEmpresa = dbo.in_categorias.IdEmpresa AND p_padre.IdCategoria = dbo.in_categorias.IdCategoria LEFT OUTER JOIN
                             (SELECT        IdEmpresa, IdSucursal, IdBodega, IdProducto, dm_cantidad
                               FROM            dbo.in_movi_inve_detalle) AS mov ON dbo.in_producto_x_tb_bodega.IdProducto = mov.IdProducto AND dbo.in_producto_x_tb_bodega.IdBodega = mov.IdBodega AND 
                         dbo.in_producto_x_tb_bodega.IdSucursal = mov.IdSucursal AND mov.IdEmpresa = dbo.in_producto_x_tb_bodega.IdEmpresa
WHERE        (p_hijo.Estado = 'A') AND (p_hijo.lote_fecha_vcto > CAST(GETDATE() AS date)) AND (NOT EXISTS
                             (SELECT        IdEmpresa
                               FROM            dbo.in_Producto_Composicion AS comp
                               WHERE        (dbo.in_producto_x_tb_bodega.IdEmpresa = IdEmpresa) AND (dbo.in_producto_x_tb_bodega.IdProducto = IdProductoHijo))) AND (NOT EXISTS
                             (SELECT        IdEmpresa
                               FROM            dbo.in_Producto_Composicion AS comp
                               WHERE        (dbo.in_producto_x_tb_bodega.IdEmpresa = IdEmpresa) AND (dbo.in_producto_x_tb_bodega.IdProducto = IdProductoPadre)))
GROUP BY dbo.in_producto_x_tb_bodega.IdEmpresa, dbo.in_producto_x_tb_bodega.IdSucursal, dbo.in_producto_x_tb_bodega.IdBodega, dbo.in_producto_x_tb_bodega.IdProducto, p_hijo.pr_codigo, p_hijo.pr_descripcion, 
                         p_hijo.IdProducto_padre, p_hijo.lote_fecha_fab, p_hijo.lote_fecha_vcto, p_hijo.lote_num_lote, p_padre.IdCategoria, p_padre.IdLinea, p_padre.IdGrupo, p_padre.IdSubGrupo, p_padre.IdPresentacion, 
                         dbo.in_categorias.ca_Categoria, dbo.in_presentacion.nom_presentacion, dbo.tb_sucursal.Su_Descripcion, dbo.tb_bodega.bo_Descripcion
UNION ALL
SELECT        A.IdEmpresa, A.IdSucursal, A.IdBodega, A.IdProducto_combo, A.pr_codigo, A.pr_descripcion, A.IdProducto_padre, A.lote_fecha_fab, A.lote_fecha_vcto, A.lote_num_lote, MIN(A.cantidad) AS cantidad, A.IdCategoria, A.IdLinea, 
                         A.IdGrupo, A.IdSubGrupo, dbo.in_categorias.ca_Categoria, A.IdPresentacion, dbo.in_presentacion.nom_presentacion, dbo.tb_sucursal.Su_Descripcion, dbo.tb_bodega.bo_Descripcion
FROM            dbo.tb_bodega INNER JOIN
                         dbo.tb_sucursal ON dbo.tb_bodega.IdEmpresa = dbo.tb_sucursal.IdEmpresa AND dbo.tb_bodega.IdSucursal = dbo.tb_sucursal.IdSucursal RIGHT OUTER JOIN
                             (SELECT        dbo.in_movi_inve_detalle.IdEmpresa, dbo.in_movi_inve_detalle.IdSucursal, dbo.in_movi_inve_detalle.IdBodega, dbo.in_Producto.IdProducto, in_Producto_1.pr_codigo, in_Producto_1.pr_descripcion, 
                                                         in_Producto_1.IdProducto_padre, in_Producto_1.lote_fecha_fab, in_Producto_1.lote_fecha_vcto, in_Producto_1.lote_num_lote, SUM(dbo.in_movi_inve_detalle.dm_cantidad) AS cantidad, 
                                                         dbo.in_Producto_Composicion.IdProductoPadre AS IdProducto_combo, dbo.in_Producto.IdCategoria, dbo.in_Producto.IdLinea, dbo.in_Producto.IdGrupo, dbo.in_Producto.IdSubGrupo, 
                                                         dbo.in_Producto.IdPresentacion
                               FROM            dbo.in_movi_inve_detalle INNER JOIN
                                                         dbo.in_Producto ON dbo.in_movi_inve_detalle.IdEmpresa = dbo.in_Producto.IdEmpresa AND dbo.in_movi_inve_detalle.IdProducto = dbo.in_Producto.IdProducto INNER JOIN
                                                         dbo.in_Producto_Composicion ON dbo.in_Producto.IdEmpresa = dbo.in_Producto_Composicion.IdEmpresa AND dbo.in_Producto.IdProducto = dbo.in_Producto_Composicion.IdProductoHijo INNER JOIN
                                                         dbo.in_Producto AS in_Producto_1 ON dbo.in_Producto_Composicion.IdEmpresa = in_Producto_1.IdEmpresa AND dbo.in_Producto_Composicion.IdProductoPadre = in_Producto_1.IdProducto
                               GROUP BY dbo.in_movi_inve_detalle.IdEmpresa, dbo.in_movi_inve_detalle.IdSucursal, dbo.in_movi_inve_detalle.IdBodega, dbo.in_Producto.IdProducto, in_Producto_1.pr_codigo, in_Producto_1.pr_descripcion, 
                                                         in_Producto_1.IdProducto_padre, in_Producto_1.lote_fecha_fab, in_Producto_1.lote_fecha_vcto, in_Producto_1.lote_num_lote, dbo.in_Producto_Composicion.IdProductoPadre, dbo.in_Producto.IdCategoria, 
                                                         dbo.in_Producto.IdLinea, dbo.in_Producto.IdGrupo, dbo.in_Producto.IdSubGrupo, dbo.in_Producto.IdPresentacion) AS A ON dbo.tb_bodega.IdEmpresa = A.IdEmpresa AND 
                         dbo.tb_bodega.IdSucursal = A.IdSucursal AND dbo.tb_bodega.IdBodega = A.IdBodega LEFT OUTER JOIN
                         dbo.in_presentacion ON A.IdEmpresa = dbo.in_presentacion.IdEmpresa AND A.IdPresentacion = dbo.in_presentacion.IdPresentacion LEFT OUTER JOIN
                         dbo.in_categorias ON A.IdEmpresa = dbo.in_categorias.IdEmpresa AND A.IdCategoria = dbo.in_categorias.IdCategoria
GROUP BY A.IdEmpresa, A.IdSucursal, A.IdBodega, A.IdProducto_combo, A.pr_codigo, A.pr_descripcion, A.IdProducto_padre, A.lote_fecha_fab, A.lote_fecha_vcto, A.lote_num_lote, A.IdCategoria, A.IdLinea, A.IdGrupo, A.IdSubGrupo, 
                         dbo.in_categorias.ca_Categoria, A.IdPresentacion, dbo.in_presentacion.nom_presentacion, dbo.tb_sucursal.Su_Descripcion, dbo.tb_bodega.bo_Descripcion