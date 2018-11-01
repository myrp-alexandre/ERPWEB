--exec [dbo].[spINV_Rpt029] 1,1,999,1,999,'01/09/2016'
CREATE PROCEDURE [dbo].[spINV_Rpt029]
(
@IdEmpresa int,
@IdSucursal_ini int,
@IdSucursal_fin int,
@IdBodega_ini int,
@IdBodega_fin int,
@fecha_corte datetime
)
as
begin
SELECT        in_movi_inve_detalle.IdEmpresa, in_movi_inve_detalle.IdSucursal, in_movi_inve_detalle.IdBodega, tb_bodega.bo_Descripcion AS nom_bodega, 
                         tb_sucursal.Su_Descripcion AS nom_sucursal, in_Producto.pr_codigo, in_Producto.pr_descripcion, in_Producto.pr_observacion, 
                         ISNULL(SUM(in_movi_inve_detalle.dm_cantidad), 0) AS Stock, in_movi_inve_detalle.IdProducto, ISNULL(SUM(in_movi_inve_detalle.dm_cantidad * in_movi_inve_detalle.mv_costo) / IIF(SUM(in_movi_inve_detalle.dm_cantidad) = 0, 1, SUM(in_movi_inve_detalle.dm_cantidad)) ,0) AS mv_costo, 
                         SUM(in_movi_inve_detalle.dm_cantidad * in_movi_inve_detalle.mv_costo) AS costo_total, in_Producto.IdCategoria, 
                         in_categorias.ca_Categoria, in_Producto.IdLinea, in_linea.nom_linea, in_UnidadMedida.Descripcion AS nom_UnidadMedida
FROM            in_categorias INNER JOIN
                         in_linea ON in_categorias.IdEmpresa = in_linea.IdEmpresa AND in_categorias.IdCategoria = in_linea.IdCategoria INNER JOIN
                         tb_bodega INNER JOIN
                         tb_sucursal ON tb_bodega.IdEmpresa = tb_sucursal.IdEmpresa AND tb_bodega.IdSucursal = tb_sucursal.IdSucursal INNER JOIN
                         in_Producto INNER JOIN
                         in_movi_inve_detalle ON in_Producto.IdEmpresa = in_movi_inve_detalle.IdEmpresa AND in_Producto.IdProducto = in_movi_inve_detalle.IdProducto ON 
                         tb_bodega.IdEmpresa = in_movi_inve_detalle.IdEmpresa AND tb_bodega.IdSucursal = in_movi_inve_detalle.IdSucursal AND 
                         tb_bodega.IdBodega = in_movi_inve_detalle.IdBodega ON in_linea.IdEmpresa = in_Producto.IdEmpresa AND in_linea.IdCategoria = in_Producto.IdCategoria AND 
                         in_linea.IdLinea = in_Producto.IdLinea INNER JOIN
                         in_UnidadMedida ON in_Producto.IdUnidadMedida_Consumo = in_UnidadMedida.IdUnidadMedida INNER JOIN
                         in_movi_inve ON in_movi_inve.IdEmpresa = in_movi_inve_detalle.IdEmpresa AND in_movi_inve.IdSucursal = in_movi_inve_detalle.IdSucursal AND 
                         in_movi_inve.IdBodega = in_movi_inve_detalle.IdBodega AND in_movi_inve.IdMovi_inven_tipo = in_movi_inve_detalle.IdMovi_inven_tipo AND 
                         in_movi_inve.IdNumMovi = in_movi_inve_detalle.IdNumMovi 
where (in_movi_inve.IdEmpresa = @IdEmpresa) and (in_movi_inve.IdSucursal between @IdSucursal_ini and @IdSucursal_fin) and (in_movi_inve.IdBodega between @IdBodega_ini and @IdBodega_fin)
and (in_movi_inve.cm_fecha <= @fecha_corte)
GROUP BY in_movi_inve_detalle.IdEmpresa, in_movi_inve_detalle.IdSucursal, in_movi_inve_detalle.IdBodega, tb_bodega.bo_Descripcion, tb_sucursal.Su_Descripcion, 
                         in_Producto.pr_codigo, in_Producto.pr_descripcion, in_Producto.pr_observacion, in_movi_inve_detalle.IdProducto, 
                         in_Producto.IdCategoria, in_categorias.ca_Categoria, in_Producto.IdLinea, in_linea.nom_linea, in_UnidadMedida.Descripcion
end