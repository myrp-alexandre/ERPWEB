-- exec web.SPINV_012 1,1,1,1,1,1,99999,1,9999,'2018/09/09',40
CREATE PROCEDURE web.SPINV_012
(
@IdEmpresa int,
@IdSucursalIni int,
@IdSucursalFin int,
@IdBodegaIni int,
@IdBodegaFin int,
@IdProductoIni numeric,
@IdProductoFin numeric,
@IdMarcaIni int,
@IdMarcaFin int,
@FechaIni DATETIME,
@DIAS INT
)
AS
DECLARE @FECHAFIN DATETIME
SET @FECHAFIN = cast(DATEADD(DAY,@DIAS,@FechaIni) as date)

SELECT        in_producto_x_tb_bodega.IdEmpresa, in_producto_x_tb_bodega.IdSucursal, in_producto_x_tb_bodega.IdBodega, in_producto_x_tb_bodega.IdProducto, tb_sucursal.Su_Descripcion NomSucursal, tb_bodega.bo_Descripcion NomBodega, 
                         in_Marca.Descripcion NomMarca, in_presentacion.nom_presentacion NomPresentacion, in_Producto.pr_descripcion NomProducto, in_Producto.lote_fecha_vcto, in_Producto.lote_num_lote, in_Producto.IdProducto_padre,
						 DATEDIFF(DAY,@FECHAINI,in_Producto.lote_fecha_vcto) AS DiasAVencer, isnull(mov.StockActual,0) StockActual
FROM            in_Producto LEFT OUTER JOIN
                         in_Marca ON in_Producto.IdEmpresa = in_Marca.IdEmpresa AND in_Producto.IdMarca = in_Marca.IdMarca LEFT OUTER JOIN
                         in_presentacion ON in_Producto.IdEmpresa = in_presentacion.IdEmpresa AND in_Producto.IdPresentacion = in_presentacion.IdPresentacion RIGHT OUTER JOIN
                         tb_bodega RIGHT OUTER JOIN
                         in_producto_x_tb_bodega ON tb_bodega.IdEmpresa = in_producto_x_tb_bodega.IdEmpresa AND tb_bodega.IdSucursal = in_producto_x_tb_bodega.IdSucursal AND 
                         tb_bodega.IdBodega = in_producto_x_tb_bodega.IdBodega LEFT OUTER JOIN
                         tb_sucursal ON tb_bodega.IdEmpresa = tb_sucursal.IdEmpresa AND tb_bodega.IdSucursal = tb_sucursal.IdSucursal ON in_Producto.IdEmpresa = in_producto_x_tb_bodega.IdEmpresa AND 
                         in_Producto.IdProducto = in_producto_x_tb_bodega.IdProducto LEFT OUTER JOIN
                             (SELECT        p.IdEmpresa, d.IdSucursal, d.IdBodega, d.IdProducto, SUM(d.dm_cantidad) AS StockActual
                               FROM            in_movi_inve_detalle AS d INNER JOIN
                                                         in_Producto AS p ON d.IdEmpresa = p.IdEmpresa AND d.IdProducto = p.IdProducto
														 where isnull(p.lote_fecha_vcto,getdate()) >= GETDATE()
														 and d.IdEmpresa = @IdEmpresa and d.IdSucursal between @IdSucursalIni and @IdSucursalFin
														 and d.IdBodega between @IdBodegaIni and @IdBodegaFin and ISNULL(p.IdProducto_padre, d.IdProducto) between @IdProductoIni and @IdProductoFin
														 and p.IdMarca between @IdMarcaIni and @IdMarcaFin and p.Estado = 'A'
                               GROUP BY p.IdEmpresa, d.IdSucursal, d.IdBodega, d.IdProducto) AS mov ON in_producto_x_tb_bodega.IdEmpresa = mov.IdEmpresa AND in_producto_x_tb_bodega.IdSucursal = mov.IdSucursal AND 
                         in_producto_x_tb_bodega.IdBodega = mov.IdBodega AND in_producto_x_tb_bodega.IdProducto = mov.IdProducto
WHERE        (in_Producto.se_distribuye = 0) AND (in_Producto.IdProducto_padre IS NOT NULL) AND IN_PRODUCTO.lote_fecha_vcto BETWEEN @FECHAINI AND @FECHAFIN
and in_producto_x_tb_bodega.IdEmpresa = @IdEmpresa and in_producto_x_tb_bodega.IdSucursal between @IdSucursalIni and @IdSucursalFin and in_producto_x_tb_bodega.IdBodega between @IdBodegaIni and @IdBodegaFin and
in_producto.IdProducto_padre between @IdProductoIni and @IdProductoFin and ISNULL(mov.StockActual,0) > 0 and in_producto.IdMarca between @IdMarcaIni and @IdMarcaFin AND in_Producto.Estado = 'A'