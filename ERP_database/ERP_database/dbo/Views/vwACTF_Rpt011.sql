

CREATE VIEW [dbo].[vwACTF_Rpt011] AS
SELECT        dbo.Af_Depreciacion.IdEmpresa, dbo.Af_Depreciacion.IdDepreciacion, dbo.Af_Depreciacion.IdPeriodo, dbo.Af_Activo_fijo.Af_Nombre AS nom_activo, 
                         dbo.Af_Activo_fijo.Af_costo_compra, dbo.Af_Depreciacion_Det.Valor_Depre_Acum, 
                         dbo.Af_Depreciacion_Det.Valor_Depreciacion AS Dep_Actual, dbo.Af_Depreciacion_Det.Porc_Depreciacion, 
                         dbo.Af_Depreciacion.Estado, dbo.Af_Activo_fijo_tipo.IdActivoFijoTipo, 
                         dbo.Af_Activo_fijo_tipo.Af_Descripcion AS nom_ActijoFijoTipo, dbo.Af_Activo_fijo_Categoria.IdCategoriaAF, 
                         dbo.Af_Activo_fijo_Categoria.Descripcion AS nom_CategoriaAF, dbo.Af_Activo_fijo.Af_fecha_compra
FROM            dbo.Af_Activo_fijo INNER JOIN
                         dbo.Af_Depreciacion_Det ON dbo.Af_Activo_fijo.IdEmpresa = dbo.Af_Depreciacion_Det.IdEmpresa AND 
                         dbo.Af_Activo_fijo.IdActivoFijo = dbo.Af_Depreciacion_Det.IdActivoFijo INNER JOIN
                         dbo.Af_Depreciacion ON dbo.Af_Depreciacion_Det.IdEmpresa = dbo.Af_Depreciacion.IdEmpresa AND 
                         dbo.Af_Depreciacion_Det.IdDepreciacion = dbo.Af_Depreciacion.IdDepreciacion  AND dbo.Af_Depreciacion.Estado = 'A' INNER JOIN
                         dbo.Af_Activo_fijo_Categoria ON dbo.Af_Activo_fijo.IdEmpresa = dbo.Af_Activo_fijo_Categoria.IdEmpresa AND 
                         dbo.Af_Activo_fijo.IdCategoriaAF = dbo.Af_Activo_fijo_Categoria.IdCategoriaAF AND 
                         dbo.Af_Activo_fijo.IdActivoFijoTipo = dbo.Af_Activo_fijo_Categoria.IdActivoFijoTipo INNER JOIN
                         dbo.Af_Activo_fijo_tipo ON dbo.Af_Activo_fijo_Categoria.IdEmpresa = dbo.Af_Activo_fijo_tipo.IdEmpresa AND 
                         dbo.Af_Activo_fijo_Categoria.IdActivoFijoTipo = dbo.Af_Activo_fijo_tipo.IdActivoFijoTipo

GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[44] 4[4] 2[41] 3) )"
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
         Begin Table = "Af_Activo_fijo"
            Begin Extent = 
               Top = 148
               Left = 447
               Bottom = 340
               Right = 676
            End
            DisplayFlags = 280
            TopColumn = 12
         End
         Begin Table = "Af_Depreciacion_Det"
            Begin Extent = 
               Top = 6
               Left = 305
               Bottom = 135
               Right = 514
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Af_Depreciacion"
            Begin Extent = 
               Top = 6
               Left = 552
               Bottom = 135
               Right = 761
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Af_Tipo_Depreciacion"
            Begin Extent = 
               Top = 6
               Left = 1074
               Bottom = 135
               Right = 1287
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Af_Activo_fijo_Categoria"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 267
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Af_Activo_fijo_tipo"
            Begin Extent = 
               Top = 6
               Left = 799
               Bottom = 135
               Right = 1036
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 16
   ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwACTF_Rpt011';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'      Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 3645
         Width = 1500
         Width = 1500
         Width = 2295
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 2835
         Alias = 3720
         Table = 4425
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwACTF_Rpt011';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwACTF_Rpt011';

