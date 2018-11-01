CREATE VIEW [dbo].[vwINV_Rpt019]
AS
SELECT        dbo.in_movi_inve.IdEmpresa, dbo.in_movi_inve.IdSucursal, dbo.in_movi_inve.IdBodega, dbo.in_movi_inve.IdMovi_inven_tipo, dbo.in_movi_inve.IdNumMovi, 
                         dbo.in_movi_inve.CodMoviInven, dbo.in_movi_inve.cm_tipo, dbo.in_Ing_Egr_Inven.cm_fecha, dbo.in_movi_inve_detalle.Secuencia, 
                         dbo.in_movi_inve_detalle.IdProducto, dbo.in_movi_inve_detalle.dm_cantidad, dbo.in_movi_inve_detalle.dm_observacion, dbo.in_movi_inve_detalle.mv_costo, 
                         dbo.tb_empresa.em_nombre AS nom_empresa, dbo.tb_empresa.em_ruc AS ruc_empresa, dbo.tb_sucursal.Su_Descripcion AS nom_sucursal, 
                         dbo.tb_bodega.bo_Descripcion AS nom_bodega, dbo.in_movi_inven_tipo.tm_descripcion AS nom_tipo_inven, dbo.in_Producto.pr_codigo AS cod_producto, 
                         dbo.in_Producto.pr_descripcion AS nom_producto, dbo.ct_centro_costo.Centro_costo AS nom_centro_costo, 
                         dbo.ct_centro_costo_sub_centro_costo.Centro_costo AS nom_subcentro_costo, ISNULL(dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto_sub_centro_costo, '') 
                         AS IdSubcentro_costo, ISNULL(dbo.ct_centro_costo.IdCentroCosto, '') AS IdCentro_costo, dbo.in_Ing_Egr_Inven_det.IdNumMovi AS Id_ing_egr, 
                         dbo.cp_proveedor.IdProveedor, dbo.tb_persona.pe_nombreCompleto AS nom_proveedor, dbo.com_ordencompra_local.IdOrdenCompra, 
                         dbo.in_Ing_Egr_Inven_det.IdMotivo_Inv, dbo.in_Motivo_Inven.Desc_mov_inv
FROM            dbo.tb_bodega INNER JOIN
                         dbo.in_movi_inve INNER JOIN
                         dbo.in_movi_inve_detalle ON dbo.in_movi_inve.IdEmpresa = dbo.in_movi_inve_detalle.IdEmpresa AND 
                         dbo.in_movi_inve.IdSucursal = dbo.in_movi_inve_detalle.IdSucursal AND dbo.in_movi_inve.IdBodega = dbo.in_movi_inve_detalle.IdBodega AND 
                         dbo.in_movi_inve.IdMovi_inven_tipo = dbo.in_movi_inve_detalle.IdMovi_inven_tipo AND dbo.in_movi_inve.IdNumMovi = dbo.in_movi_inve_detalle.IdNumMovi ON 
                         dbo.tb_bodega.IdEmpresa = dbo.in_movi_inve.IdEmpresa AND dbo.tb_bodega.IdSucursal = dbo.in_movi_inve.IdSucursal AND 
                         dbo.tb_bodega.IdBodega = dbo.in_movi_inve.IdBodega INNER JOIN
                         dbo.tb_empresa INNER JOIN
                         dbo.tb_sucursal ON dbo.tb_empresa.IdEmpresa = dbo.tb_sucursal.IdEmpresa ON dbo.tb_bodega.IdEmpresa = dbo.tb_sucursal.IdEmpresa AND 
                         dbo.tb_bodega.IdSucursal = dbo.tb_sucursal.IdSucursal INNER JOIN
                         dbo.in_Producto ON dbo.in_movi_inve_detalle.IdEmpresa = dbo.in_Producto.IdEmpresa AND 
                         dbo.in_movi_inve_detalle.IdProducto = dbo.in_Producto.IdProducto INNER JOIN
                         dbo.in_movi_inven_tipo ON dbo.in_movi_inve.IdEmpresa = dbo.in_movi_inven_tipo.IdEmpresa AND 
                         dbo.in_movi_inve.IdMovi_inven_tipo = dbo.in_movi_inven_tipo.IdMovi_inven_tipo INNER JOIN
                         dbo.in_Ing_Egr_Inven_det ON dbo.in_movi_inve_detalle.IdEmpresa = dbo.in_Ing_Egr_Inven_det.IdEmpresa_inv AND 
                         dbo.in_movi_inve_detalle.IdSucursal = dbo.in_Ing_Egr_Inven_det.IdSucursal_inv AND 
                         dbo.in_movi_inve_detalle.IdBodega = dbo.in_Ing_Egr_Inven_det.IdBodega_inv AND 
                         dbo.in_movi_inve_detalle.IdMovi_inven_tipo = dbo.in_Ing_Egr_Inven_det.IdMovi_inven_tipo_inv AND 
                         dbo.in_movi_inve_detalle.IdNumMovi = dbo.in_Ing_Egr_Inven_det.IdNumMovi_inv AND 
                         dbo.in_movi_inve_detalle.Secuencia = dbo.in_Ing_Egr_Inven_det.secuencia_inv LEFT OUTER JOIN
                         dbo.in_Ing_Egr_Inven ON dbo.in_Ing_Egr_Inven_det.IdNumMovi = dbo.in_Ing_Egr_Inven.IdNumMovi AND 
                         dbo.in_Ing_Egr_Inven_det.IdMovi_inven_tipo = dbo.in_Ing_Egr_Inven.IdMovi_inven_tipo AND 
                         dbo.in_Ing_Egr_Inven_det.IdSucursal = dbo.in_Ing_Egr_Inven.IdSucursal AND 
                         dbo.in_Ing_Egr_Inven_det.IdEmpresa = dbo.in_Ing_Egr_Inven.IdEmpresa LEFT OUTER JOIN
                         dbo.ct_centro_costo_sub_centro_costo ON dbo.in_movi_inve_detalle.IdEmpresa = dbo.ct_centro_costo_sub_centro_costo.IdEmpresa AND 
                         dbo.in_movi_inve_detalle.IdCentroCosto_sub_centro_costo = dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto_sub_centro_costo AND 
                         dbo.in_movi_inve_detalle.IdCentroCosto = dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto LEFT OUTER JOIN
                         dbo.ct_centro_costo ON dbo.in_movi_inve_detalle.IdCentroCosto = dbo.ct_centro_costo.IdCentroCosto AND 
                         dbo.in_movi_inve_detalle.IdEmpresa = dbo.ct_centro_costo.IdEmpresa LEFT OUTER JOIN
                         dbo.in_Motivo_Inven ON dbo.in_Ing_Egr_Inven_det.IdMotivo_Inv = dbo.in_Motivo_Inven.IdMotivo_Inv AND 
                         dbo.in_Ing_Egr_Inven_det.IdEmpresa = dbo.in_Motivo_Inven.IdEmpresa LEFT OUTER JOIN
                         dbo.com_ordencompra_local_det INNER JOIN
                         dbo.com_ordencompra_local ON dbo.com_ordencompra_local_det.IdEmpresa = dbo.com_ordencompra_local.IdEmpresa AND 
                         dbo.com_ordencompra_local_det.IdSucursal = dbo.com_ordencompra_local.IdSucursal AND 
                         dbo.com_ordencompra_local_det.IdOrdenCompra = dbo.com_ordencompra_local.IdOrdenCompra INNER JOIN
                         dbo.cp_proveedor ON dbo.com_ordencompra_local.IdEmpresa = dbo.cp_proveedor.IdEmpresa AND 
                         dbo.com_ordencompra_local.IdProveedor = dbo.cp_proveedor.IdProveedor INNER JOIN
                         dbo.tb_persona ON dbo.cp_proveedor.IdPersona = dbo.tb_persona.IdPersona ON 
                         dbo.in_Ing_Egr_Inven_det.IdEmpresa_oc = dbo.com_ordencompra_local_det.IdEmpresa AND 
                         dbo.in_Ing_Egr_Inven_det.IdSucursal_oc = dbo.com_ordencompra_local_det.IdSucursal AND 
                         dbo.in_Ing_Egr_Inven_det.IdOrdenCompra = dbo.com_ordencompra_local_det.IdOrdenCompra AND 
                         dbo.in_Ing_Egr_Inven_det.Secuencia_oc = dbo.com_ordencompra_local_det.Secuencia