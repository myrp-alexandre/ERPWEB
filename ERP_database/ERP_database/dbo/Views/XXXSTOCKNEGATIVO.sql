CREATE VIEW XXXSTOCKNEGATIVO
AS
SELECT        in_movi_inve_detalle.IdEmpresa, in_movi_inve_detalle.IdSucursal, in_movi_inve_detalle.IdBodega, in_movi_inve_detalle.IdProducto, in_Producto.pr_descripcion, in_presentacion.nom_presentacion, 
                         in_Producto.lote_num_lote, in_Producto.lote_fecha_vcto, SUM(in_movi_inve_detalle.dm_cantidad) AS Stock
FROM            in_presentacion INNER JOIN
                         in_Producto ON in_presentacion.IdEmpresa = in_Producto.IdEmpresa AND in_presentacion.IdPresentacion = in_Producto.IdPresentacion RIGHT OUTER JOIN
                         in_movi_inve_detalle ON in_Producto.IdEmpresa = in_movi_inve_detalle.IdEmpresa AND in_Producto.IdProducto = in_movi_inve_detalle.IdProducto
WHERE        (in_Producto.se_distribuye = 0)
GROUP BY in_movi_inve_detalle.IdEmpresa, in_movi_inve_detalle.IdSucursal, in_movi_inve_detalle.IdBodega, in_movi_inve_detalle.IdProducto, in_Producto.pr_descripcion, in_presentacion.nom_presentacion, 
                         in_Producto.lote_num_lote, in_Producto.lote_fecha_vcto
HAVING SUM(in_movi_inve_detalle.dm_cantidad) < 0