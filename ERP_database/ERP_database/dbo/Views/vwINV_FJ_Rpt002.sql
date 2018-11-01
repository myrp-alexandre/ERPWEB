
CREATE VIEW [dbo].[vwINV_FJ_Rpt002]
AS
SELECT        dbo.in_movi_inve.IdEmpresa, dbo.in_movi_inve.IdSucursal, dbo.in_movi_inve.IdBodega, dbo.in_movi_inve.IdMovi_inven_tipo, dbo.in_movi_inve.IdNumMovi, 
                         dbo.in_movi_inve.CodMoviInven, dbo.tb_sucursal.Su_Descripcion AS nom_sucursal, dbo.tb_bodega.bo_Descripcion AS nom_bodega, 
                         dbo.in_movi_inve.cm_fecha AS Fecha, dbo.in_movi_inven_tipo.Codigo AS cod_Movi_Inven_tipo, dbo.in_movi_inven_tipo.tm_descripcion AS nom_Movi_Inven_tipo, 
                         dbo.in_movi_inve.NumDocumentoRelacionado, dbo.in_movi_inve.NumFactura, dbo.in_movi_inve.cm_observacion AS Observacion, 
                         dbo.in_movi_inve_detalle.mv_tipo_movi, (CASE WHEN dbo.in_movi_inve_detalle.mv_tipo_movi = '+' THEN dbo.in_movi_inve_detalle.dm_cantidad ELSE 0 END) 
                         AS CantiIngreso, (CASE WHEN dbo.in_movi_inve_detalle.mv_tipo_movi = '-' THEN (dbo.in_movi_inve_detalle.dm_cantidad * (- 1)) ELSE 0 END) AS CantiEgreso, 
                         0 AS Saldo, dbo.in_Producto.pr_codigo AS Cod_producto, dbo.in_Producto.pr_descripcion AS nom_producto, dbo.in_movi_inve_detalle.IdProducto, 
                         ISNULL(dbo.ct_centro_costo.IdCentroCosto, '') AS IdCentroCosto, dbo.ct_centro_costo.Centro_costo AS nom_Centro_costo, 
                         ISNULL(dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto_sub_centro_costo, '') AS IdSubCentro_costo, 
                         dbo.ct_centro_costo_sub_centro_costo.Centro_costo AS nom_SubCentro_costo
FROM            dbo.ct_centro_costo RIGHT OUTER JOIN
                         dbo.tb_bodega INNER JOIN
                         dbo.tb_sucursal ON dbo.tb_bodega.IdEmpresa = dbo.tb_sucursal.IdEmpresa AND dbo.tb_bodega.IdSucursal = dbo.tb_sucursal.IdSucursal INNER JOIN
                         dbo.in_movi_inve ON dbo.tb_bodega.IdEmpresa = dbo.in_movi_inve.IdEmpresa AND dbo.tb_bodega.IdSucursal = dbo.in_movi_inve.IdSucursal AND 
                         dbo.tb_bodega.IdBodega = dbo.in_movi_inve.IdBodega INNER JOIN
                         dbo.in_movi_inven_tipo ON dbo.in_movi_inve.IdEmpresa = dbo.in_movi_inven_tipo.IdEmpresa AND 
                         dbo.in_movi_inve.IdMovi_inven_tipo = dbo.in_movi_inven_tipo.IdMovi_inven_tipo INNER JOIN
                         dbo.in_movi_inve_detalle ON dbo.in_movi_inve.IdEmpresa = dbo.in_movi_inve_detalle.IdEmpresa AND 
                         dbo.in_movi_inve.IdSucursal = dbo.in_movi_inve_detalle.IdSucursal AND dbo.in_movi_inve.IdBodega = dbo.in_movi_inve_detalle.IdBodega AND 
                         dbo.in_movi_inve.IdMovi_inven_tipo = dbo.in_movi_inve_detalle.IdMovi_inven_tipo AND 
                         dbo.in_movi_inve.IdNumMovi = dbo.in_movi_inve_detalle.IdNumMovi INNER JOIN
                         dbo.in_Producto ON dbo.in_movi_inve_detalle.IdEmpresa = dbo.in_Producto.IdEmpresa AND dbo.in_movi_inve_detalle.IdProducto = dbo.in_Producto.IdProducto ON 
                         dbo.ct_centro_costo.IdEmpresa = dbo.in_movi_inve_detalle.IdEmpresa AND 
                         dbo.ct_centro_costo.IdCentroCosto = dbo.in_movi_inve_detalle.IdCentroCosto LEFT OUTER JOIN
                         dbo.ct_centro_costo_sub_centro_costo ON dbo.in_movi_inve_detalle.IdEmpresa = dbo.ct_centro_costo_sub_centro_costo.IdEmpresa AND 
                         dbo.in_movi_inve_detalle.IdCentroCosto = dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto AND 
                         dbo.in_movi_inve_detalle.IdCentroCosto_sub_centro_costo = dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto_sub_centro_costo