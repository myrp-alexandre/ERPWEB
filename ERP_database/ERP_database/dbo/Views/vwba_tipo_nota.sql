CREATE VIEW [dbo].[vwba_tipo_nota]
AS
SELECT        dbo.ba_tipo_nota.IdEmpresa, dbo.ba_tipo_nota.IdTipoNota, dbo.ba_tipo_nota.Tipo, dbo.ba_tipo_nota.Descripcion, dbo.ba_tipo_nota.IdCtaCble, 
                         dbo.ct_plancta.pc_Cuenta AS nom_CtaCble, dbo.ba_tipo_nota.IdCentroCosto, dbo.ct_centro_costo.Centro_costo AS nom_CentroCosto, dbo.ba_tipo_nota.Estado
FROM            dbo.ba_tipo_nota LEFT OUTER JOIN
                         dbo.ct_centro_costo ON dbo.ba_tipo_nota.IdCentroCosto = dbo.ct_centro_costo.IdCentroCosto AND 
                         dbo.ba_tipo_nota.IdEmpresa = dbo.ct_centro_costo.IdEmpresa LEFT OUTER JOIN
                         dbo.ct_plancta ON dbo.ba_tipo_nota.IdCtaCble = dbo.ct_plancta.IdCtaCble AND dbo.ba_tipo_nota.IdEmpresa = dbo.ct_plancta.IdEmpresa
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[30] 4[32] 2[21] 3) )"
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
         Begin Table = "ba_tipo_nota"
            Begin Extent = 
               Top = 0
               Left = 254
               Bottom = 129
               Right = 463
            End
            DisplayFlags = 280
            TopColumn = 3
         End
         Begin Table = "ct_centro_costo"
            Begin Extent = 
               Top = 0
               Left = 509
               Bottom = 129
               Right = 718
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ct_plancta"
            Begin Extent = 
               Top = 0
               Left = 0
               Bottom = 129
               Right = 209
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwba_tipo_nota';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwba_tipo_nota';

