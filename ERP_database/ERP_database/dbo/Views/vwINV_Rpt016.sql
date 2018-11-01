
CREATE VIEW [dbo].[vwINV_Rpt016]
AS
SELECT        emp.IdEmpresa, emp.em_nombre AS nom_empresa, Suc.IdSucursal, Suc.Su_Descripcion AS nom_sucursal, Bod.IdBodega, Bod.bo_Descripcion AS nom_bodega, 
                         Tip_Mov.IdMovi_inven_tipo, Tip_Mov.tm_descripcion AS nom_Movi_inven_tipo, Prod.IdProducto, Prod.pr_descripcion AS nom_Producto, 
                         ISNULL(SubCen.IdCentroCosto_sub_centro_costo, '') AS IdSubCentro_Costo, ISNULL(SubCen.Centro_costo, '') AS nom_subCentroCosto, Uni.IdUnidadMedida, 
                         Uni.Descripcion AS nom_UnidadMedida, Movi_det.dm_cantidad, Movi_det.mv_costo, Movi_det.dm_cantidad * Movi_det.mv_costo AS SubTotal, Movi.IdNumMovi, 
                         Movi.cm_fecha AS Fecha, Tip_Mov.cm_tipo_movi, ISNULL(dbo.ct_centro_costo.IdCentroCosto, '') AS IdCentroCosto, ISNULL(dbo.ct_centro_costo.Centro_costo, '') 
                         AS nom_CentroCosto
FROM            dbo.in_movi_inve_detalle AS Movi_det INNER JOIN
                         dbo.in_Producto AS Prod ON Movi_det.IdEmpresa = Prod.IdEmpresa AND Movi_det.IdProducto = Prod.IdProducto INNER JOIN
                         dbo.tb_sucursal AS Suc INNER JOIN
                         dbo.tb_empresa AS emp ON Suc.IdEmpresa = emp.IdEmpresa INNER JOIN
                         dbo.tb_bodega AS Bod ON Suc.IdEmpresa = Bod.IdEmpresa AND Suc.IdSucursal = Bod.IdSucursal INNER JOIN
                         dbo.in_movi_inve AS Movi ON Bod.IdEmpresa = Movi.IdEmpresa AND Bod.IdSucursal = Movi.IdSucursal AND Bod.IdBodega = Movi.IdBodega ON 
                         Movi_det.IdEmpresa = Movi.IdEmpresa AND Movi_det.IdSucursal = Movi.IdSucursal AND Movi_det.IdBodega = Movi.IdBodega AND 
                         Movi_det.IdMovi_inven_tipo = Movi.IdMovi_inven_tipo AND Movi_det.IdNumMovi = Movi.IdNumMovi INNER JOIN
                         dbo.in_movi_inven_tipo AS Tip_Mov ON Movi.IdEmpresa = Tip_Mov.IdEmpresa AND Movi.IdMovi_inven_tipo = Tip_Mov.IdMovi_inven_tipo INNER JOIN
                         dbo.in_UnidadMedida AS Uni ON Movi_det.IdUnidadMedida = Uni.IdUnidadMedida LEFT OUTER JOIN
                         dbo.ct_centro_costo ON Movi_det.IdEmpresa = dbo.ct_centro_costo.IdEmpresa AND Movi_det.IdCentroCosto = dbo.ct_centro_costo.IdCentroCosto LEFT OUTER JOIN
                         dbo.ct_centro_costo_sub_centro_costo AS SubCen ON Movi_det.IdEmpresa = SubCen.IdEmpresa AND Movi_det.IdCentroCosto = SubCen.IdCentroCosto AND 
                         Movi_det.IdCentroCosto_sub_centro_costo = SubCen.IdCentroCosto_sub_centro_costo