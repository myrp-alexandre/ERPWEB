
CREATE VIEW [dbo].[vwcxc_cobro_x_anticipo_total_respaldado]
AS
SELECT     cbr_ant_det.IdEmpresa, cbr_ant_det.IdAnticipo, cbr_ant_det.Secuencia AS Secuencia_ant, cbr_det.IdEmpresa AS IdEmpresa_cbr, 
                      cbr_det.IdSucursal AS IdSucursal_cbr, cbr_det.IdCobro AS IdCobro_cbr, SUM(cbr_det.dc_ValorPago) AS Total_Pagado
FROM         dbo.cxc_cobro_x_Anticipo_det AS cbr_ant_det INNER JOIN
                      dbo.cxc_cobro AS cbr ON cbr_ant_det.IdEmpresa_Cobro = cbr.IdEmpresa AND cbr_ant_det.IdSucursal_cobro = cbr.IdSucursal AND 
                      cbr_ant_det.IdCobro_cobro = cbr.IdCobro INNER JOIN
                      dbo.cxc_cobro_det AS cbr_det ON cbr.IdEmpresa = cbr_det.IdEmpresa AND cbr.IdSucursal = cbr_det.IdSucursal AND cbr.IdCobro = cbr_det.IdCobro
GROUP BY cbr_ant_det.IdEmpresa, cbr_ant_det.IdAnticipo, cbr_ant_det.Secuencia, cbr_det.IdEmpresa, cbr_det.IdSucursal, cbr_det.IdCobro
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[26] 4[35] 2[21] 3) )"
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
         Begin Table = "cbr_ant_det"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 229
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cbr"
            Begin Extent = 
               Top = 6
               Left = 267
               Bottom = 125
               Right = 462
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cbr_det"
            Begin Extent = 
               Top = 25
               Left = 729
               Bottom = 207
               Right = 925
            End
            DisplayFlags = 280
            TopColumn = 4
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
      Begin ColumnWidths = 12
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcxc_cobro_x_anticipo_total_respaldado';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcxc_cobro_x_anticipo_total_respaldado';

