CREATE VIEW [dbo].[vwcp_orden_pago_con_cancelacion_x_CbteBan_Debi]
AS
SELECT     A.IdEmpresa, A.IdTipo_op, A.Referencia, A.IdOrdenPago, A.Secuencia_OP, A.IdTipoPersona, A.IdPersona, A.IdEntidad, A.Fecha_OP, A.Fecha_Fa_Prov, 
                      A.Fecha_Venc_Fac_Prov, A.Observacion, A.Nom_Beneficiario, A.Girar_Cheque_a, A.Valor_a_pagar, A.Valor_estimado_a_pagar_OP, A.Total_cancelado_OP, 
                      A.Saldo_x_Pagar_OP, A.IdEstadoAprobacion, A.IdFormaPago, A.Fecha_Pago, A.IdCtaCble, A.IdCentroCosto, A.IdSubCentro_Costo, A.Cbte_cxp, A.Estado, 
                      A.Nom_Beneficiario_2, C.CodTipoCbteBan, A.IdEmpresa_cxp, A.IdTipoCbte_cxp, A.IdCbteCble_cxp, B.Idcancelacion, B.IdEmpresa_pago, B.IdTipoCbte_pago, 
                      B.IdCbteCble_pago, B.MontoAplicado, B.SaldoAnterior, B.SaldoActual
FROM         dbo.ba_Cbte_Ban_tipo_x_ct_CbteCble_tipo AS C INNER JOIN
                      dbo.cp_orden_pago_cancelaciones AS B INNER JOIN
                      dbo.vwcp_orden_pago_con_cancelacion AS A ON B.IdEmpresa = A.IdEmpresa AND B.IdEmpresa_op = A.IdEmpresa AND B.IdOrdenPago_op = A.IdOrdenPago AND 
                      B.Secuencia_op = A.Secuencia_OP ON C.IdTipoCbteCble = B.IdTipoCbte_pago AND C.IdEmpresa = B.IdEmpresa_pago
WHERE     (C.CodTipoCbteBan = 'NDBA')
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[46] 4[4] 2[4] 3) )"
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
         Begin Table = "A"
            Begin Extent = 
               Top = 7
               Left = 40
               Bottom = 260
               Right = 268
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "C"
            Begin Extent = 
               Top = 16
               Left = 995
               Bottom = 206
               Right = 1183
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "B"
            Begin Extent = 
               Top = 32
               Left = 436
               Bottom = 429
               Right = 641
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
      Begin ColumnWidths = 45
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcp_orden_pago_con_cancelacion_x_CbteBan_Debi';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'   Width = 1500
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
         Column = 2310
         Alias = 900
         Table = 2430
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcp_orden_pago_con_cancelacion_x_CbteBan_Debi';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcp_orden_pago_con_cancelacion_x_CbteBan_Debi';

