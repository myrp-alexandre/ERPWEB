CREATE VIEW Fj_servindustrias.vwACTF_FJ_Rpt003
AS
SELECT        Fj_servindustrias.Af_Activo_fijo_x_ct_centro_costo_sub_centro_costo.IdEmpresa_AF, dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto_sub_centro_costo, 
                         Fj_servindustrias.Af_Activo_fijo_x_ct_centro_costo_sub_centro_costo.IdCentroCosto_Scc, 
                         Fj_servindustrias.Af_Activo_fijo_x_ct_centro_costo_sub_centro_costo.IdCentroCosto_sub_centro_costo_Scc, dbo.Af_Activo_fijo_Categoria.IdCategoriaAF, 
                         dbo.Af_Activo_fijo_tipo.IdActivoFijoTipo IdActijoFijoTipo, dbo.Af_Activo_fijo.IdActivoFijo, dbo.Af_Activo_fijo_Categoria.Descripcion AS Categoria, 
                         dbo.Af_Activo_fijo_tipo.Af_Descripcion AS Tipo, dbo.ct_centro_costo_sub_centro_costo.Centro_costo AS [Subcentro Costo], dbo.ct_centro_costo.Centro_costo, 
                         dbo.Af_Activo_fijo.Af_Nombre, dbo.Af_Activo_fijo.CodActivoFijo, dbo.Af_Activo_fijo.Af_DescripcionCorta, 
                         Fj_servindustrias.Af_Activo_fijo_x_ct_centro_costo_sub_centro_costo.Estado
FROM            dbo.ct_centro_costo_sub_centro_costo INNER JOIN
                         dbo.ct_centro_costo ON dbo.ct_centro_costo_sub_centro_costo.IdEmpresa = dbo.ct_centro_costo.IdEmpresa AND 
                         dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto = dbo.ct_centro_costo.IdCentroCosto INNER JOIN
                         Fj_servindustrias.Af_Activo_fijo_x_ct_centro_costo_sub_centro_costo ON 
                         dbo.ct_centro_costo_sub_centro_costo.IdEmpresa = Fj_servindustrias.Af_Activo_fijo_x_ct_centro_costo_sub_centro_costo.IdEmpresa_Scc AND 
                         dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto = Fj_servindustrias.Af_Activo_fijo_x_ct_centro_costo_sub_centro_costo.IdCentroCosto_Scc AND 
                         dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto_sub_centro_costo = Fj_servindustrias.Af_Activo_fijo_x_ct_centro_costo_sub_centro_costo.IdCentroCosto_sub_centro_costo_Scc
                          INNER JOIN
                         dbo.Af_Activo_fijo ON Fj_servindustrias.Af_Activo_fijo_x_ct_centro_costo_sub_centro_costo.IdEmpresa_AF = dbo.Af_Activo_fijo.IdEmpresa AND 
                         Fj_servindustrias.Af_Activo_fijo_x_ct_centro_costo_sub_centro_costo.IdActivoFijo_AF = dbo.Af_Activo_fijo.IdActivoFijo INNER JOIN
                         dbo.Af_Activo_fijo_Categoria ON dbo.Af_Activo_fijo.IdEmpresa = dbo.Af_Activo_fijo_Categoria.IdEmpresa AND 
                         dbo.Af_Activo_fijo.IdCategoriaAF = dbo.Af_Activo_fijo_Categoria.IdCategoriaAF AND dbo.Af_Activo_fijo.IdEmpresa = dbo.Af_Activo_fijo_Categoria.IdEmpresa AND 
                         dbo.Af_Activo_fijo.IdCategoriaAF = dbo.Af_Activo_fijo_Categoria.IdCategoriaAF INNER JOIN
                         dbo.Af_Activo_fijo_tipo ON dbo.Af_Activo_fijo.IdEmpresa = dbo.Af_Activo_fijo_tipo.IdEmpresa AND 
                         dbo.Af_Activo_fijo.IdActivoFijoTipo = dbo.Af_Activo_fijo_tipo.IdActivoFijoTipo AND dbo.Af_Activo_fijo.IdEmpresa = dbo.Af_Activo_fijo_tipo.IdEmpresa AND 
                         dbo.Af_Activo_fijo.IdActivoFijoTipo = dbo.Af_Activo_fijo_tipo.IdActivoFijoTipo AND dbo.Af_Activo_fijo_Categoria.IdEmpresa = dbo.Af_Activo_fijo_tipo.IdEmpresa AND 
                         dbo.Af_Activo_fijo_Categoria.IdActivoFijoTipo = dbo.Af_Activo_fijo_tipo.IdActivoFijoTipo AND 
                         dbo.Af_Activo_fijo_Categoria.IdEmpresa = dbo.Af_Activo_fijo_tipo.IdEmpresa AND 
                         dbo.Af_Activo_fijo_Categoria.IdActivoFijoTipo = dbo.Af_Activo_fijo_tipo.IdActivoFijoTipo
WHERE        (Fj_servindustrias.Af_Activo_fijo_x_ct_centro_costo_sub_centro_costo.Estado = 1)