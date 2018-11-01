CREATE VIEW [dbo].[vwin_Zona_vs_ct_Centro_Costo]
AS
SELECT     dbo.in_Zona_vs_CentroDeCosto.IdCentroCosto, dbo.ct_centro_costo.Centro_costo, dbo.in_Zona.IdZona, dbo.in_Zona.Zona, in_Zona_1.IdZona AS IdSubZona, 
                      in_Zona_1.Zona AS Subzona, dbo.in_Zona_vs_CentroDeCosto.CodigoZN, dbo.in_Zona_vs_CentroDeCosto.IdCtaCbleZona
FROM         dbo.in_Zona_vs_CentroDeCosto INNER JOIN
                      dbo.in_Zona ON dbo.in_Zona_vs_CentroDeCosto.IdEmpresaIdZona = dbo.in_Zona.IdEmpresa AND 
                      dbo.in_Zona_vs_CentroDeCosto.IdZona = dbo.in_Zona.IdZona INNER JOIN
                      dbo.ct_centro_costo ON dbo.in_Zona_vs_CentroDeCosto.IdEmpresaCentrCosot = dbo.ct_centro_costo.IdEmpresa AND 
                      dbo.in_Zona_vs_CentroDeCosto.IdCentroCosto = dbo.ct_centro_costo.IdCentroCosto INNER JOIN
                      dbo.in_Zona AS in_Zona_1 ON dbo.in_Zona_vs_CentroDeCosto.IdEmpresaIdZona = in_Zona_1.IdEmpresa AND 
                      dbo.in_Zona_vs_CentroDeCosto.IdSubZona = in_Zona_1.IdZona
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[34] 4[4] 2[8] 3) )"
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
         Begin Table = "in_Zona_1"
            Begin Extent = 
               Top = 47
               Left = 888
               Bottom = 166
               Right = 1048
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ct_centro_costo"
            Begin Extent = 
               Top = 6
               Left = 40
               Bottom = 126
               Right = 226
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_Zona_vs_CentroDeCosto"
            Begin Extent = 
               Top = 0
               Left = 392
               Bottom = 155
               Right = 587
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "in_Zona"
            Begin Extent = 
               Top = 0
               Left = 642
               Bottom = 157
               Right = 802
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
      Begin ColumnWidths = 9
         Width = 284
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
         ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwin_Zona_vs_ct_Centro_Costo';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwin_Zona_vs_ct_Centro_Costo';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwin_Zona_vs_ct_Centro_Costo';

