CREATE VIEW [Fj_servindustrias].[vwct_distribucion_gastos_x_periodo_det_para_distribuir]
AS
SELECT dbo.ct_plancta.IdEmpresa, dbo.ct_plancta.IdCtaCble, dbo.ct_plancta.pc_Cuenta, dbo.ct_cbtecble.IdPeriodo, ROUND(ISNULL(dis_det.valor_dis, 0),2) AS valor_dis, 

ROUND(ISNULL(ROUND(SUM(dbo.ct_cbtecble_det.dc_Valor), 2), 0) - ISNULL(dis_det.valor_dis, 0),2)
 AS dc_Valor


FROM     dbo.ct_cbtecble INNER JOIN
                  dbo.ct_cbtecble_det ON dbo.ct_cbtecble.IdEmpresa = dbo.ct_cbtecble_det.IdEmpresa AND dbo.ct_cbtecble.IdTipoCbte = dbo.ct_cbtecble_det.IdTipoCbte AND dbo.ct_cbtecble.IdCbteCble = dbo.ct_cbtecble_det.IdCbteCble INNER JOIN
                  dbo.ct_plancta ON dbo.ct_cbtecble_det.IdEmpresa = dbo.ct_plancta.IdEmpresa AND dbo.ct_cbtecble_det.IdCtaCble = dbo.ct_plancta.IdCtaCble INNER JOIN
                  dbo.ct_grupocble ON dbo.ct_plancta.IdGrupoCble = dbo.ct_grupocble.IdGrupoCble LEFT OUTER JOIN
                      (SELECT dg.IdEmpresa, dg.IdCtaCble, dc.IdPeriodo, SUM(dg.valor) AS valor_dis
                       FROM      Fj_servindustrias.ct_distribucion_gastos_x_periodo_det AS dg INNER JOIN
                                         Fj_servindustrias.ct_distribucion_gastos_x_periodo AS dc ON dg.IdEmpresa = dc.IdEmpresa AND dg.IdDistribucion = dc.IdDistribucion
                       GROUP BY dg.IdEmpresa, dg.IdCtaCble, dc.IdPeriodo) AS dis_det ON dbo.ct_cbtecble_det.IdCtaCble = dis_det.IdCtaCble AND dbo.ct_cbtecble_det.IdEmpresa = dis_det.IdEmpresa AND 
                  dbo.ct_cbtecble_det.IdCtaCble = dbo.ct_plancta.IdCtaCble AND dbo.ct_cbtecble.IdPeriodo = dis_det.IdPeriodo
WHERE  (dbo.ct_grupocble.gc_estado_financiero = 'ER') AND (dbo.ct_cbtecble_det.IdPunto_cargo IS NULL)
GROUP BY dbo.ct_plancta.IdEmpresa, dbo.ct_plancta.IdCtaCble, dbo.ct_plancta.pc_Cuenta, dbo.ct_cbtecble.IdPeriodo, dis_det.valor_dis
HAVING (ROUND(SUM(dbo.ct_cbtecble_det.dc_Valor), 2) <> 0)
AND ROUND(ISNULL(ROUND(SUM(dbo.ct_cbtecble_det.dc_Valor), 2), 0) - ISNULL(dis_det.valor_dis, 0),2) != 0
AND (ROUND(ISNULL(ABS(SUM(dbo.ct_cbtecble_det.dc_Valor)),0),2) != ROUND(ABS(ISNULL(dis_det.valor_dis, 0)),2))
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[89] 4[3] 2[3] 3) )"
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
         Left = -21
      End
      Begin Tables = 
         Begin Table = "ct_cbtecble"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 170
               Right = 276
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ct_cbtecble_det"
            Begin Extent = 
               Top = 86
               Left = 898
               Bottom = 345
               Right = 1223
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ct_plancta"
            Begin Extent = 
               Top = 343
               Left = 48
               Bottom = 506
               Right = 290
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ct_grupocble"
            Begin Extent = 
               Top = 511
               Left = 48
               Bottom = 674
               Right = 298
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "dis_det"
            Begin Extent = 
               Top = 65
               Left = 480
               Bottom = 228
               Right = 690
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
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         A', @level0type = N'SCHEMA', @level0name = N'Fj_servindustrias', @level1type = N'VIEW', @level1name = N'vwct_distribucion_gastos_x_periodo_det_para_distribuir';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'lias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'Fj_servindustrias', @level1type = N'VIEW', @level1name = N'vwct_distribucion_gastos_x_periodo_det_para_distribuir';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'Fj_servindustrias', @level1type = N'VIEW', @level1name = N'vwct_distribucion_gastos_x_periodo_det_para_distribuir';

