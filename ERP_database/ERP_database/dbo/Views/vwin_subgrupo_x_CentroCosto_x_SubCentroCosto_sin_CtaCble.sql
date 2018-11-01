CREATE VIEW [dbo].[vwin_subgrupo_x_CentroCosto_x_SubCentroCosto_sin_CtaCble]
AS
SELECT        pro.IdEmpresa, pro.IdCategoria, pro.IdLinea, pro.IdGrupo, pro.IdSubGrupo, det.IdCentroCosto, det.IdCentroCosto_sub_centro_costo
FROM            dbo.in_Ing_Egr_Inven_det AS det INNER JOIN
                         dbo.in_Producto AS pro ON det.IdEmpresa = pro.IdEmpresa AND det.IdProducto = pro.IdProducto
WHERE        (pro.Aparece_modu_Ventas = 0) AND (det.IdCentroCosto IS NOT NULL) AND (det.IdCentroCosto_sub_centro_costo IS NOT NULL) AND (NOT EXISTS
                             (SELECT        IdEmpresa
                               FROM            dbo.in_subgrupo_x_CentroCosto_x_SubCentroCosto_x_CtaCble AS rel
                               WHERE        (IdEmpresa = pro.IdEmpresa) AND (IdCategoria = pro.IdCategoria) AND (IdLinea = pro.IdLinea) AND (IdGrupo = pro.IdGrupo) AND 
                                                         (IdSubgrupo = pro.IdSubGrupo) AND (IdCentroCosto = det.IdCentroCosto) AND (IdSub_centro_costo = det.IdCentroCosto_sub_centro_costo))) AND 
                         (det.dm_cantidad < 0)
GROUP BY pro.IdEmpresa, pro.IdCategoria, pro.IdLinea, pro.IdGrupo, pro.IdSubGrupo, det.IdCentroCosto, det.IdCentroCosto_sub_centro_costo