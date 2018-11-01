--exec [dbo].[spINV_Rpt009] 1,1,999,1,999,2234,2234,'01/09/2017'
CREATE PROCEDURE [dbo].[spINV_Rpt009]
(
@IdEmpresa int,
@IdSucursal_ini int,
@IdSucursal_fin int,
@IdBodega_ini int,
@IdBodega_fin int,
@IdProducto_ini numeric,
@IdProducto_fin numeric,
@fecha_corte datetime
)
as
begin
SELECT        in_movi_inve_detalle.IdEmpresa, in_movi_inve_detalle.IdSucursal, in_movi_inve_detalle.IdBodega, tb_bodega.bo_Descripcion AS nom_bodega, 
                         tb_sucursal.Su_Descripcion AS nom_sucursal, in_Producto.pr_codigo, in_Producto.pr_descripcion, in_Producto.pr_observacion, 
                         ISNULL(SUM(in_movi_inve_detalle.dm_cantidad), 0) AS Stock, in_movi_inve_detalle.IdProducto, ISNULL(SUM(in_movi_inve_detalle.dm_cantidad * in_movi_inve_detalle.mv_costo) / IIF(SUM(in_movi_inve_detalle.dm_cantidad) = 0, 1, SUM(in_movi_inve_detalle.dm_cantidad)) ,0) AS mv_costo, 
                         SUM(in_movi_inve_detalle.dm_cantidad * in_movi_inve_detalle.mv_costo) AS costo_total, in_Producto.IdCategoria, 
                         in_categorias.ca_Categoria, in_Producto.IdLinea, in_linea.nom_linea, in_UnidadMedida.Descripcion AS nom_UnidadMedida,
						  dbo.in_subgrupo.nom_subgrupo, dbo.in_grupo.nom_grupo, dbo.in_Marca.Descripcion AS Marca, dbo.in_presentacion.nom_presentacion, in_subgrupo.IdGrupo,in_subgrupo.IdSubgrupo


FROM            dbo.in_subgrupo INNER JOIN
                         dbo.in_grupo ON dbo.in_subgrupo.IdEmpresa = dbo.in_grupo.IdEmpresa AND dbo.in_subgrupo.IdCategoria = dbo.in_grupo.IdCategoria AND dbo.in_subgrupo.IdLinea = dbo.in_grupo.IdLinea AND 
                         dbo.in_subgrupo.IdGrupo = dbo.in_grupo.IdGrupo INNER JOIN
                         dbo.in_categorias INNER JOIN
                         dbo.in_linea ON dbo.in_categorias.IdEmpresa = dbo.in_linea.IdEmpresa AND dbo.in_categorias.IdCategoria = dbo.in_linea.IdCategoria INNER JOIN
                         dbo.tb_bodega INNER JOIN
                         dbo.tb_sucursal ON dbo.tb_bodega.IdEmpresa = dbo.tb_sucursal.IdEmpresa AND dbo.tb_bodega.IdSucursal = dbo.tb_sucursal.IdSucursal INNER JOIN
                         dbo.in_Producto INNER JOIN
                         dbo.in_movi_inve_detalle ON dbo.in_Producto.IdEmpresa = dbo.in_movi_inve_detalle.IdEmpresa AND dbo.in_Producto.IdProducto = dbo.in_movi_inve_detalle.IdProducto ON 
                         dbo.tb_bodega.IdEmpresa = dbo.in_movi_inve_detalle.IdEmpresa AND dbo.tb_bodega.IdSucursal = dbo.in_movi_inve_detalle.IdSucursal AND dbo.tb_bodega.IdBodega = dbo.in_movi_inve_detalle.IdBodega ON 
                         dbo.in_linea.IdEmpresa = dbo.in_Producto.IdEmpresa AND dbo.in_linea.IdCategoria = dbo.in_Producto.IdCategoria AND dbo.in_linea.IdLinea = dbo.in_Producto.IdLinea INNER JOIN
                         dbo.in_UnidadMedida ON dbo.in_Producto.IdUnidadMedida_Consumo = dbo.in_UnidadMedida.IdUnidadMedida INNER JOIN
                         dbo.in_movi_inve ON dbo.in_movi_inve.IdEmpresa = dbo.in_movi_inve_detalle.IdEmpresa AND dbo.in_movi_inve.IdSucursal = dbo.in_movi_inve_detalle.IdSucursal AND 
                         dbo.in_movi_inve.IdBodega = dbo.in_movi_inve_detalle.IdBodega AND dbo.in_movi_inve.IdMovi_inven_tipo = dbo.in_movi_inve_detalle.IdMovi_inven_tipo AND 
                         dbo.in_movi_inve.IdNumMovi = dbo.in_movi_inve_detalle.IdNumMovi INNER JOIN
                         dbo.in_presentacion ON dbo.in_Producto.IdEmpresa = dbo.in_presentacion.IdEmpresa AND dbo.in_Producto.IdPresentacion = dbo.in_presentacion.IdPresentacion INNER JOIN
                         dbo.in_Marca ON dbo.in_Producto.IdEmpresa = dbo.in_Marca.IdEmpresa AND dbo.in_Producto.IdMarca = dbo.in_Marca.IdMarca ON dbo.in_subgrupo.IdEmpresa = dbo.in_Producto.IdEmpresa AND 
                         dbo.in_subgrupo.IdCategoria = dbo.in_Producto.IdCategoria AND dbo.in_subgrupo.IdLinea = dbo.in_Producto.IdLinea AND dbo.in_subgrupo.IdGrupo = dbo.in_Producto.IdGrupo AND 
                         dbo.in_subgrupo.IdSubgrupo = dbo.in_Producto.IdSubGrupo
where (in_movi_inve.IdEmpresa = @IdEmpresa) and (in_movi_inve.IdSucursal between @IdSucursal_ini and @IdSucursal_fin) and (in_movi_inve.IdBodega between @IdBodega_ini and @IdBodega_fin)
and (in_movi_inve.cm_fecha <= @fecha_corte) and in_movi_inve_detalle.IdProducto between @IdProducto_ini and @IdProducto_fin
GROUP BY in_movi_inve_detalle.IdEmpresa, in_movi_inve_detalle.IdSucursal, in_movi_inve_detalle.IdBodega, tb_bodega.bo_Descripcion, tb_sucursal.Su_Descripcion, 
                         in_Producto.pr_codigo, in_Producto.pr_descripcion, in_Producto.pr_observacion, in_movi_inve_detalle.IdProducto, 
                         in_Producto.IdCategoria, in_categorias.ca_Categoria, in_Producto.IdLinea, in_linea.nom_linea, in_UnidadMedida.Descripcion,
						 dbo.in_subgrupo.nom_subgrupo, dbo.in_grupo.nom_grupo, dbo.in_Marca.Descripcion , dbo.in_presentacion.nom_presentacion, in_subgrupo.IdGrupo,in_subgrupo.IdSubgrupo


end