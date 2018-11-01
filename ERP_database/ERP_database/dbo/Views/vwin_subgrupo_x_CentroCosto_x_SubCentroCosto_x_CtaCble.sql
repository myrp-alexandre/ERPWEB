CREATE view [dbo].[vwin_subgrupo_x_CentroCosto_x_SubCentroCosto_x_CtaCble]
as
SELECT        isnull(ROW_NUMBER() OVER (ORDER BY in_subgrupo_x_CentroCosto_x_SubCentroCosto_x_CtaCble.IdEmpresa), 0) AS IdRow, 
in_subgrupo_x_CentroCosto_x_SubCentroCosto_x_CtaCble.IdEmpresa, in_subgrupo_x_CentroCosto_x_SubCentroCosto_x_CtaCble.IdCategoria, 
in_categorias.ca_Categoria AS nom_categoria, in_subgrupo_x_CentroCosto_x_SubCentroCosto_x_CtaCble.IdLinea, in_linea.nom_linea, 
in_subgrupo_x_CentroCosto_x_SubCentroCosto_x_CtaCble.IdGrupo, in_grupo.nom_grupo, in_subgrupo_x_CentroCosto_x_SubCentroCosto_x_CtaCble.IdSubgrupo, 
in_subgrupo.nom_subgrupo, in_subgrupo_x_CentroCosto_x_SubCentroCosto_x_CtaCble.IdCentroCosto, ct_centro_costo.Centro_costo AS nom_centro_costo, 
in_subgrupo_x_CentroCosto_x_SubCentroCosto_x_CtaCble.IdSub_centro_costo, ct_centro_costo_sub_centro_costo.Centro_costo AS nom_sub_centro_costo, 
in_subgrupo_x_CentroCosto_x_SubCentroCosto_x_CtaCble.IdCtaCble
FROM            in_subgrupo INNER JOIN
                         in_subgrupo_x_CentroCosto_x_SubCentroCosto_x_CtaCble ON in_subgrupo.IdEmpresa = in_subgrupo_x_CentroCosto_x_SubCentroCosto_x_CtaCble.IdEmpresa AND
                          in_subgrupo.IdCategoria = in_subgrupo_x_CentroCosto_x_SubCentroCosto_x_CtaCble.IdCategoria AND 
                         in_subgrupo.IdLinea = in_subgrupo_x_CentroCosto_x_SubCentroCosto_x_CtaCble.IdLinea AND 
                         in_subgrupo.IdGrupo = in_subgrupo_x_CentroCosto_x_SubCentroCosto_x_CtaCble.IdGrupo AND 
                         in_subgrupo.IdSubgrupo = in_subgrupo_x_CentroCosto_x_SubCentroCosto_x_CtaCble.IdSubgrupo INNER JOIN
                         in_grupo INNER JOIN
                         in_linea ON in_grupo.IdEmpresa = in_linea.IdEmpresa AND in_grupo.IdCategoria = in_linea.IdCategoria AND in_grupo.IdLinea = in_linea.IdLinea INNER JOIN
                         in_categorias ON in_linea.IdEmpresa = in_categorias.IdEmpresa AND in_linea.IdCategoria = in_categorias.IdCategoria ON 
                         in_subgrupo.IdEmpresa = in_grupo.IdEmpresa AND in_subgrupo.IdCategoria = in_grupo.IdCategoria AND in_subgrupo.IdLinea = in_grupo.IdLinea AND 
                         in_subgrupo.IdGrupo = in_grupo.IdGrupo INNER JOIN
                         ct_centro_costo_sub_centro_costo ON in_subgrupo_x_CentroCosto_x_SubCentroCosto_x_CtaCble.IdEmpresa = ct_centro_costo_sub_centro_costo.IdEmpresa AND 
                         in_subgrupo_x_CentroCosto_x_SubCentroCosto_x_CtaCble.IdCentroCosto = ct_centro_costo_sub_centro_costo.IdCentroCosto AND 
                         in_subgrupo_x_CentroCosto_x_SubCentroCosto_x_CtaCble.IdSub_centro_costo = ct_centro_costo_sub_centro_costo.IdCentroCosto_sub_centro_costo INNER JOIN
                         ct_centro_costo ON ct_centro_costo_sub_centro_costo.IdEmpresa = ct_centro_costo.IdEmpresa AND 
                         ct_centro_costo_sub_centro_costo.IdCentroCosto = ct_centro_costo.IdCentroCosto
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[13] 4[5] 2[65] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwin_subgrupo_x_CentroCosto_x_SubCentroCosto_x_CtaCble';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwin_subgrupo_x_CentroCosto_x_SubCentroCosto_x_CtaCble';

