CREATE VIEW [Fj_servindustrias].[vwINV_FJ_Rpt008]
AS
SELECT        dbo.in_movi_inve_detalle.IdEmpresa, dbo.in_movi_inve_detalle.IdSucursal, dbo.in_movi_inve_detalle.IdBodega, dbo.in_movi_inve_detalle.IdMovi_inven_tipo, dbo.in_Ing_Egr_Inven_det.IdNumMovi, 
                         dbo.in_movi_inve_detalle.Secuencia, dbo.in_movi_inve_detalle.IdProducto, dbo.in_Producto.pr_codigo AS cod_producto, dbo.in_Producto.pr_descripcion AS nom_producto, 
                         dbo.in_UnidadMedida.IdUnidadMedida, dbo.in_UnidadMedida.Descripcion AS nom_unidad_medida, dbo.in_movi_inve.cm_fecha, dbo.tb_bodega.cod_bodega, dbo.tb_bodega.bo_Descripcion AS nom_bodega, 
                         dbo.tb_sucursal.codigo AS cod_sucursal, dbo.tb_sucursal.Su_Descripcion AS nom_sucursal, dbo.ct_centro_costo.IdCentroCosto, dbo.ct_centro_costo.Centro_costo AS nom_centro_costo, 
                         dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto_sub_centro_costo, dbo.ct_centro_costo_sub_centro_costo.Centro_costo AS nom_subcentro_costo, ABS(dbo.in_movi_inve_detalle.dm_cantidad) 
                         AS dm_cantidad, dbo.in_movi_inve_detalle.mv_costo, ABS(dbo.in_movi_inve_detalle.dm_cantidad) * dbo.in_movi_inve_detalle.mv_costo AS Total, dbo.in_movi_inve_detalle.mv_tipo_movi, 
                         dbo.in_movi_inve_detalle.IdPunto_cargo_grupo, dbo.ct_punto_cargo_grupo.cod_Punto_cargo_grupo, dbo.ct_punto_cargo_grupo.nom_punto_cargo_grupo, dbo.in_movi_inve_detalle.IdPunto_cargo, 
                         dbo.ct_punto_cargo.codPunto_cargo, dbo.ct_punto_cargo.nom_punto_cargo
FROM            dbo.tb_sucursal INNER JOIN
                         dbo.tb_bodega ON dbo.tb_sucursal.IdEmpresa = dbo.tb_bodega.IdEmpresa AND dbo.tb_sucursal.IdSucursal = dbo.tb_bodega.IdSucursal RIGHT OUTER JOIN
                         dbo.ct_punto_cargo_grupo RIGHT OUTER JOIN
                         dbo.ct_punto_cargo RIGHT OUTER JOIN
                         dbo.ct_centro_costo_sub_centro_costo INNER JOIN
                         dbo.in_movi_inve INNER JOIN
                         dbo.in_movi_inve_detalle ON dbo.in_movi_inve.IdEmpresa = dbo.in_movi_inve_detalle.IdEmpresa AND dbo.in_movi_inve.IdSucursal = dbo.in_movi_inve_detalle.IdSucursal AND 
                         dbo.in_movi_inve.IdBodega = dbo.in_movi_inve_detalle.IdBodega AND dbo.in_movi_inve.IdMovi_inven_tipo = dbo.in_movi_inve_detalle.IdMovi_inven_tipo AND 
                         dbo.in_movi_inve.IdNumMovi = dbo.in_movi_inve_detalle.IdNumMovi INNER JOIN
                         dbo.in_Producto ON dbo.in_movi_inve_detalle.IdEmpresa = dbo.in_Producto.IdEmpresa AND dbo.in_movi_inve_detalle.IdProducto = dbo.in_Producto.IdProducto ON 
                         dbo.ct_centro_costo_sub_centro_costo.IdEmpresa = dbo.in_movi_inve_detalle.IdEmpresa AND dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto = dbo.in_movi_inve_detalle.IdCentroCosto AND 
                         dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto_sub_centro_costo = dbo.in_movi_inve_detalle.IdCentroCosto_sub_centro_costo INNER JOIN
                         dbo.ct_centro_costo ON dbo.ct_centro_costo_sub_centro_costo.IdEmpresa = dbo.ct_centro_costo.IdEmpresa AND 
                         dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto = dbo.ct_centro_costo.IdCentroCosto INNER JOIN
                         dbo.in_UnidadMedida ON dbo.in_movi_inve_detalle.IdUnidadMedida = dbo.in_UnidadMedida.IdUnidadMedida INNER JOIN
                         dbo.in_Ing_Egr_Inven_det ON dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto = dbo.in_Ing_Egr_Inven_det.IdCentroCosto AND 
                         dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto_sub_centro_costo = dbo.in_Ing_Egr_Inven_det.IdCentroCosto_sub_centro_costo AND 
                         dbo.in_movi_inve_detalle.IdEmpresa = dbo.in_Ing_Egr_Inven_det.IdEmpresa_inv AND dbo.in_movi_inve_detalle.IdSucursal = dbo.in_Ing_Egr_Inven_det.IdSucursal_inv AND 
                         dbo.in_movi_inve_detalle.IdBodega = dbo.in_Ing_Egr_Inven_det.IdBodega_inv AND dbo.in_movi_inve_detalle.IdMovi_inven_tipo = dbo.in_Ing_Egr_Inven_det.IdMovi_inven_tipo_inv AND 
                         dbo.in_movi_inve_detalle.IdNumMovi = dbo.in_Ing_Egr_Inven_det.IdNumMovi_inv AND dbo.in_movi_inve_detalle.Secuencia = dbo.in_Ing_Egr_Inven_det.secuencia_inv ON 
                         dbo.ct_punto_cargo.IdEmpresa = dbo.in_movi_inve_detalle.IdEmpresa AND dbo.ct_punto_cargo.IdPunto_cargo = dbo.in_movi_inve_detalle.IdPunto_cargo ON 
                         dbo.ct_punto_cargo_grupo.IdEmpresa = dbo.in_movi_inve_detalle.IdEmpresa AND dbo.ct_punto_cargo_grupo.IdPunto_cargo_grupo = dbo.in_movi_inve_detalle.IdPunto_cargo_grupo ON 
                         dbo.tb_bodega.IdEmpresa = dbo.in_movi_inve.IdEmpresa AND dbo.tb_bodega.IdSucursal = dbo.in_movi_inve.IdSucursal AND dbo.tb_bodega.IdBodega = dbo.in_movi_inve.IdBodega
WHERE        (dbo.in_movi_inve_detalle.mv_tipo_movi = N'-')