CREATE VIEW dbo.vwct_cbtecble_det
AS
SELECT        dbo.ct_cbtecble.IdEmpresa, dbo.ct_cbtecble.IdTipoCbte, dbo.ct_cbtecble.IdCbteCble, dbo.ct_cbtecble.IdPeriodo, dbo.ct_cbtecble.cb_Fecha, 
                         dbo.ct_cbtecble.cb_Observacion, dbo.ct_cbtecble.cb_Estado, dbo.ct_cbtecble.cb_Anio, dbo.ct_cbtecble.cb_mes, 'N' cb_Mayorizado, 
                         CAST(ISNULL(dbo.ct_cbtecble_det.dc_para_conciliar, 0) AS bit) AS cb_para_conciliar, dbo.ct_cbtecble_det.secuencia, dbo.ct_cbtecble_det.IdCtaCble, 
                         dbo.ct_cbtecble_det.IdCentroCosto, dbo.ct_cbtecble_det.IdCentroCosto_sub_centro_costo, dbo.ct_cbtecble_det.dc_Valor, dbo.ct_cbtecble_det.IdPunto_cargo, 
                         dbo.ct_cbtecble_det.IdPunto_cargo_grupo, dbo.ct_cbtecble_det.dc_Observacion
FROM            dbo.ct_cbtecble INNER JOIN
                         dbo.ct_cbtecble_det ON dbo.ct_cbtecble.IdEmpresa = dbo.ct_cbtecble_det.IdEmpresa AND dbo.ct_cbtecble.IdTipoCbte = dbo.ct_cbtecble_det.IdTipoCbte AND 
                         dbo.ct_cbtecble.IdCbteCble = dbo.ct_cbtecble_det.IdCbteCble
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[10] 4[52] 2[21] 3) )"
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
         Begin Table = "ct_cbtecble"
            Begin Extent = 
               Top = 6
               Left = 91
               Bottom = 204
               Right = 300
            End
            DisplayFlags = 280
            TopColumn = 14
         End
         Begin Table = "ct_cbtecble_det"
            Begin Extent = 
               Top = 5
               Left = 449
               Bottom = 192
               Right = 712
            End
            DisplayFlags = 280
            TopColumn = 7
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
         Column = 3015
         Alias = 3540
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwct_cbtecble_det';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwct_cbtecble_det';

