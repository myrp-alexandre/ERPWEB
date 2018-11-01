
create view [dbo].[vwct_centro_costo]

as
SELECT     dbo.ct_centro_costo.IdEmpresa, dbo.ct_centro_costo.IdCentroCosto, dbo.ct_centro_costo.CodCentroCosto, dbo.ct_centro_costo.Centro_costo, 
                      ct_centro_costo_1.Centro_costo AS Centro_costoPadre, dbo.ct_centro_costo.IdCentroCostoPadre, dbo.ct_centro_costo.IdCatalogo, 
                      dbo.ct_centro_costo.pc_EsMovimiento, dbo.ct_centro_costo.IdNivel, dbo.ct_centro_costo.pc_Estado, dbo.ct_centro_costo.IdCtaCble
FROM         dbo.ct_centro_costo LEFT OUTER JOIN
                      dbo.ct_centro_costo AS ct_centro_costo_1 ON dbo.ct_centro_costo.IdEmpresa = ct_centro_costo_1.IdEmpresa AND 
                      dbo.ct_centro_costo.IdCentroCostoPadre = ct_centro_costo_1.IdCentroCosto