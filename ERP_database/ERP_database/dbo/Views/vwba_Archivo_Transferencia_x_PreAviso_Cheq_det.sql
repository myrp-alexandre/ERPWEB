

CREATE VIEW [dbo].[vwba_Archivo_Transferencia_x_PreAviso_Cheq_det]
AS

SELECT        ba_Archivo_Transferencia_x_PreAviso_Cheq_det.IdEmpresa, ba_Archivo_Transferencia_x_PreAviso_Cheq_det.IdArchivo_preaviso_cheq, 
                         ba_Archivo_Transferencia_x_PreAviso_Cheq_det.secuencia, ba_Archivo_Transferencia_x_PreAviso_Cheq_det.observacion_det, 
                         ba_Archivo_Transferencia_x_PreAviso_Cheq_det.IdEmpresa_mvba, ba_Archivo_Transferencia_x_PreAviso_Cheq_det.IdCbteCble_mvba, 
                         ba_Archivo_Transferencia_x_PreAviso_Cheq_det.IdTipocbte_mvba, ct_cbtecble_tipo.CodTipoCbte, ba_Cbte_Ban.cb_Fecha, ba_Cbte_Ban.cb_Observacion, 
                         ba_Cbte_Ban.cb_Valor, ba_Cbte_Ban.cb_Cheque, ba_Cbte_Ban.cb_giradoA, ba_Cbte_Ban.IdEstado_Preaviso_ch_cat
FROM            ba_Archivo_Transferencia_x_PreAviso_Cheq_det INNER JOIN
                         ba_Cbte_Ban ON ba_Archivo_Transferencia_x_PreAviso_Cheq_det.IdEmpresa_mvba = ba_Cbte_Ban.IdEmpresa AND 
                         ba_Archivo_Transferencia_x_PreAviso_Cheq_det.IdCbteCble_mvba = ba_Cbte_Ban.IdCbteCble AND 
                         ba_Archivo_Transferencia_x_PreAviso_Cheq_det.IdTipocbte_mvba = ba_Cbte_Ban.IdTipocbte INNER JOIN
                         ct_cbtecble_tipo ON ba_Cbte_Ban.IdEmpresa = ct_cbtecble_tipo.IdEmpresa AND ba_Cbte_Ban.IdTipocbte = ct_cbtecble_tipo.IdTipoCbte
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[70] 4[4] 2[7] 3) )"
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
         Top = -201
         Left = 0
      End
      Begin Tables = 
         Begin Table = "ba_Archivo_Transferencia_x_PreAviso_Cheq_det"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 258
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ba_Cbte_Ban"
            Begin Extent = 
               Top = 42
               Left = 430
               Bottom = 171
               Right = 652
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ct_cbtecble_tipo"
            Begin Extent = 
               Top = 166
               Left = 743
               Bottom = 295
               Right = 952
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwba_Archivo_Transferencia_x_PreAviso_Cheq_det';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwba_Archivo_Transferencia_x_PreAviso_Cheq_det';

