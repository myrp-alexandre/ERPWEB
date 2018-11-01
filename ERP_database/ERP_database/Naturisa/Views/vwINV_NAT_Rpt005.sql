CREATE VIEW Naturisa.vwINV_NAT_Rpt005
AS
SELECT        in_movi_inve_detalle.IdEmpresa, in_movi_inve_detalle.IdSucursal, in_movi_inve_detalle.IdBodega, in_movi_inve_detalle.IdMovi_inven_tipo, 
                         in_movi_inve_detalle.IdNumMovi, in_movi_inve_detalle.Secuencia, in_movi_inve_detalle.IdProducto, in_Producto.pr_codigo AS cod_producto, 
                         in_Producto.pr_descripcion AS nom_producto, in_UnidadMedida.IdUnidadMedida, in_UnidadMedida.Descripcion AS nom_unidad_medida, in_movi_inve.cm_fecha, 
                         tb_bodega.cod_bodega, tb_bodega.bo_Descripcion AS nom_bodega, tb_sucursal.codigo AS cod_sucursal, tb_sucursal.Su_Descripcion AS nom_sucursal, 
                         ct_centro_costo.IdCentroCosto, ct_centro_costo.Centro_costo AS nom_centro_costo, ct_centro_costo_sub_centro_costo.IdCentroCosto_sub_centro_costo, 
                         ct_centro_costo_sub_centro_costo.Centro_costo AS nom_subcentro_costo, ABS(in_movi_inve_detalle.dm_cantidad) dm_cantidad, in_movi_inve_detalle.mv_costo, 
                         ABS(in_movi_inve_detalle.dm_cantidad) * in_movi_inve_detalle.mv_costo AS Total, in_movi_inve_detalle.mv_tipo_movi
FROM            ct_centro_costo_sub_centro_costo INNER JOIN
                         in_movi_inve INNER JOIN
                         in_movi_inve_detalle ON in_movi_inve.IdEmpresa = in_movi_inve_detalle.IdEmpresa AND in_movi_inve.IdSucursal = in_movi_inve_detalle.IdSucursal AND 
                         in_movi_inve.IdBodega = in_movi_inve_detalle.IdBodega AND in_movi_inve.IdMovi_inven_tipo = in_movi_inve_detalle.IdMovi_inven_tipo AND 
                         in_movi_inve.IdNumMovi = in_movi_inve_detalle.IdNumMovi INNER JOIN
                         in_Producto ON in_movi_inve_detalle.IdEmpresa = in_Producto.IdEmpresa AND in_movi_inve_detalle.IdProducto = in_Producto.IdProducto ON 
                         ct_centro_costo_sub_centro_costo.IdEmpresa = in_movi_inve_detalle.IdEmpresa AND 
                         ct_centro_costo_sub_centro_costo.IdCentroCosto = in_movi_inve_detalle.IdCentroCosto AND 
                         ct_centro_costo_sub_centro_costo.IdCentroCosto_sub_centro_costo = in_movi_inve_detalle.IdCentroCosto_sub_centro_costo INNER JOIN
                         ct_centro_costo ON ct_centro_costo_sub_centro_costo.IdEmpresa = ct_centro_costo.IdEmpresa AND 
                         ct_centro_costo_sub_centro_costo.IdCentroCosto = ct_centro_costo.IdCentroCosto INNER JOIN
                         in_UnidadMedida ON in_movi_inve_detalle.IdUnidadMedida = in_UnidadMedida.IdUnidadMedida LEFT OUTER JOIN
                         tb_sucursal INNER JOIN
                         tb_bodega ON tb_sucursal.IdEmpresa = tb_bodega.IdEmpresa AND tb_sucursal.IdSucursal = tb_bodega.IdSucursal ON 
                         in_movi_inve.IdEmpresa = tb_bodega.IdEmpresa AND in_movi_inve.IdSucursal = tb_bodega.IdSucursal AND in_movi_inve.IdBodega = tb_bodega.IdBodega
WHERE        (in_movi_inve_detalle.mv_tipo_movi = N'-')