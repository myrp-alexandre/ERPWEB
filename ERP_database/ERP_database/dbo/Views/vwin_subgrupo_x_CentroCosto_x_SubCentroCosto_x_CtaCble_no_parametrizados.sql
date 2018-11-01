CREATE VIEW [dbo].[vwin_subgrupo_x_CentroCosto_x_SubCentroCosto_x_CtaCble_no_parametrizados]
AS
SELECT     isnull(ROW_NUMBER() OVER(ORDER BY vwin_subgrupo_x_CentroCosto_x_SubCentroCosto_sin_CtaCble.IdEmpresa),0)AS IdRow,  vwin_subgrupo_x_CentroCosto_x_SubCentroCosto_sin_CtaCble.IdEmpresa,vwin_subgrupo_x_CentroCosto_x_SubCentroCosto_sin_CtaCble.IdCategoria,
	 dbo.in_categorias.ca_Categoria,vwin_subgrupo_x_CentroCosto_x_SubCentroCosto_sin_CtaCble.IdLinea, dbo.in_linea.nom_linea, 
	 vwin_subgrupo_x_CentroCosto_x_SubCentroCosto_sin_CtaCble.IdGrupo,dbo.in_grupo.nom_grupo,vwin_subgrupo_x_CentroCosto_x_SubCentroCosto_sin_CtaCble.IdSubGrupo,
	  dbo.in_subgrupo.nom_subgrupo,vwin_subgrupo_x_CentroCosto_x_SubCentroCosto_sin_CtaCble.IdCentroCosto, 
                         dbo.ct_centro_costo.Centro_costo AS nom_Centro,vwin_subgrupo_x_CentroCosto_x_SubCentroCosto_sin_CtaCble.IdCentroCosto_sub_centro_costo,
						  dbo.ct_centro_costo_sub_centro_costo.Centro_costo AS nom_Subcentro
FROM            dbo.in_subgrupo INNER JOIN
                         dbo.in_grupo ON dbo.in_subgrupo.IdEmpresa = dbo.in_grupo.IdEmpresa AND dbo.in_subgrupo.IdCategoria = dbo.in_grupo.IdCategoria AND 
                         dbo.in_subgrupo.IdLinea = dbo.in_grupo.IdLinea AND dbo.in_subgrupo.IdGrupo = dbo.in_grupo.IdGrupo INNER JOIN
                         dbo.in_linea ON dbo.in_grupo.IdEmpresa = dbo.in_linea.IdEmpresa AND dbo.in_grupo.IdCategoria = dbo.in_linea.IdCategoria AND 
                         dbo.in_grupo.IdLinea = dbo.in_linea.IdLinea INNER JOIN
                         dbo.in_categorias ON dbo.in_linea.IdEmpresa = dbo.in_categorias.IdEmpresa AND dbo.in_linea.IdCategoria = dbo.in_categorias.IdCategoria INNER JOIN
                         dbo.vwin_subgrupo_x_CentroCosto_x_SubCentroCosto_sin_CtaCble ON 
                         dbo.in_subgrupo.IdEmpresa = dbo.vwin_subgrupo_x_CentroCosto_x_SubCentroCosto_sin_CtaCble.IdEmpresa AND 
                         dbo.in_subgrupo.IdCategoria = dbo.vwin_subgrupo_x_CentroCosto_x_SubCentroCosto_sin_CtaCble.IdCategoria AND 
                         dbo.in_subgrupo.IdLinea = dbo.vwin_subgrupo_x_CentroCosto_x_SubCentroCosto_sin_CtaCble.IdLinea AND 
                         dbo.in_subgrupo.IdGrupo = dbo.vwin_subgrupo_x_CentroCosto_x_SubCentroCosto_sin_CtaCble.IdGrupo AND 
                         dbo.in_subgrupo.IdSubgrupo = dbo.vwin_subgrupo_x_CentroCosto_x_SubCentroCosto_sin_CtaCble.IdSubGrupo INNER JOIN
                         dbo.ct_centro_costo_sub_centro_costo INNER JOIN
                         dbo.ct_centro_costo ON dbo.ct_centro_costo_sub_centro_costo.IdEmpresa = dbo.ct_centro_costo.IdEmpresa AND 
                         dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto = dbo.ct_centro_costo.IdCentroCosto ON 
                         dbo.vwin_subgrupo_x_CentroCosto_x_SubCentroCosto_sin_CtaCble.IdEmpresa = dbo.ct_centro_costo_sub_centro_costo.IdEmpresa AND 
                         dbo.vwin_subgrupo_x_CentroCosto_x_SubCentroCosto_sin_CtaCble.IdCentroCosto = dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto AND 
                         dbo.vwin_subgrupo_x_CentroCosto_x_SubCentroCosto_sin_CtaCble.IdCentroCosto_sub_centro_costo = dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto_sub_centro_costo
GROUP BY vwin_subgrupo_x_CentroCosto_x_SubCentroCosto_sin_CtaCble.IdEmpresa,vwin_subgrupo_x_CentroCosto_x_SubCentroCosto_sin_CtaCble.IdCategoria,
	 dbo.in_categorias.ca_Categoria,vwin_subgrupo_x_CentroCosto_x_SubCentroCosto_sin_CtaCble.IdLinea, dbo.in_linea.nom_linea, 
	 vwin_subgrupo_x_CentroCosto_x_SubCentroCosto_sin_CtaCble.IdGrupo,dbo.in_grupo.nom_grupo,vwin_subgrupo_x_CentroCosto_x_SubCentroCosto_sin_CtaCble.IdSubGrupo,
	  dbo.in_subgrupo.nom_subgrupo,vwin_subgrupo_x_CentroCosto_x_SubCentroCosto_sin_CtaCble.IdCentroCosto, 
                         dbo.ct_centro_costo.Centro_costo ,vwin_subgrupo_x_CentroCosto_x_SubCentroCosto_sin_CtaCble.IdCentroCosto_sub_centro_costo,
						  dbo.ct_centro_costo_sub_centro_costo.Centro_costo