CREATE PROCEDURE [web].[SPINV_009]
(
@IdEmpresa int,
@IdSucursalIni int,
@IdSucursalFin int,
@IdBodegaIni int,
@IdBodegaFin int,
@IdMarcaIni int,
@IdMarcaFin int,
@IdProductoPadreIni numeric,
@IdProductoPadreFin numeric,
@FechaCorte datetime
)
AS

SELECT        in_movi_inve_detalle.IdEmpresa, in_movi_inve_detalle.IdSucursal, in_movi_inve_detalle.IdBodega, in_Producto.IdProducto, in_Producto.pr_descripcion, in_Producto.IdMarca, in_Marca.Descripcion AS NomMarca, 
                         in_Producto.IdPresentacion, in_presentacion.nom_presentacion, in_Producto.IdProductoTipo, in_ProductoTipo.tp_descripcion, in_Producto.lote_num_lote, in_Producto.lote_fecha_vcto, in_Producto.precio_1, 
                         ROUND(SUM(in_movi_inve_detalle.dm_cantidad), 2) AS dm_cantidad, ROUND(SUM(in_movi_inve_detalle.dm_cantidad * in_movi_inve_detalle.mv_costo), 2) AS CostoTotal, ISNULL(in_Producto.IdProducto_padre, 0) 
                         AS IdProducto_padre, tb_sucursal.Su_Descripcion, tb_bodega.bo_Descripcion,
						  ROUND(SUM(in_movi_inve_detalle.dm_cantidad)* in_Producto.precio_1, 2) as PrecioTotal
FROM            in_movi_inve_detalle LEFT OUTER JOIN
                         tb_bodega INNER JOIN
                         tb_sucursal ON tb_bodega.IdEmpresa = tb_sucursal.IdEmpresa AND tb_bodega.IdSucursal = tb_sucursal.IdSucursal ON in_movi_inve_detalle.IdEmpresa = tb_bodega.IdEmpresa AND 
                         in_movi_inve_detalle.IdSucursal = tb_bodega.IdSucursal AND in_movi_inve_detalle.IdBodega = tb_bodega.IdBodega LEFT OUTER JOIN
                         in_Producto INNER JOIN
                         in_ProductoTipo ON in_Producto.IdEmpresa = in_ProductoTipo.IdEmpresa AND in_Producto.IdProductoTipo = in_ProductoTipo.IdProductoTipo INNER JOIN
                         in_presentacion ON in_Producto.IdEmpresa = in_presentacion.IdEmpresa AND in_Producto.IdPresentacion = in_presentacion.IdPresentacion INNER JOIN
                         in_Marca ON in_Producto.IdEmpresa = in_Marca.IdEmpresa AND in_Producto.IdMarca = in_Marca.IdMarca ON in_movi_inve_detalle.IdEmpresa = in_Producto.IdEmpresa AND 
                         in_movi_inve_detalle.IdProducto = in_Producto.IdProducto
where in_movi_inve_detalle.IdEmpresa = @IdEmpresa and in_movi_inve_detalle.IdSucursal between @IdSucursalIni and @IdSucursalFin and in_movi_inve_detalle.IdBodega between @IdBodegaIni and @IdBodegaFin 
and in_Producto.IdMarca between @IdMarcaIni and @IdMarcaFin and isnull(in_Producto.IdProducto_padre,0) between @IdProductoPadreIni and @IdProductoPadreFin and
isnull(in_Producto.lote_fecha_vcto, getdate()) < @FechaCorte
group by in_movi_inve_detalle.IdEmpresa, in_movi_inve_detalle.IdSucursal, in_movi_inve_detalle.IdBodega, in_Producto.IdProducto, in_Producto.pr_descripcion, in_Producto.IdMarca, in_Marca.Descripcion, in_Producto.IdPresentacion, in_presentacion.nom_presentacion, in_Producto.IdProductoTipo, 
                  in_ProductoTipo.tp_descripcion, in_Producto.lote_num_lote, in_Producto.lote_fecha_vcto, in_Producto.precio_1, in_Producto.IdProducto_padre, tb_sucursal.Su_Descripcion, tb_bodega.bo_Descripcion
having round(sum(in_movi_inve_detalle.dm_cantidad),2) > 0