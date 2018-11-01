CREATE view [dbo].[vwBAN_Rpt011]
as
SELECT        A.IdEmpresa, A.IdConciliacion, A.IdBanco, A.IdPeriodo, dbo.ba_Banco_Cuenta.ba_descripcion AS nom_banco, dbo.ba_Banco_Cuenta.ba_Num_Cuenta, 
                         dbo.ba_Banco_Cuenta.IdCtaCble, dbo.ba_Cbte_Ban.cb_Fecha AS Fecha, dbo.ct_cbtecble_tipo.CodTipoCbte, dbo.ct_cbtecble_tipo.tc_TipoCbte AS Tipo_Cbte, 
                         dbo.ct_cbtecble_det.dc_Valor AS Valor, dbo.ct_cbtecble_det.dc_Observacion AS Observacion, dbo.ba_Cbte_Ban.cb_Cheque AS Cheque, NULL AS Titulo_grupo, NULL 
                         AS referencia, dbo.tb_empresa.em_ruc AS ruc_empresa, dbo.tb_empresa.em_nombre AS nom_empresa
FROM            dbo.ct_cbtecble_tipo INNER JOIN
                         dbo.ct_cbtecble_det ON dbo.ct_cbtecble_tipo.IdTipoCbte = dbo.ct_cbtecble_det.IdTipoCbte INNER JOIN
                         dbo.ba_Cbte_Ban ON dbo.ct_cbtecble_det.IdEmpresa = dbo.ba_Cbte_Ban.IdEmpresa AND dbo.ct_cbtecble_det.IdTipoCbte = dbo.ba_Cbte_Ban.IdTipocbte AND 
                         dbo.ct_cbtecble_det.IdCbteCble = dbo.ba_Cbte_Ban.IdCbteCble INNER JOIN
                         dbo.ba_Conciliacion_det_IngEgr INNER JOIN
                         dbo.ba_Conciliacion AS A INNER JOIN
                         dbo.ba_Banco_Cuenta ON A.IdEmpresa = dbo.ba_Banco_Cuenta.IdEmpresa AND A.IdBanco = dbo.ba_Banco_Cuenta.IdBanco INNER JOIN
                         dbo.tb_empresa ON A.IdEmpresa = dbo.tb_empresa.IdEmpresa ON dbo.ba_Conciliacion_det_IngEgr.IdEmpresa = A.IdEmpresa AND 
                         dbo.ba_Conciliacion_det_IngEgr.IdConciliacion = A.IdConciliacion ON dbo.ba_Cbte_Ban.IdEmpresa = dbo.ba_Conciliacion_det_IngEgr.IdEmpresa AND 
                         dbo.ba_Cbte_Ban.IdCbteCble = dbo.ba_Conciliacion_det_IngEgr.IdCbteCble AND dbo.ba_Cbte_Ban.IdTipocbte = dbo.ba_Conciliacion_det_IngEgr.IdTipocbte
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[17] 4[13] 2[5] 3) )"
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
         Begin Table = "ct_cbtecble_tipo"
            Begin Extent = 
               Top = 179
               Left = 546
               Bottom = 308
               Right = 755
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ct_cbtecble_det"
            Begin Extent = 
               Top = 17
               Left = 872
               Bottom = 146
               Right = 1135
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ba_Cbte_Ban"
            Begin Extent = 
               Top = 38
               Left = 504
               Bottom = 250
               Right = 713
            End
            DisplayFlags = 280
            TopColumn = 3
         End
         Begin Table = "ba_Conciliacion_det_IngEgr"
            Begin Extent = 
               Top = 4
               Left = 474
               Bottom = 266
               Right = 683
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "A"
            Begin Extent = 
               Top = 1
               Left = 71
               Bottom = 349
               Right = 301
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ba_Banco_Cuenta"
            Begin Extent = 
               Top = 307
               Left = 297
               Bottom = 436
               Right = 525
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_empresa"
            Begin Extent = 
               Top = 468
               Left = 1000
               Bottom = 597
               Right = 1219
 ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwBAN_Rpt011';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'           End
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
         Column = 5085
         Alias = 2730
         Table = 3135
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwBAN_Rpt011';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwBAN_Rpt011';

