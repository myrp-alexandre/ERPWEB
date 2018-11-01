/*WHERE     (Con.IdEmpresa = 1) AND (Con.IdConciliacion = 1)*/
CREATE VIEW [dbo].[vwct_cbtecble_con_saldo_cxp_consulta]
AS
SELECT        Cbte.IdEmpresa, Cbte.IdCbteCble, Cbte.IdTipocbte, Cbte.cb_Fecha, Cbte.cb_Observacion, Cbte.referencia, Cbte.tc_TipoCbte, Cbte.Valor_cbte, 
                         Cbte.Valor_cancelado_cbte, Cbte.valor_Saldo_cbte, Cbte.Tipo, Con.IdConciliacion, Cbte.Beneficiario
FROM            dbo.vwcp_conciliacion_det_x_cbte_pago INNER JOIN
                         dbo.cp_conciliacion AS Con ON dbo.vwcp_conciliacion_det_x_cbte_pago.IdEmpresa = Con.IdEmpresa AND 
                         dbo.vwcp_conciliacion_det_x_cbte_pago.IdConciliacion = Con.IdConciliacion INNER JOIN
                         dbo.vwct_cbtecble_con_saldo_cxp AS Cbte ON dbo.vwcp_conciliacion_det_x_cbte_pago.IdEmpresa_pago = Cbte.IdEmpresa AND 
                         dbo.vwcp_conciliacion_det_x_cbte_pago.IdCbteCble_pago = Cbte.IdCbteCble AND dbo.vwcp_conciliacion_det_x_cbte_pago.IdTipoCbte_pago = Cbte.IdTipocbte
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[4] 2[23] 3) )"
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
         Begin Table = "vwcp_conciliacion_det_x_cbte_pago"
            Begin Extent = 
               Top = 0
               Left = 253
               Bottom = 204
               Right = 471
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Con"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 196
               Right = 206
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Cbte"
            Begin Extent = 
               Top = 14
               Left = 624
               Bottom = 217
               Right = 818
            End
            DisplayFlags = 280
            TopColumn = 9
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 13
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 2730
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
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwct_cbtecble_con_saldo_cxp_consulta';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwct_cbtecble_con_saldo_cxp_consulta';

